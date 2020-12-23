Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38420C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A96224B1
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgLWX0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 18:26:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38470 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727081AbgLWX0s (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Dec 2020 18:26:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 965056076E;
        Wed, 23 Dec 2020 23:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1608765936;
        bh=Wh+knHZYOToGdgURvdT+KLV85t7Jx/4F5W7sX0Pdn/0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vPt2Za4pfUdTFnRSXMhpZyNawLU9nkBp/GTCjkOPAC7mQ7NS2AkGuUkKWQPTeCEHR
         aWEyKaANIJtqdpbHQb73EdgKHi10prwN3hTSbtSnw4Q25Xc1KrXBfT4dD1oFk4ztnR
         b9Cw+WofDaKEL2pBic28WeBJM1Zjjvhj4BNBfc9wwHV7GzDruoSyVLZh0j4D2p6R8I
         ex7FffAh9ltDNDF9LjBVouKWXmqGQLfUVnrHZBsr7AqFAxwg/2jIGpchyc6VO536Nf
         8L9L0b4aUWQ9ZW6f7ZbFCxsEaU2S/fPL4BsEdSPZRhsrH2XfKRRdbDHbME98UnnWzG
         qsoFN6a42+B+p4Ni7NMYSMfGYDOTFckXKe6aknQU0PoWnLUQN6q+F4adO1WBeceTFK
         z+vG+bFcQFbKia807fA6PbXqiRE2LCNX1fuh/oVKoOh/b9ClWCG3cAyJw+N3mPtIlW
         +NCj9q9nxJDKX2U3n0UQa/eh4XeeQwB3LO0lY4WmSv6UiCGp2qK
Date:   Wed, 23 Dec 2020 23:25:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mike McLean <stixmclean@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Feature Request (Fixdown in interactive rebase)
Message-ID: <X+PR6yms1G9zVcML@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mike McLean <stixmclean@googlemail.com>, git@vger.kernel.org
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
 <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hwdJOKMo9j9ysX7H"
Content-Disposition: inline
In-Reply-To: <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hwdJOKMo9j9ysX7H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-23 at 23:08:58, Mike McLean wrote:
> I initially raised this as a FR with my git UI of choice, and was told
> that it was actually something that git itself would need to do ...
> and that the standard way to raise Feature Requests was to email this
> list.

This is absolutely the right place.

> During an interactive rebase, the text file defining the operations
> has a command option for "fixup".
> This will squash the target commit into the previous commit (listed
> above it in the file), and automatically use the commit message of the
> previous commit (thus bypassing the "choose the commit message"
> dialog/file).
>=20
> Can we have a similar convenience-command that squashes, and retains
> the second commit's message? Purpose is the same as the fixup command
> - saving a bit of time and unnecessary typing during a common
> operation.

Maybe I'm misunderstanding what you want, but I think the "squash"
command does what you want.  It does invoke the editor to edit it, which
tends to be useful when working on projects that use a sign-off, since
otherwise your second commit message would be tacked on after the
sign-off and other trailers.

If you really want to avoid the editor prompt, you can run your rebase
like so:

  GIT_SEQUENCE_EDITOR=3D"$(git var GIT_EDITOR)" GIT_EDITOR=3Dtrue git rebas=
e -i

which will avoid spawning an editor except for the todo list and will
implicitly concatenate the two messages.  That will also make any
"reword" options a no-op, though.

If you were looking for an editor command that just concatenates the two
messages without an editor prompt, then no, we don't have that, and that
would be a new feature.  I wouldn't use it because most of my projects
use sign-offs, but I'll let other folks weigh in if that's a feature
they'd like to see.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--hwdJOKMo9j9ysX7H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX+PR6gAKCRB8DEliiIei
gcCqAP4nVyhcF4fzDTnnRHDs89tAWgNzVRzAQH9H1NBeWd1/5QEAhbGhg6CELMJN
sG+IORh1dHow7eTz/g9B1M+xPMqoaQw=
=MPfP
-----END PGP SIGNATURE-----

--hwdJOKMo9j9ysX7H--
