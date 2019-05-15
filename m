Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8370E1F461
	for <e@80x24.org>; Wed, 15 May 2019 22:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfEOW2H (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 18:28:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36540 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbfEOW2G (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 May 2019 18:28:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CE9DE60443;
        Wed, 15 May 2019 22:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557959281;
        bh=y5/7mMDCBzslbnd0YHj01Lx30/CC10yzY1xyEYjdruU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JULZJo7omWgdYgB0VvusN8nYP4P95YtFy9XOpU0vYzEMiFlPowa/hWy+thcguo0G3
         OGz3G//E2XX/mu3lT21EuLDjVHrpte/4dXBBcytLCdsJCn2QtzxladyM2/3MWTXIdj
         W+n5PfZs+HP/fCzP9W+OoDmW4NZBgd/tVUPcpStp3ugggTA6X1+aipthNjPE0uRfB2
         Q49xxQPzAEu4WAbzYqey6GXsGTPEATNvDek3Ic2AtwKADSytUJDURqo2PSFYveBm/+
         qYxVitOg3zah+jv/kd8LUHctKGA5cVWcT1+PTazbF2BF9LT+dyHR89PGLkCXL0SE2D
         Oa4MUIOiYkjU6KmQ3zjY4KjEqyaMutjIm96Vdm7kcOzI+OvCHmDT4LSyNNgx+c0lCF
         JZxkouj0UBLXurqd4v39rAbzKqWsH1Hf5Uup+2rOBcEUVQJs7s5iNn5rGNNXS5iDnO
         pp+j3I93nCVDzYMADd0yaiH+vpMZjpsQnhG7P4/RJYjPNkZitM1
Date:   Wed, 15 May 2019 22:27:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/7] run-command: add preliminary support for multiple
 hooks
Message-ID: <20190515222756.GJ7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-2-sandals@crustytoothpaste.net>
 <CACsJy8Ba98baQ2wZnMZyEva6gxO1ROZ4qJFTOdrCUXDMwrHnXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CxDuMX1Cv2n9FQfo"
Content-Disposition: inline
In-Reply-To: <CACsJy8Ba98baQ2wZnMZyEva6gxO1ROZ4qJFTOdrCUXDMwrHnXA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CxDuMX1Cv2n9FQfo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 07:46:17PM +0700, Duy Nguyen wrote:
> On Tue, May 14, 2019 at 7:24 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > -       argv_array_push(&hook.args, p);
> > -       while ((p =3D va_arg(args, const char *)))
> > -               argv_array_push(&hook.args, p);
> > -       hook.env =3D env;
> > +       strbuf_reset(&path);
> > +       strbuf_git_path(&path, "hooks/%s.d", name);
> > +       d =3D opendir(path.buf);
> > +       if (!d) {
> > +               if (list)
> > +                       string_list_clear(list, 0);
> > +               return 0;
> > +       }
> > +       while ((de =3D readdir(d))) {
> > +               if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, "..=
"))
> > +                       continue;
> > +               strbuf_reset(&path);
> > +               strbuf_git_path(&path, "hooks/%s.d/%s", name, de->d_nam=
e);
> > +               if (has_hook(&path, 0, X_OK)) {
>=20
> Do we want to support hooks in subdirectories as well (if so, using
> dir-iterator.h might be more appropriate)

No, I don't think so. That's not what most other software does, and I
don't really think recursive behavior provides a lot of value.

> If not, what happens when "path" is a directory. X_OK could be set
> (and often are) on them too.

We get an exec failure when trying to run it, just like if you create a
directory in place of the existing hook now. I think that's a fine
behavior.

> > +                       if (list)
> > +                               string_list_append(list, path.buf);
> > +                       else
> > +                               return 1;
> > +               }
> > +       }
> > +       closedir(d);
> > +       strbuf_reset(&path);
> > +       if (!list->nr) {
> > +               return 0;
> > +       }
> > +
> > +       string_list_sort(list);
>=20
> This is going to be interesting on case-insensitive filesystems
> because we do strcmp by default, not the friendlier fspathcmp. And the
> ".exe" suffix might affect sort order too.
>=20
> But I suppose we just need to be clear here (in documentation). They
> can always prefix with a number to keep hook files in expected order.

Numbering is definitely the way I'd go on a case-insensitive file
system. Also, I don't think the ".exe" will be a problem in practice,
since generally you'd have to have a mix of binary and non-binary hooks,
which is unlikely to be super common.

> > diff --git a/run-command.h b/run-command.h
> > index a6950691c0..1b3677fcac 100644
> > --- a/run-command.h
> > +++ b/run-command.h
> > @@ -4,6 +4,7 @@
> >  #include "thread-utils.h"
> >
> >  #include "argv-array.h"
> > +#include "string-list.h"
>=20
> 'struct string_list;' should be enough (and a bit lighter) although I
> don't suppose it really matters.

I can make that change.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--CxDuMX1Cv2n9FQfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzckmsACgkQv1NdgR9S
9ouEYw/+JSHgxP5JX1ZdvN5Iuj6n+sMD8GfT9DIbzACEvr2SwPxFTrMTHDuO6NrI
kPW+DOkdFMxeHos9lPAbJGcoQsCozYUeGYcudNwRtkYdsZuMfCnRn/wXge3hu32d
yDK+XoS4xHVVLCg3vawKjraWkNiMlFQgur2Jwpka0RMTabR0EEF6KLCxxPUQsL5x
YxHEZRgZze3SYcm0u2T5ue8nA/mwJvRbSD/Wtpby4q839mSRsgkD7Lv9pdXgdd/s
pmM9z9z/EynDDyDM67f8OxLyBO+IfK2JyIPxFyITFkkP92C3iIo/Zc5tvM5N8dSi
HJH9f35aW2DGyyisUtw6MHbMmOuPtj3w4XCuZmlV7bSiGmwxnE/D4Se92XmQ3ttL
ukuChyxAarciUoG8Le7XMg58VT0XEcYmOb2VXHz3T+K8goZn26Xd87xjYfxR/MDR
gkYpaG7NeNYxidL7QRIrciDFTyKZFbB62Vyd/TCAS3jqPAR1Cxz1yk1/dwlSHDAY
UXKgNJQ6J5oe75cJKOXXMVTqIWj5Smt88dZSAdC5Y/EUWcTrK7o1C8vafuQwz9e3
U8XQc2pMsMTFzmB2lJoLTpVJyA4uKwM08Y8HAUvhgUXFILSmEvusd7rfTZvbLaJs
5cnsk9po+n8sIApuRAScaHvoJ9zyR9amGPJh6DrMkyu+YaiJhXM=
=Miik
-----END PGP SIGNATURE-----

--CxDuMX1Cv2n9FQfo--
