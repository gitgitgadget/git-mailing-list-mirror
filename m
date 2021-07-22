Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D4C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6066460EB2
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhGVWQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 18:16:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40370 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231596AbhGVWQM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Jul 2021 18:16:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 230086042E;
        Thu, 22 Jul 2021 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1626994576;
        bh=a4cHn/kqIBfjOFYzC2XkGT1zQSuQx7T8yUHEa8BJ5Hw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fW+kqbmBysDDzhFTCApiX4Tg7g7kiKqevZV7gcEjTki5oIq10JfxetLHg+irI/5FO
         nDsX+UaedwSeaU5md+Q6QG67H8Whd4sUpAVrGcPqOXLrKUynHpztttxjeWKHekQ+na
         9ujGL9KV4JW3nhtP4jri7xKwLoHn4QNwLuM8BFAVViVMAsQiETOy7URsBpkeFuAz0k
         Li7eIDUNflmz3zVSe9mOnQCSoiKLcxqr1eh9dCQ/mrMCglTO17+xiRx9dOUTmqLJnZ
         XHURIxmc/8SjDfhyBAQ6bxaJRvssFjewUhDLDtETDNqcuLuslupk6OPel+j9vutF2q
         emAWInrAa4LHuzO/Ihrsceahe1QSrtsjKGSgV4607MahEO3vZu9PY62/37h3HK9Blu
         Q7zKk1cmlFQteuHhhO538I23jGnyLH2mVvi8wvPi8Lkd+Mk4rzXlx6cIM/uhxaKrOF
         oxWoJ7dPcoJPgO1wzg4tCJNKiHCp+31YdcOtSqEQqDPkixF+vD9
Date:   Thu, 22 Jul 2021 22:56:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] drop support for ancient curl
Message-ID: <YPn3jP0n+ghomSkX@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
 <YPimBp+TkaJ9ycuM@camp.crustytoothpaste.net>
 <87czravm96.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ce0Vyfs0uhvqUjCD"
Content-Disposition: inline
In-Reply-To: <87czravm96.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ce0Vyfs0uhvqUjCD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-22 at 07:09:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I'll clarify this along with other fixes in a re-roll, but I think our
> policy shouldn't have anything to do with upstream promises of support,
> but merely the trade-off of how easy it is for us to support old
> software & how likely it is that people use it in practice along with
> git.

I don't think I agree.  We should try to support major operating systems
well provided we can adequately be expected to test on them, and that
means that they should have publicly available security support.  In
other words, a developer on the relevant operating system should be able
to test on that OS without paying ongoing money for the privilege of doing
so securely.

Once an operating system is no longer supported security-wise, we should
no longer support it, either, since we can't be expected to test or
develop on it securely.  Nobody could responsibly run such an image on
a CI system or test with it on an Internet-connected computer, so we
should no longer consider it worthy of our support.

> So as an example we still say we support Perl 5.8, which is ridiculously
> ancient as far as any notion of upstream security support goes (and as
> an aside, does have real DoS issues exposed by e.g. the gitweb we ship).
>=20
> But while we could probably bump that to something more modern nowadays
> in practice we're not a mostly-Perl project, so I haven't found it to be
> worth it to bump it when working on the relevant code.

I've actually argued in favor of bumping the version to 5.14 a long time
ago.  I can send a patch for that.  It has a bunch of nice new features
we could take advantage of.

> I'm only using RHEL 5 as a shorthand for a system that's usually the
> most ancient thing people want to build new gits with in practice.
>=20
> It's just not the case that you can't run RHEL 5 or even RHEL 4 "safely"
> even today. Upstream has just abandoned it, but that doesn't mean users
> in the wild have. There's also CentOS, not everyone cares about IBM
> corporate support policies.

Yes, and CentOS has dropped support earlier than Red Hat has.

Just because users want to run new versions of Git on systems that
should long ago have been abandoned[0] does not mean we should take the
burden of maintaining that code for them.  Since they have the source
code, they can build and maintain Git on those old systems and apply
any necessary patches.  If this becomes burdensome, then perhaps the
cost of maintaining the system will be an incentive to replace it with a
secure system.

I am unconvinced that we should make it easier for people to run
insecure operating systems because they pose a hazard to the Internet
when connected to it.  Just because it is behind some firewall doesn't
mean that it cannot be compromised, and once it is, it can then become
a source of spam and abuse.  This is not an idle thought experiment; it
does practically happen with great frequency on the Internet today.  An
unsupported system might be acceptable if it has no network connectivity
at all, but then it would not need a newer version of Git.

It is not that I have not experienced such load-bearing obsolete systems
before: I have, and I have done my best to support them.  But I've also
been happy to be clear to management and/or customers about what that
means in terms of costs and that we were taking a real, substantial
risk, and been clear what the consequences were.  In no situation,
however, did I try to convince outside parties that my obsolete OS was
deserving of someone else's maintenance burden or argue that the system
should not be replaced as soon as possible.

> We should have the view that git's critical infrastructure and we should
> be wary of breaking things. It would also just be counter-productive,
> the result would probably be that the ancient box wouldn't get an
> upgraded git, and would still have preventable CVE's in git itself
> present (e.g. the gitmodules RCE).

Considering that the machine already has multiple CVEs, probably
including root code execution vulnerabilities, I'm not sure how much
worse we could make it.  It's already trivial to compromise with or
without a newer version of Git.

[0] I should point out that ten years of support is already extremely
generous.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Ce0Vyfs0uhvqUjCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYPn3iwAKCRB8DEliiIei
gdmbAP9IM7bwRFKkCQntXfgRIprlg4YeM+axcJdWn0AYb4Ig2QD/QqAd6Ijm5DR1
iDjLPLEL2S8U2CWf68aKk0RSzZ7LXw8=
=u7i/
-----END PGP SIGNATURE-----

--Ce0Vyfs0uhvqUjCD--
