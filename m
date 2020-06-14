Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E410C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0369C20747
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 19:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cnFlVXth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFNTIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:08:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39300 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbgFNTIs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Jun 2020 15:08:48 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DF59F6048A;
        Sun, 14 Jun 2020 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592161727;
        bh=WjaVulHVEXYS6YB18kdG0vscu0DshWlFvtDSu0PqBq4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cnFlVXthz1JWOE8HRF0EaCeHKk5DhhZn25mJ/uAly1g8o6FHzXvItKi39ddMTlA0P
         Dcn7h5FVZOEKgLMcvjd+Zp88VlpxEh1HiXXkNV6OBmQAzHYBhqT20r9ATxXAMCXENy
         tyhyurV83mJ2l3YU0A5xj339jjNJwg1g4PRnol9etvnuYFbGV7qeGRwbI+q0jNIctH
         bTyh0SfeZCJq3dwDDKq6WO3bbQ90nIhham5pmaVLM2OUJDGaiUN1dNA4VysnFuwiBe
         joQZBeix69B+tvmKgsEYkDlzAI0OU0q8n0YI6WbZCIcpdFssF/C44rEYBU9mc6r5Zs
         s6fUQSeW4e1ueuveWRldVI4065NHxYpyIKf9qhaSoau6jKGyI0AbN0x8wbB7lVMm8q
         Ju8rTjsI3wgrRoyCR27TWzqzxNSGntxMqS/MHudjWL4SLoItvwsb4OrbR3DMFh/N09
         jHyxCBzPhykAi16uwTGBoghgJx80tOdVrGOJdBQ0PmT40nOvuMy
Date:   Sun, 14 Jun 2020 19:08:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>
Cc:     don@goodman-wilson.com, git@vger.kernel.org, simon@bocoup.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200614190842.GC6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?Q?S=C3=A9rgio?= Augusto Vianna <sergio.a.vianna@gmail.com>,
        don@goodman-wilson.com, git@vger.kernel.org, simon@bocoup.com
References: <CAGA3LAcDpQQhcmaQG3+s6XNnth54KmNC+padAXXYsc5C33p7kA@mail.gmail.com>
 <fcad8e8f-e853-d754-e3f7-644a5c717f84@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <fcad8e8f-e853-d754-e3f7-644a5c717f84@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-14 at 00:05:33, S=C3=A9rgio Augusto Vianna wrote:
> No one here has to explain why something not racist is racist. The problem
> are the perpetually offended that see racism in literally everywhere.
> Specially when there's virtue signaling points in the table.

I want to take a second to respond to this because I think there's
something this discussion may be missing that I want to make explicit.

When we use language, that language has a context.  Part of that is
situational and part of it is based on how the receiver perceives it.
Very little of it actually comes from what the actual intent of the
sender is, because we can't be 100% certain of the sender's actual
intent without explicitly asking them (and not always even then).  Even
if we can, that doesn't usually change the perception of the receiver,
so it doesn't change the message that was received.  And it's important
to note that the message that was sent and the one that was received can
be very different.

There is nothing we can do to avoid this context because it's inherent
in language and in the enormity of human experience.  We can only
control what context we deliver to others by being aware of how other
people perceive our words.

I'd like to illustrate this with an example from my own experience.  In
Britain, the word "faggot" refers to a type of meatball which many
people enjoy.  In many English-speaking countries, it's also a slur for
a gay, bisexual, or queer man.  Even if, when I hear that word in a
culinary context, I can objectively tell myself that the word is meant
with neutral intentions, it still brings to mind the fact that I and
many of my friends have been called that and with that, my experiences
of discrimination and harassment.  One could say that I'm just easily
offended, but whether I want to be reminded of those experiences or not,
I am.  My mind just goes there.  The context here has nothing to do with
the sender, who probably meant well, but the message I received in, for
example, reading a restaurant menu, was a negative one.

A reasonable person who wants to communicate well will be aware of this
context and will choose to use a different phrase if they don't want to
communicate that negative context.  For example, the restaurateur may
choose to use the phrase "savory ducks" on their menu instead.  If they
choose not to, then we may draw conclusions about their intent when they
use the language they use.

Similarly, when we use the words "master" or "slave", even in contexts
where they have different meanings, we send context along with that use.
Black people, although able to objectively distinguish the two contexts,
may receive a reminder that they or people like them have been subject
to bondage, inequality, oppression, or discrimination.  If that is not
the context we wish to send to them, then we should consider using
different language.  Nothing prevents us from using those words except
for our desire to communicate or not communicate a certain context.

And while I admit that in this discussion one may say that one word is
an obvious slur and one is not, that doesn't mean that the context the
receiver receives is necessarily that different.  It may vary in its
intensity, but the underlying negative context may still be there.

I do want to underscore that free software is not exempt from this
phenomenon because we use language, and all communication with words is
subject to these same limitations and to the human experience.

The proposed patch series makes the branch name configurable, so you may
choose to use a default branch name which suits you.  It sounds like you
may choose to stay with "master", and you are welcome to make that
decision.  However, as with all language, that comes with context, and
others will receive and interpret that context and draw their own
conclusions about your intentions.

On a final, slightly different note, I also want to remind folks that
are here that we have a code of conduct, which encourages us to use
welcoming and inclusive language and be respectful of differing
viewpoints and experiences, and to refrain from insulting or derogatory
comments.  I know that this isn't always easy, but I encourage community
members to consider their comments carefully with that in mind,
especially when feelings are as strong as they are here.  If you want to
take some time to remind yourself of what it says, it's available as
CODE_OF_CONDUCT.md in the root of the repository.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuZ1uQAKCRB8DEliiIei
gQ3hAQC2NHh1SXL6juUQi6NTlwrzFWqetkkR/a6u4SZCmHCc0wD/ca2w4lz5k28J
0BDGA5AmhmWYfEzIGvi1EK/eoaffnQM=
=3gMF
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
