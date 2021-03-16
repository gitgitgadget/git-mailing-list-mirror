Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E957EC433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 11:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70B06504D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 11:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhCPLzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 07:55:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237528AbhCPLzF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Mar 2021 07:55:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 48CF56048E;
        Tue, 16 Mar 2021 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615895702;
        bh=RtdjpW3Imk5uXwXb1B3qGJHqozCSwerWJBxf8pvfpN8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uNMBroSVBMPHdz/X+ThBDG4MU8O5JMfZXiz8KtyYfxIviowREsHHm/ebmnCcrlRne
         4ltRe2Vlgm+yNDO4qk7YUrzVCvmUz5is/F+2xQE2hubOfmUOu4yJ7PtR7YTHEuNJe6
         IVuImPKtwqK+l7FXhiwS96og8rZkq8oBFIyz4xatVYS7Hm+u+rw9wlZ2HaV4wLnrD0
         JbuKyd8YntCuIU9zLt622/o5wcp8nb9rqJrbzmmLYa0F1ehUwaOeKambVZlvkPaTw+
         guevwvSHRiRceh/o9UgSniloQyGBEy7btPNMhZoCh+xS1Nem0nMCLttgfikxbCNFnH
         VrJHru4faTqb8MjqzgM+bn1CeE7nv0x42bMf64Asi8JWNiwiJZpmwtE4s/iyUhkSHK
         VmdI1jWQuaRJimB93EobCWanarJmjT0ps/FL5Fqz9VSkfub34Abz2aXhQ5zCNtUBN7
         ibCjoXkhdAHkaa8ElQ6z2rYJvIlDhFceZFwN9ZAzcGPkewJcNEI
Date:   Tue, 16 Mar 2021 11:54:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Drew DeVault <sir@cmpwn.com>,
        git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
Message-ID: <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eli Schwartz <eschwartz@archlinux.org>,
        Jonathan Nieder <jrnieder@gmail.com>, Drew DeVault <sir@cmpwn.com>,
        git@vger.kernel.org
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
 <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga>
 <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ff+OcCHNd+Vofajy"
Content-Disposition: inline
In-Reply-To: <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ff+OcCHNd+Vofajy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-16 at 04:38:08, Eli Schwartz wrote:
> Why does this even matter? Again, the point here is the assertion by
> Drew that, for the purpose of listing a manifest of remotely fetchable
> resources, he sees a benefit to having some standard format for the URI
> itself, describing how it's intended to be fetched.
>=20
> - ftp:// -> use the `ftp` tool
> - scp:// -> use the `scp` tool
> - http:// -> use the `wget` tool
> - git+http:// -> use the `git` tool
>=20
> But instead of needing every program with a git integration to
> reimplement "recognize git+http and do substring prefix removal before
> passing to git", the suggestion is for git to do this.

I believe this construct is nonstandard.  It is better to use standard
URL syntax when possible because it makes it much, much easier for
people to use standard tooling to parse and handle URLs.  Such tooling
may have special cases for the HTTP syntax that it doesn't use in MAILTO
syntax, so it's important to pick something that works automatically.

It's difficult enough to handle parsing of SSH specifications and
distinguish them uniformly from Windows paths (think of an alias named
"c"), so I'd prefer we didn't add additional complexity to handle this
case.

Lest you think that only Git has to handle parsing these, the Git LFS
project (and every other implementation compatible with Git) has to
handle parsing them as well (and related things like url.*.insteadOf),
and providing bug-for-bug compatible behavior is generally a hassle.
We've run into numerous problems where things aren't exactly the same,
and making things more complex by adding an esoteric syntax that few
users are likely to use isn't helping.  Despite the fact that ssh+git is
specified as deprecated, we had people expect it to magically work and
had to support it in Git LFS.

So I'm very much opposed to adding, expanding, or giving any sort of
official blessing to this syntax, especially when there are perfectly
valid and equivalent schemes that are already blessed and registered
with IANA.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Ff+OcCHNd+Vofajy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYFCcjwAKCRB8DEliiIei
gW4OAP9/KdWYx4d6f+gPD5TsNMMz9/W/Pk3cxSYsK98sShv7yQEA+lMV93KoZW8S
t4ZY7tDMCCuzNxYe0uMsw6z1VoRA0gI=
=jrKs
-----END PGP SIGNATURE-----

--Ff+OcCHNd+Vofajy--
