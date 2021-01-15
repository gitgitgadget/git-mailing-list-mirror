Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B26C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 00:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A8123A9D
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 00:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbhAOAab (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 19:30:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53300 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731247AbhAOAa2 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Jan 2021 19:30:28 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D698860781;
        Fri, 15 Jan 2021 00:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610670557;
        bh=KgA35GhGOjeeO4Zc0yRgzXMOYNTF3wPXFAV/9lcECMw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bcHgUMeRcpoF3LPB3jZqjBwDBOvfSD6qeMJarlx6jMC6MLUpMynFsRx+z0ZdGKNXD
         di9UYK6qnpueL24lOeLXHgvun+uqgEDTOgEIpzBc1NS6lIz5NkNT6pt2+ERYGNotYK
         UuQCA3NRwNh6b+Qd3uUZ6BtHZtQ0Kco1I80AxdPUMkoS9c54MAAWoD5eZK5d7EemLI
         Ni9cZvUsf6AuMwyJzyotNdBXzPk+12IeSCx1kIZEP2iXca8lRxe3c/5WNcIlAyVGyF
         l68FABlU8GItOnFjLVmP/JILYv4WTo2N342JEf2iq1DoKVUoCD8JTFwL7ywFoFZPgB
         CK6JLvm8Z8RtGFFZVzAi9Vnhye4/u5ToXGMda5yk01PYPZ7fq8pD3nBK0QP7Zk4MIg
         K5mL+xuRfaCQp3rOWhHUAwoSmQCPrsKLb/HT6yloe/ihI2yHPToMAaaHikMtto/RXP
         XpqJslg4H/OY1bGvDt6mPpCSYdu7Yr6uAoVC/fgI2xe0WJwWgNt
Date:   Fri, 15 Jan 2021 00:29:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <YADh2DHDrdAs6Jbj@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <871reu752k.fsf@evledraar.gmail.com>
 <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
 <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
 <xmqq4kjpelza.fsf@gitster.c.googlers.com>
 <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
 <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
 <87k0si5k75.fsf@evledraar.gmail.com>
 <YADZSsVqyGnArF0n@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUzSnOhjlL5Iwq4m"
Content-Disposition: inline
In-Reply-To: <YADZSsVqyGnArF0n@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SUzSnOhjlL5Iwq4m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-14 at 23:52:42, Emily Shaffer wrote:
> Firstly: this design comes from a conversation amongst a pretty small (4
> people? 6 people?) group at the virtual inclusion summit some months
> ago. At that time, we discussed the ease of brute-force decoding the
> one-way-hashed mailmap and decided that, as long as Git didn't ship a
> tool to do this for you for free, it was better than the current
> solution for avoiding deadnames (i.e. "sorry"). I'm disappointed to see
> the larger list feel otherwise, but not terribly surprised, since the
> list contains more people than the group who came up with the design.

Yes, thank you for sharing this helpful context.  I will add that there
were a couple folks in that conversation who had mentioned that the
hashed mailmap was an idea they'd thought of (of which I was one) and I
did commit to bringing it to the list.

> Secondly: it seems like a restatement of the goals of this patch would
> help guide a discussion of designs; I would be so pleased to see a
> cleaner solution than any that's been proposed so far, because I agree
> that this feature is not perfect. So please append what I have missed:

I completely agree.  If there are better ideas, I'd be delighted to hear
them, even if the proposer isn't interested in implementing them.

> Axiom: The current Git solution for avoiding deadnaming is insufficient.
> Axiom: We want to improve Git's solution for avoiding deadnaming.
> (That is, I don't think either of these statements are or should be up
> for discussion.)
>=20
> Goal: Projects which are contributed to by trans individuals who
> transition during their contribution period should provide a good,
> supportive experience, which does not deadname the individual.
> Goal: Git's performance should not suffer unduly from any change unless
> necessary.
> Goal: Project maintainers should have an understanding of the threat
> model (e.g. automated tools scraping for names, malicious individuals
> with time on their hands and experience with the project, etc)
> Goal: Audit trails required by e.g. SOB lines should exist for the
> project maintainer, if necessary
> Goal: Mailmap, in general, should work better than it does now
> Goal: An imperfect solution should not disallow a more perfect solution
> later down the road
> Bonus goal: For the sake of Git project contributors, it would be nice
> to avoid a troll storm on list.

I agree with all of these.

Considering the last point, part of the reason I volunteered to present
this idea to the list was that I expected some trolling and general poor
behavior (hence my reminder about the CoC) and I'm comfortable with
taking the flak here.  I am (and I'm sure everyone else on the list is)
delighted that we didn't see that.

> Thirdly: As is stated elsewhere, I think this topic is falling victim to
> perfect vs. good. Git is gaining increasing notoriety in circles I can
> see about the ultimately crappy experience for people who change their
> names and don't want to hear the old names (and don't want to know the
> old names). In my opinion, literally anything we could do to improve
> this experience would be better than doing nothing. So I feel sad to see
> the topic dropped because of pushback, especially when that pushback is
> "I'd like to write a tool to reverse this thing, because <vague reasons>
> - and I don't mean that tool maliciously so that should be OK."

If folks feel that my series is at least better than the status quo and
do want it to be picked up, I can do the reroll I was planning on doing.
It sounds like there may be some support for that.

I think that does implicitly mean, though, that we're agreeing that
maybe adding a tool to reverse hashes isn't something we want to adopt
in Git, at least until we have a better or different solution in place.
While I agree there could be some legitimate uses for it, we do have to
be cognizant of the potential for misuse and abuse (as when writing any
software).
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--SUzSnOhjlL5Iwq4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYADh1wAKCRB8DEliiIei
gcFmAP9sNCLXQ4F+xoTvTYSnguPVZMP7ifxygp6fLRjbfKdEgQD/WM4HvyDXKw2r
kSVW/ncFFNhbIkhzvQHuFuUbCSl4rwI=
=/KFw
-----END PGP SIGNATURE-----

--SUzSnOhjlL5Iwq4m--
