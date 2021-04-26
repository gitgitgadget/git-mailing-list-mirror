Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A57C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 02:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D89F61263
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 02:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhDZCFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 22:05:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41888 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231502AbhDZCFU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 22:05:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3982B60422;
        Mon, 26 Apr 2021 02:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619402678;
        bh=H5MrOEOGtMiUj+TfLsT+yQhnUN3iFViaDkBiIW3n1XY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Cz0/byzJAbG4KZOmKf38NwzGSeP7+VQM9ivblIuTtbwmHcNla40IJOsmlguPMBR0a
         3lwa6op+VtcyBixSV0kzuDzu+QCvSlhq2X8P4DyQ8XA4C9kGxF9OvzGIPqdH/2v9qR
         SvgvLXG0nPc9b1rxjMr6COyEsPnjKeVU4y9PUdg8CRGftpYy7DiyZAvISWWr6JQdHD
         kWHHz8NNmBmdKuB1a0ImX6s4drDWe9z+OEkCcMhUMy4F7K1ITfna7tJpmmLx/6NCeK
         6fORePN8gEt/+xtct/T08bPl3Eke48oB07+2QQYhg/Z/mv3s16GuBXWmv+TKrRb+iD
         47NsDEioIrigKYg3BxJvV76VF1DtKlgG0S9M+28ZxX8pkN1FpavQ0oxhRwd0NAsQW9
         FXz5luTDwmizqSOf+t4dAemitscdnoZIEY04xeL3feSqmPIdqXjqlEv2HwGFra7q9m
         4Vwg2ztRnL/8Ss+69h+HVqJpx7NhI83fgATbwI1zSLVzqP8Wbtf
Date:   Mon, 26 Apr 2021 02:04:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Message-ID: <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>, mricon@kernel.org,
        patchwork@lists.ozlabs.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <YHaIBvl6Mf7ztJB3@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2lRgWVzTVwhYFkf2"
Content-Disposition: inline
In-Reply-To: <YHaIBvl6Mf7ztJB3@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2lRgWVzTVwhYFkf2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-14 at 06:13:26, Jonathan Nieder wrote:
> Those four are important in my everyday life.  Questions:
>=20
>  1. What pain points in the patch flow for git.git are important to
>     you?

I realize I'm a bit late here, but I've been thinking about this some
and wanted to chime in.

I have trouble finding all the spots where people have given me review
feedback.  I have patch mails and responses to those mails go to a
particular folder, but I still often find that I'm not quite sure if
I've gotten every piece of feedback in a review.  Sometimes,
embarrassingly, I don't, and then I have to send another reroll.
Regardless, this makes rerolling a series much slower as I have to comb
my mail multiple times.

I find I'm often unsure what to put in the cover letter for a v2 or
subsequent series.  Clearly people don't want the same thing as v1, but
I rarely have useful information other than a summary of changes.

I have tooling to automatically generate the proper range for
range-diffs in cover letters, but that tooling requires some sort of
manual timestamp, which means I need to go search for my previous series
to find the date and generate the range diff, or if I'm in a rush, I
just have to omit it.  This can take some time, having to guess what I
named the cover letter the last time and search for it in a mailbox with
a 6-digit quantity of mails[0].

In general, I have trouble keeping track of the patch mails I've sent.
I do definitely need to refer to them later, but I don't generally keep
them around on my system since they tend to duplicate my repository, so
I end up needing to find them in my mailbox, which as mentioned, is
slow and error prone.

I find that the git-contacts script is often not helpful to find
reviewers.  When I send out a series, it often suggests Peff and Junio.
While both of them are very capable, they are also not capable of
reviewing every series, and in many cases I know full well that one or
the other is not going to be able to give me a good review (for lack of
familiarity with the SHA-256 work, due to having many other things to
review and to do in life, or for other reasons).  It also,
unfortunately, suggests me as a reviewer for many things, which while
flattering, reflects the fact that I've touched a lot of code and not
that I have a deep understanding of most of the codebase, which I do
not.  For areas where I do have relevant insight, such as the signature
code, I'm often not chosen.

I realize a lot of these are not intrinsic to our workflow and can be
solved with tooling, but because I haven't built that tooling, they're
pain points that I experience in our workflow.

>  2. What tricks do you use to get by with those existing pain points?

I've built some tooling around this, including mail filtering, aliases,
and scripting, but it doesn't seem like enough.  I know others have
built really great tooling for themselves, but by the time I notice
these pain points, it's usually the evening and I don't have time
to build tooling and get things sent out as well.  I also don't
especially enjoy building tooling here.

The friction here makes me less likely to send out patches and much
slower to reroll patches than I'd otherwise be.  And I feel like that
means that I practically can only ever send out a series when I have
more time on the weekend, and as a result, I worry that my patches hold
up others in the tree much more often than I'd like.  It also makes
contributing to Git less fun, which is important since overwhelmingly my
patches are sent on my own time.

>  3. Do you think patchwork goes in a direction that is likely to help
>     with these?

I don't think I know enough about it to say.  If it can more clearly
track review feedback and help keep track of patch emails, I think it
would be a major improvement, for me at least.

>  4. What other tools would you like to see that could help?

I think we definitely need a bug tracker.  We extremely frequently lose
bugs and feature requests on the list and people aren't very likely to
search the list.  If we could use the same one as someone else, such as
the kernel, that would be ideal, because it means people are more likely
to already have an account and therefore the friction to report a bug is
lower.  Alternatively, we could use something like debbugs which is
controllable entirely by email and therefore requires no accounts (but
does require someone to occasionally prune reported spam).

I know full well why we don't use a forge-based model and I'm not
recommending that, but I do want to point out that forges solve all of
my pain points, and I do have a much quicker turnaround time on patches
when I'm using a forge.  So ideally we'd have some standard or
recommended tooling, whether built by us or by others (e.g., an open
source project for patch workflows), that addresses these pain points so
that everyone doesn't have to build their own and turnaround time can be
improved.

I have seen replies downthread that some developers really are reticent
to use more common tooling, like web interfaces.  While I do want to
keep our project as accessible as possible to as many people as
possible, I worry that by catering to folks who don't want to adopt this
tooling, we are drastically reducing the number of possible contributors
of all sorts (code authors, documentation writers, bug reporters) by
not doing so and worsening our own experience in many ways.  I do think
we should adopt modern tooling (e.g., web interfaces) provided that it
is usable for people with accessibility needs, even if that makes some
people unhappy.

[0] I don't, as a general rule, delete emails to this list or otherwise.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--2lRgWVzTVwhYFkf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYIYfsAAKCRB8DEliiIei
gWgnAP96kvJX/9OR04zInrIeXNJ8W/cTT/16aOLR88OTdD5JTgEAop2cqRHskK+T
gS+yWsCRUgk0cwcTXDHMGyC8HquJWQI=
=r1cb
-----END PGP SIGNATURE-----

--2lRgWVzTVwhYFkf2--
