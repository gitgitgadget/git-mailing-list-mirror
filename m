Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1910C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 21:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjAAVKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 16:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjAAVKO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 16:10:14 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243BAC7F
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 13:10:12 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [66.244.218.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1DC5A5A344;
        Sun,  1 Jan 2023 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1672607411;
        bh=dq06/DsepKbXv+bW658YcuwFABLksBCXqfohUwBxv+Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=scbh0Y32BpFVlFiBAbZyraK4PxpbaRwj97ZiijGG4gdBR31HvuA2zzGq69aPesi7v
         L+ByFDtSiQZp/zUhZNbwun394aryr3tQt0NnScf2nLtOt6rJOUsV+gpYSVX4SWF8NY
         1halBJ2kbzX2IDCHx8g/zLnBzjRewnAr5iA42tkxc5i1anJwjV8UUbwGsSNyuJNx9z
         Bv9NJl+NxSP8MJXCvhu9+E7MMHoLbUt1m2w5lL50Aa0/YSkc4WWhcZVpmuQleGHmJZ
         5vleG1ldVLmENrYmjT2mlpDbEitZ+u1JHIg3CHq+oTwKKUi5zT2ThD3pSD/npaEib9
         ht/HCfOF/bO21HcBktqayX9W/u6MOiOgaFiIfQHEyN7IJMaW1Wb0KpVk6ZrKEdWYW5
         Az2LFH+yaW1ZxeegjwLG70FmQZcpk6fWIJb0+/bU0ZZOpFbi88QRdqf5NoY6zjcjun
         6WGx4KOhYTRYo5l3olD04qwxgTVjkEfXGI2fU/KPXhyhNZkujIN
Date:   Sun, 1 Jan 2023 21:10:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Filip Lipien <aaa@164.ooo>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
Message-ID: <Y7H2sN1fEZ8pi6xY@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Filip Lipien <aaa@164.ooo>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2x9QdFqG6sbACF0W"
Content-Disposition: inline
In-Reply-To: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2x9QdFqG6sbACF0W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-31 at 18:11:17, Filip Lipien wrote:
> There are more than one million questions on Stackoverflow related to the=
 usage of Git.
> This is not normal.=C2=A0
>
> Git is in its current state not a tool that's made for humans.

There are also many questions related to Windows and Linux.  It is
unsurprising that software that is flexible is also very complicated and
that many people may have questions about how it works or the best way
to work with it.  Git is also extremely portable and popular and as such
there are many people who use it or want to use it, and therefore people
asking many questions.

As I mentioned above, many people have questions about the best way to
accomplish a task on Linux, which is also very popular.  We should not
force Linus Torvalds to step down because Linux is complex or because
people have many questions about it because it may differ from other
software they've used.

> It's realistic to assume, that=C2=A0millions of working hours were wasted=
 due to his ignorance of=C2=A0developer experience.
> The financial damage goes into the billions.

Do I think Git could benefit from improved developer experience?
Certainly.  I think there would be substantial value in doing that, and
such topics have been discussed at contributor summits in the past.  I
was left with the impression that most contributors would like to see
this kind of work done.

However, I think you misunderstand how Junio acts as the maintainer
here.  This is not a corporation where Junio tells people what to do and
how to do it.

Instead, this is an open-source project, and it's my impression that
Junio spends most of his time shepherding other people's patches and
making sure that the project and contributions are in a good state.  He
sends relatively few patches himself, and while he might make a
suggestion on what he'd like to see out of a series or project, he
doesn't really tell people what to do because people don't have to
do what he says.

As a result, it's not really fair to blame him for a poor developer
experience.  If that's valuable to someone, then someone will send
patches to work on it, and I'm confident that Junio would accept those
once they were suitable for merging.  If nobody has sent such patches,
then the presumption is that nobody is interested in doing the work for
that at this point, and Junio isn't going to be able to just tell people
to work on it, since people work on what they want or what their
employers want (if they're working on Git in their professional
capacity).

In my role as a contributor, I've sent and reviewed patches that
correspond to my areas of interests and expertise.  While I think a
better developer experience would be valuable, I lack the experience to
contribute meaningfully in this regard, and as a consequence, I've sent
no patches here.  I welcome contributions from others in this area who
are more familiar with the work that needs to be done.

> I hereby request the removal of Junio C Hamano=C2=A0=E6=BF=B1=E9=87=8E=E7=
=B4=94 as the Git Maintainer.

I think, given my explanation above, that this is completely
unwarranted.  The maintainer of this project has no authority over
participants to force them to address developer experience here.

While I don't always agree with him on everything, I think Junio is
doing a fine job as maintainer, and assuming things stay as they are, I
would be happy with him remaining as maintainer for the indefinite
future.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--2x9QdFqG6sbACF0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY7H2rwAKCRB8DEliiIei
gUpPAQCImzH+C/DplDY0Z2Iucgk4CKw7MRVgznPIfY8CXqdkEgD9ETJ1PsUO83My
cijBSIjmD9bCcqfb39QY5bP97/5/BAc=
=YUIp
-----END PGP SIGNATURE-----

--2x9QdFqG6sbACF0W--
