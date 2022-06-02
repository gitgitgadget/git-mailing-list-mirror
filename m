Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EC1C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 21:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbiFBVsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbiFBVsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 17:48:04 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BE61DA6C
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 14:48:03 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 5534A5A26C;
        Thu,  2 Jun 2022 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1654206482;
        bh=eJSjrkyUEOLAXx0w2HZ5YI+X69f2zwMnj/HZtp1s/E4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=syx7MKuFPVoGLajZ/PxaXPF6GW5X9aX73OhriTdN+7h5HdvReXcsLQWs42e9LiW06
         W0nVO5CxIj9V9y+lqyJsF/+A1Cpedxp07VqaCO4wx+qm/WgtvoVWcfsl1qN2EzIpVO
         sfhqEUFVzngA28l1SLOp+jbJebUTdo/r6XvYjLHi+Jj+FrcRmbJCDJfi+MO7BOWBCM
         +tq/+VbjLYbDdiFDB5wflVI4WTXCEl+vlnP5loKWdKraGC5H1n6cbQVeq0ZMR/gxf1
         M4lHxi+MgnzqiKgfN396/eyuowoBODkbzP5EofA389m1YdkS3RFDziPoNDyGlZuNAI
         wZZwtWIiyD5ZGfh13cM08Lb83B8HHl7WGRqYedkKaVCjdMLgq87HhjnoK3S298/iEG
         Q15O3K+ob0y+i6Txv4MhetXkixK3H6ZkwzM/98TKb7y97FIMGGHg8mpJLAPdepxfUB
         6UJJUVBiisNv+mJ9v8v4OBE7uIrA7lJ3NT3DH/6vjzgJ/YYEUuc
Date:   Thu, 2 Jun 2022 21:47:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jason Yundt <jason@jasonyundt.email>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] gitweb: switch to an XHTML5 DOCTYPE
Message-ID: <YpkwD1op18MY/qBa@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jason Yundt <jason@jasonyundt.email>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20220601012647.1439480-1-jason@jasonyundt.email>
 <20220602114305.5915-1-jason@jasonyundt.email>
 <xmqqv8tinblc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3d90jXFZAaahC8W9"
Content-Disposition: inline
In-Reply-To: <xmqqv8tinblc.fsf@gitster.g>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3d90jXFZAaahC8W9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-02 at 18:50:55, Junio C Hamano wrote:
> Jason Yundt <jason@jasonyundt.email> writes:
>=20
> > Subject: Re: [PATCH v2] gitweb: switch to an XHTML5 DOCTYPE
> >
> > According to the HTML Standard FAQ:
> >
> > 	=E2=80=9CWhat is the DOCTYPE for modern HTML documents?
> > ...
> > Compared to the first version of this patch, this version:
> > 1. makes it clear that XML parsers may used the linked DTD like brian
> >    mentioned.
> > 2. mentions HTML5 like Bagas suggested.
>=20
> So, is it XHTML5, or HTML5, we want to see on the title?

It's XHTML 5.  Technically, it's the XML syntax of HTML 5, so I don't
think we care much about the nit here.

> > +proper_doctype() {
> > +	gitweb_run "$@" &&
> > +	grep -F "<!DOCTYPE html [" gitweb.body &&
> > +	grep "<!ENTITY nbsp" gitweb.body &&
> > +	grep "<!ENTITY sdot" gitweb.body
> > +}
>=20
> Hmph, this test does not care what other cruft appears in the file,
> does not care in what order the three lines that match the patterns
> appear, and the second and third patterns are even allowed to match
> the same line.  I think that is OK (we do not even mind if the two
> ENTITY definitions get squashed on the same line).

Yeah, that should be fine because IIRC this syntax isn't going to be
allowed elsewhere in the file.  If it did appear elsewhere, then the
user would receive an XML parsing error.

We _could_ make this check for beginning of file, the XML declaration,
and then the specified lines (e.g., with head(1)), but I don't really
think that's necessary. We should be fine here for now, and if we decide
we need that in the future, we can add it.  I'd be happy with this as it
stands.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--3d90jXFZAaahC8W9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYpkwDgAKCRB8DEliiIei
gd7tAQCSERmkQOupIuEWzufb5MsG1RqaxulJ25F1boiJ4eRQ9gD/fZSQ7xBMGFkG
Sq2FgQR+Py4e0S6QhVY9bs+9csniAgU=
=BGN6
-----END PGP SIGNATURE-----

--3d90jXFZAaahC8W9--
