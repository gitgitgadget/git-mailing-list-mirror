Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40711F731
	for <e@80x24.org>; Sun,  4 Aug 2019 00:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfHDAiZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 20:38:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57282 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729420AbfHDAiZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Aug 2019 20:38:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:49db:b3cb:1703:1c9a])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C08B86047B;
        Sun,  4 Aug 2019 00:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564879102;
        bh=99Ps9nKjJlOcn2pQjA2aGPM11jIVwQjh3ONQqdtAQfw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NRMp1A5W5eFidMFOl/edbzB9qfB4E1NEYfOpWZUHdqaWisib9EohNR+2FiwA6D32D
         LMPmO/o5EVj/2t3jI4GD4S2cBSjokviUHydnD7drVaBVrSzHAZ3JAR0YCUd4R1+6DA
         L7bJ4+8Tsgw6nWTr+8NOnTm/TNjK1Rb+oXdPwaE6G+i0MtzqOpL8YYmkuEJVEtip/z
         keG4pEzMCPdN06owaysQ+HWKfC9krH7kM6R9jobESVL7zg0T15hiSYdnGvuc6PQYsi
         F/Tq2uL+pU0Ows1zetz5XtD6DAzJAeeczlWtLTtOvOdlpgMOB8EH+S5EDN7NR8pwIo
         wVgcAMfmWBwrY0s1oWshGuqucWVvS20HyrREzqgxa+tyY35TDmTkzSqCKuciE9GfoC
         KJN6Tl0BtfkMkN4RKUnJMaUIJL7OZ61a/Bc65iqp+7UOZZ46dfH2mfTPLjmB8hK2Zz
         2whiheyZFT1DSkyVbs6JUh9CasQT3Dh1QUnWhLxLxHw/9qOXT0q
Date:   Sun, 4 Aug 2019 00:38:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Port git to Plan 9
Message-ID: <20190804003816.GE118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.305.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline
In-Reply-To: <pull.305.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-03 at 23:52:08, KADOTA, Kyohei via GitGitGadget wrote:
> I ported git, and git subcommands only written in C to Plan 9. This pull
> request contains patches for existing codes, and new files to build git in
> Plan 9.
>=20
> All build options such as NO_PERL are not supported yet, and also some git
> subcommands written not in C is not available yet. But git can synchronize
> to remote repository with git pull and git push via HTTPS.
>=20
> This pull request don't contain a part of Git toolchain for example
> git-credential-store, etc. So I'm going to port other parts of Git toolch=
ain
> too in the future.

This series seems to build a whole new build system that uses Plan 9
tools. Typically the way ports to non-POSIX platforms (such as Windows)
have been handled is that the Unix tools, including GNU make, have been
ported to those platforms, and the POSIX (or POSIX-ish) environment used
there.

I'm concerned that by introducing a whole bunch of new, Plan 9-specific
build code, we're going to have it fall behind with features or bug
fixes, because none of the main developers test on Plan 9, and most
contributors will not have the Plan 9 skills or systems to maintain the
code.

In addition, the editor used by git commit and other commands invokes
"sh", but you've set this to "rc". That's completely different from the
way that all other environments work, and it means that Git on Plan 9
operates in a totally different, incompatible way there. We also use a
POSIX shell for the testsuite, and we rely on it quite heavily. rc is
not going to cut it there.

Plan 9 has a POSIX environment, and I think it might be a better idea to
require that as a condition for building and running Git. It will likely
be a lot easier, at least.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1GKPgACgkQv1NdgR9S
9oubCw//Yx45/jOjzOlY1d7uPf1xhLoAm6gEcYD23X799GewNWKYJfAvWOJUX/4Q
8aWWgvcqyI+haQxNb9LTeeJIVnBTaW9NfjoLMFP1Cc7tDMMAyg2vOukaWjq517G9
6iM66aq3ZbeeZhXG078JPj83/1qs9Rs4uVRiPXgjN1WTk3cPE1fREFOmNEh23ldA
dUE2ij57uVfb6t1NNiCMUEqofTnSODsC7alZdUhlc4I8dp8pnK1o4JOitnQFGOD3
LlYNzsO0Gt9/+NosWWE7m70l6GkbYPIw6RYgpBn4Ehmf+6ut2fqsb3JcgsiS54F6
NCLwUK3g1PZeQypcm9vnNMZ78bljsl1oqAEfOeeXSsx6L9lCASWAqgUylsftw7RS
0h9V2co75ro5choSSezMod0TV+zIB0qKv4S7SswYXLmMp3X+VDySc/iC7Dn33/bq
Vqhh7oTKt+C+7p57chKFoovdKKFnP0k2o66VUv55UDZEosO8iKgL7CcRdDPkNOST
xSw3trAOQBRFWlbwKOiUx0cslA2rq1CSyYEFeBNNd3cBELnZ9ah+Wtqsy3wqtQwT
atbkIY9nJkgieqa2ggQKLMBzkKj5ovaXH6HAwCc0/HWOAj6D5mIZ5Tml71Ldwdum
ZV6aV1BidhX89SOZXls8RcSNEgCqEUG1k5m6OL3y8QJpoUQDYz4=
=/4Uy
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--
