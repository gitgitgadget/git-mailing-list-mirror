Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187A020373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbdCMUqV (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:46:21 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35575 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdCMUqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:46:19 -0400
Received: by mail-wm0-f51.google.com with SMTP id v186so49793032wmd.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HrYAaQNoYs7qwBird1y3NuDqynzUYnpmKTvEWfosn2s=;
        b=Oi4yTydFusTTRgJih3RN07WATo1Y/qorGjj2/h39NSEkcxo6mHUC7xDxTfrP2MSCn+
         uIcIhSBtR5IRKZdLUUov/Tr7Dv3+Y8aYDULrt/d96wvPIqwdN3dezdmScnodpeOZVls1
         6p4THn4vj5SpY9Jz3Xn76tRFzoCODUKbrqS9umRzfcCj2pig3gDt4z4KXJZhfXud1RvV
         GNxZZOhZLw04F+rzo9RVe8646xhNXUKHkq683rEiWf8corJsTxRSJIOJ7F6NdJXvw9hK
         Lt3SslfBjyz+rPiE0Hyfvh1rVSbBM6Pr+/mcxe1QZzpq6yCpC5H+BLRPW2RI3augE2Cr
         M65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HrYAaQNoYs7qwBird1y3NuDqynzUYnpmKTvEWfosn2s=;
        b=mwqdOl8LOW6enFCzTINsDX3DajBLL7FmoOQ2qR6uYzaJIHQCUpYy5gaI4ky2u8iTRP
         n1zvnMkcOfXK8uMbg1qHNQg/L61BEfnbfRVa5TSxGbufMyI6lb4gABktMEsb0GMSuldu
         yqc5rQmz/qmX69CLLT827oBoEFJKx8AJZLwVpS4U+lJlDzO8H7kVBJQq/EqoLpe2OZxx
         4uPkHbrLqsF2ZHktVSODdI7JsNRa03zT6LEr2kk+envnS4js5S1zzd1YPXE5tX+Ho/fw
         5NsANs71Qx1g5kT6xBKAzSPaegOruUxZW8PyLDev4dgsphiHevD4XqIoTqFo/dRBHbCp
         TUJw==
X-Gm-Message-State: AFeK/H3Lxl37ckG4fCFRE1ePXV11IioftpvIbXaIWcjhuh3NHPJcdqXY9CLF/Wk7AtEZ8A==
X-Received: by 10.28.74.69 with SMTP id x66mr11067272wma.124.1489437977277;
        Mon, 13 Mar 2017 13:46:17 -0700 (PDT)
Received: from workstation ([213.149.51.172])
        by smtp.gmail.com with ESMTPSA id v18sm26396249wrc.41.2017.03.13.13.46.16
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 13:46:16 -0700 (PDT)
Date:   Mon, 13 Mar 2017 21:46:14 +0100
From:   Domagoj Stolfa <domagoj.stolfa@gmail.com>
To:     git@vger.kernel.org
Subject: Re: Possible git blame bug?
Message-ID: <20170313204614.GA66050@workstation>
References: <20170313201104.GA32821@workstation>
 <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
 <20170313204401.GB80633@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20170313204401.GB80633@workstation>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
=20
> > The question is whether this is a bug or not, as --since=3D<year> might=
 not be a
> > valid filter.
>=20
> I do not think blame ever was designed to work with --since, so that
> is indeed the case. =20
>=20
> Making it work with --since=3D<date> might be a worthy addition.
> Patches welcome.
=20
Thanks for the information. I wasn't aware that it wasn't designed with tha=
t in
mind, though it would indicate to me that --since seems to work with git-bl=
ame
according to [1], but expects a date, as I have usually been using it. It a=
lso
seems to produce correct results on FreeBSD 12.0-CURRENT with git 2.11.1, e=
xcept
when given a filter such as --since=3D<year>, in which case perhaps nothing=
 should
be displayed?
=20
Could you please clarify which bits wouldn't work with --since in git-blame?
=20
[1] https://www.git-scm.com/docs/git-blame
=20
--=20
Best regards,
Domagoj Stolfa

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHQB+y96lmmv+IXofwxT+ikb0YU4FAljHBRUACgkQwxT+ikb0
YU7HhQgAnURWJFsWhS6Oo33StrX84tLU7McZO3jU+pOdRe1MFuF62AtnQcWgjOS2
pHs/Hmph2qNd46+s0D06uhdC/EVWHMpcpLIXOlPJtfqhAyv8RHuFq8/CWYSXmI0U
RceBcqmgGtvpFGEH9AXuESTo7iDwqytTL9UL64oV4Ulqo6LuUHHvhQnKs8s5jNEU
ry3lJmMVuR0eIf+B2xz8tScalE3pOjpi1byY9Qw0ZxZCLoSHpUGlvsICxaSH3kvh
M1VRloMxcWgGlaUJFuohE8S10xRVcaZ6opkK48gf6rEwD+FOqK0ZhigmWBVYDKMw
r3o/4O8H5YWJqQD8jaCCSZt9y18yJg==
=LFML
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
