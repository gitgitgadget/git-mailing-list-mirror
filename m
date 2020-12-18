Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7948C2BBCF
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6473B23A69
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgLRCbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 21:31:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34480 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727184AbgLRCbB (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Dec 2020 21:31:01 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4DCB561478;
        Fri, 18 Dec 2020 02:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1608258590;
        bh=evuftWoR3rQa+0G3mISF/raes3U21VS43rZ9Np+K4aw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Vsxdz3Za0JorN5//azFnhkm6kPommSfdek233UlmAgIOrE36S7X8loL5pE6bwTSTe
         aENhTNPe2irldQwMQKvG1AZWJYlPd9lYI/Z9Uleq+RGlG99jEWCss7msMZmA9bKFud
         mVWMb9m4h83AS83aoMk+1t19o+gvs6YjqjmBZHJ+06Z0BBjBZs519GmA+ESa3ufbFi
         tzQAZPTHJTY4MWidFwjpwhwWTbuILbnnazoFHxIXKXtqtCtETr08RiKP2TL2wtBWjQ
         9Y3juQZfjOeQ/LV0UndiuUxyJ9CqdmXsk+mUPEov8rko35kZZhHTeNg8D2q4NLiRt4
         Px7wpTSyciTn/lCjUiqCTADh8kc/YuNiK1gGRXediMREKTsR2f/YhohLhF61/VggeO
         v/yvqMvQdC1Oe0YOr2sc3ED4W9e3YEp8TSUOPhMbxTxiitFLr1IviDra9oWDm/GxJf
         SJg2WL7spWCcR5ZVb1076w3DEAl04UVmgF7BTDgVvw6SV2XiA0E
Date:   Fri, 18 Dec 2020 02:29:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Hashed mailmap support
Message-ID: <X9wUGaR3IXcpV0nT@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <X9gV3mKwGrHL7PzV@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6wOmrRmXJrdw5bTh"
Content-Disposition: inline
In-Reply-To: <X9gV3mKwGrHL7PzV@coredump.intra.peff.net>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6wOmrRmXJrdw5bTh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-15 at 01:48:14, Jeff King wrote:
> On Sun, Dec 13, 2020 at 01:05:38AM +0000, brian m. carlson wrote:
>=20
> > Note that this is not perfect, because a user can simply look up all the
> > hashed values and find out the old values.  However, for projects which
> > wish to adopt the feature, it can be somewhat effective to hash all
> > existing mailmap entries and include some no-op entries from other
> > contributors as well, so as to make this process less convenient.
>=20
> I remain unconvinced of the value of any noop entries. Ultimately it's
> easy to invert a one-way hash that comes from a small known set of
> inputs. And that's true whether there are extra noops or not.
>=20
> The interesting argument IMHO is that somebody has to _bother_ to invert
> the hash. So it means that the old and new identities do not show up
> next to each other in a file indexed by search engines, etc. That drops
> the low-hanging fruit.
>=20
> And from that argument, I think the obvious question becomes: is it
> worth using a real one-way function, as opposed to just obscuring the
> raw bytes (which =C3=86var went into in more detail). I don't have a stro=
ng
> opinion either way (the obvious one in favor is that it's less expensive
> to do so; and something like "git log" will have to either compute a lot
> of these hashes, or cache the hash computations internally).

I don't disagree that it's easy to invert.  The question is, is somebody
going to look at a large set of (e.g., a couple hundred) hashed entries
and be able to easily find ones of people they'd like to make life
difficult for or into whose business they'd like to pry or is it going
to be too inconvenient?  I think base64 makes the job too easy and if it
were me in that situation, I'd prefer a little more effort.

I think there's also the benefit, at least for email addresses, in that
people can map a "private" email address that they used accidentally
into one with more robust filtering without letting bad actors invert it
trivially.  That doesn't mean spammers can't run through the log, but it
does mean that they can't write a simple tool to invert base64 email
addresses they've harvested out of Git repositories.  And we know that
spammers and recruiters (which, in this case, are also spammers) do
indeed scrape repositories via the repository web interfaces.

And as someone who had to download all 21 GB of the Chromium repository
for testing purposes recently, I can tell you that absent a very
compelling use case, nobody's going to want to download that entire
repository just to extract some personal information, especially since
the git index-pack operation is essentially guaranteed to take at least
7 minutes at maximum speed.  So by hashing, we've guaranteed significant
inconvenience unless you have the repository, whereas that's not the
case for base64.  And making abuse even slightly harder can often deter
a surprising amount of it[0].

So I think I'm firmly in favor of hashing.  If that means my patch needs
to implement caching, then I'll reroll with that change.  I think by
switching to a hash table I may be able to actually improve total
performance overall, at least in some cases.

> I think somebody also mentioned that there's value in the social
> signaling here, and I agree with that. But that is true even for a
> reversible encoding, I think.

That's true, I agree.  And for many projects, that will be sufficient.
If I saw a hashed mailmap entry, I would assume that it was intended to
be private and would respect that.

[0] See, for example, greylisting.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--6wOmrRmXJrdw5bTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX9wUGQAKCRB8DEliiIei
getXAP0bY8LaVisEw7K5I7m3yULQfbBQh88MKuxYbjZrkdmfugD/QtNLwx8KFqyW
oaHc97wjU/tCbH8myji9xr+e8VPKvgg=
=60J5
-----END PGP SIGNATURE-----

--6wOmrRmXJrdw5bTh--
