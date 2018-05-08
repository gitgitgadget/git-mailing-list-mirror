Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4513C1F424
	for <e@80x24.org>; Tue,  8 May 2018 23:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeEHXqf (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 19:46:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42662 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755799AbeEHXqe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 May 2018 19:46:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 83A536046C;
        Tue,  8 May 2018 23:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525823193;
        bh=G4gA0CewKzYg6Syvd8Zg9Y2nxTiJHY7xnPDHSQxXHY4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wud2lZ2dfF7g8OFP2j7bCHuJHuQWZyKVYqHECOnS7R8Jd01yaOnR40PQKrUCRhiTb
         rgAAJeziPNM7JkxzNKLRmCA5PVa6VwW/QaOgLc6k1YtJ/Z4E6TfG5jl2L/H+8jYtDw
         h8Oo46w3gfxhLIcDHFJxA9SQs6mujZ90Dynb0yP4uAyMBX0WZ/NBOOxSaxtUInMrY8
         z16h/mx6QfsvpHQFeCCZWJxjVe4ouAw5jBzDXhC8NjRwyVFf+V6QQZqnNo0M7sxUNh
         1P5MiKmZtAsnDq0yVbQUq4aC9+KF3hFNQvHqeAg5CWzNw2om7OnA0XyQ18esWoYsQq
         L4xg6byQwOyeVz2JBBeRBlL65PlBE/9k5vvPRArBeQwtAtoByB9xm/ZlcOUpicpBs9
         6/O+rkDwUgLjQMnf55Mda8O6gXmO9SjgSG5QDh45ObbHYvpRzGlvSVLQstSamYVsr0
         eceyPPR9Ld6w5Z+4aM9+6ThNaIdU1MAw7W6EGlOWabcEwDzrs4d
Date:   Tue, 8 May 2018 23:46:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 01/28] t/test-lib: add an SHA1 prerequisite
Message-ID: <20180508234627.GC275488@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
 <20180506231752.975110-2-sandals@crustytoothpaste.net>
 <CAN0heSqk0siv4y5BGz2+sLhAyNG=TEZmgucKoCDGyx2i8_O+tQ@mail.gmail.com>
 <20180507233000.GI953644@genre.crustytoothpaste.net>
 <CAN0heSpzBtSBE78zmBx_5ukb4DpHEO==kGgbYAczE+UyBf3HxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <CAN0heSpzBtSBE78zmBx_5ukb4DpHEO==kGgbYAczE+UyBf3HxA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 08:26:05PM +0200, Martin =C3=85gren wrote:
> On 8 May 2018 at 01:30, brian m. carlson <sandals@crustytoothpaste.net> w=
rote:
> > On Mon, May 07, 2018 at 12:10:39PM +0200, Martin =C3=85gren wrote:
> >> Do we actually need more SHA-1-related prereqs, at least long-term, in
> >> which case we would want to find a more specific name for this one now?
> >> Is this SHA1_STORAGE, or some much better name than that?
> >
> > We may.  The transition plan anticipates several states:
>=20
> "We may" as in, "we may need more SHA1-FOO prereqs later", or "we may
> want this to be SHA1-BAR"?

As in, we may need additional prerequisites.

> I do not feel entirely relaxed about a reasoning such as "this prereq
> will soon go away again, so we do not need to think too much about its
> name and meaning" (heavily paraphrased and possibly a bit pointed, but
> hopefully not too dishonest).

I think "SHA1" is short and reasonable considering that it's basically
stating, "This test depends on Git using SHA-1."  That's all we're
stating here.

I agree that the expected lifetime of the code should not impact its
design or naming in this case.  As someone who does maintenance for a
living, I'm all too aware that code lives far longer than its expected
lifetime.

> I guess a counter-argument might be "sure, if only we knew which
> SHA1-FOOs we will need. Only time and experience will tell." You've
> certainly spent way more brain-cycles on this than I have, and most
> likely more than anyone else on this list.
>=20
> Maybe we want to document the transition-ness of this in the code and/or
> the commit message. Not only "transition" in the sense of the big
> transition, but in the sense of "this will probably go away long before
> the transition is completed."

Sure.  I can fix this up in a reroll.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlryNtMACgkQv1NdgR9S
9ovmXA/6AhcoD0WpQzEwfwC2WF9JVtR4wwpnm1OyncVR2ormO03U63dyx9FWNBjF
qPZiJOrgqRb/sV7Z++zHh1q/kCy79kAFr/8qxRakIIMtaZbiq+amEs5XRazrigGl
pHCKtZ6fTZFp1ViXYC3b4ergFO4xK0HPpFqyhu8DAP4r8agXMQfD0tDitta7m4R4
CBnvy9gkOYDLYJ/f9L3b9g31+zEza0jemMomZVcYQAXtH7rGdnHuTaRI8LpAt490
gf61YZM2FA25cEbaXX518i9VwYC39JJuoAWWvm3sbfFrWlmxHYHBuNfNIyCdSWP9
AXi81VluGeHfOHaTbHq0VRyUCGHTnA2PpX4iYLK5Kaf8SjSXukPUA3irTk/I990i
LYaH6+UBu6M8jS6o6ROqHDwlMjaGLB/2eiCGGqjLTbV4tOAcVO8VNMBSPdFuwLO5
KZRTSpy+CjKwiMij8N31pqKGRzVWDmWvZxlAF1jvy4ODbvOtgeMQ2PniV2SSqj+A
uD4GKndD8aeIRSQ/4f+k/u9dhHXKEvaQkzXD28zobOKUVpGUtx9Y0z1i6Q+N3RcJ
wBFl/BZox8rY4Zl7hkLc7Nj8JdYOVMIXT81JF05iZzZszU+xEqdWYxBKdnrFhcfY
g2KvfT/iYN3O/ilDQFlHIAgFNOrGpWUkgKrmukNCM+LIQqX3geU=
=NAD9
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
