Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05137C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD876206E2
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UextMaTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgBUBLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:11:44 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37624 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729419AbgBUBLo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Feb 2020 20:11:44 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8837E60799;
        Fri, 21 Feb 2020 01:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582247503;
        bh=bew//Y250DqdjXV29vNF0DR+B5XfU/z30d1aJZC8sDA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UextMaTu0VKZGpVmRVt0aMNeBAnBUKETdJhfWpZW8E1HaH0Emwt51i3oBItVSa4Sm
         FI4mV7RkRBOjWrKriaSl5y4VGefcHiZvNQE1LCt7WEW6YBXBQt1Rnuki1pES+e/dXA
         cfiXMdm4a3uo7d5AFp8hdPqJB9dDTEsvrdltlwt3huihaOykMUloqktsVB2I7N6Ri3
         ADssISB8xOHuaxv6G1RBDyTx4Z4q1cEk/JlEiblJ5/oPCito1Ve/krt4b2i6L198v9
         s88qB9BJc3S4I8JOkwvzl7OYKMKy+dNtZNzjMvoM5vFHcWHoxGwuwQsHMWKtP9k3YS
         UK7M1+UTVQJp264H2kFCgJfPDn899HZL3hCowOsuTNDyPt81FQgS30jAQhENVj0dC7
         79QLCpIPT4TfFWX5SsdtOk6SjWy1z8Php8wzjEmtpYXm91eGSl/10DfXCSWmOVvRUA
         S5UNuOBUbAjnmLOwfl+5xXopfuKvYGd9Y2Yu7LMfuaukkznV/82
Date:   Fri, 21 Feb 2020 01:11:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git does not wait on hook exes (^C)
Message-ID: <20200221011138.GB6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+dzEB=jJEkuvcX5qDfeXS=mbJu_m=-yUsmHd_KrKAXC3YDe7w@mail.gmail.com>
 <20200221000141.GA6462@camp.crustytoothpaste.net>
 <CA+dzEBkP==U7iS=6vS4=g7LYwh_cKzqbPApDraiYv7tiwPOVHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <CA+dzEBkP==U7iS=6vS4=g7LYwh_cKzqbPApDraiYv7tiwPOVHA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-21 at 00:12:18, Anthony Sottile wrote:
> On Thu, Feb 20, 2020 at 4:01 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I believe the way that SIGINT works on a terminal is that it sends the
> > signal to all processes in the foreground process group.  So my guess of
> > what's happening here is that Git and your script both get SIGINT, Git
> > cleans up and exits quickly, leaving your script running.
> >
> > If so, I'm not sure that Git can do much here.  If Git waited for the
> > hook to exit, then a broken or hung hook would cause Git to hang
> > indefinitely, which is not what the user intended when they pressed
> > Ctrl-C.  Usually what the user wants is an immediate return to the
> > terminal in such a case, and I think most users would consider it a bug
> > if Git were to wait for its children.
>=20
> Taking git out of the situation:
>=20
> Create a shell script:
>=20
> ```bash
> #!/usr/bin/env bash
> .git/hooks/pre-commit
> ```
>=20
> ```console
> $ ./t.sh
> zzz part 1
> ^Czzz part 2
> exiting
> $
> ```
>=20
> that works fine (and is the expected case for `subprocess` calls for
> example in python)

Yeah, I think this is the case I was discussing up above, where the
parent process waits for the subprocess to exit.  If I modify the foo
function in your hook to also have a "sleep 10", then the parent process
hangs until the child process exits, which again would mean that Git
would hang indefinitely if the hook hung.

Can you maybe tell us a little more about your use case?  What are you
doing in your hook that makes this case come up?  Why is your hook
trapping SIGINT?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5PLkkACgkQv1NdgR9S
9osHQRAAvS5kKLowxiLuaqN/mH7Cje77MIBD0H8SalvrSdhOJvt4nHfKSklVEOdW
M3Yu5NFeppenl0zRZdUeer0L0Mixl5dtimGnX8wmLTfgP+xjRq7R3rO+n73g61Gg
2JEqyr/97SudUlHurmxGBDkbHqOCNPNsZdkMrjs7ByDzDmw6ZARSa5odupSwyUb3
YbLxKcGLbBjWp1vT9fGBPvHPaLRsh4dMfB5uij2kGKbvBlj/zSVnZQzbNIN2t6Iw
tPlQhT9yU5MU2gl8O2X66cE+daOrzP9wyqVP3jvPR0AZXPGYbg1NbvDsbrtwkjH4
199sVKLJtBfu0EzLsdC4ObwqIy4JOlpFBnPepwOVVnsdtxUsLSpLshkStvk8iT1g
NLhyfYQsv59bAfx5lALEM5g8Mq2Q2BiYTvym3W1fHBxLZcDglbvJhyYsZ4Fkftka
VniqGyN6JFigLSNMOom+QF0gJ6RHpBsJ2pCw61r5QqZKYYCwkWyWWcV+3kaYrq7C
xrjppFFgAN3ZmVEFPTzfyMPOBeGA0no53hkt1nJaANhJwdEFMly7L4ocCSLHg7RK
pbbOgLuHJsbmn7S8RZYjML1kGywQJ2S099yWml/5wonTKVGuO+jlQ1FjZ23moTYj
Nici6P7AbiMxwi23C9wqXDds5VBx032i5kfM2ixoSYTi9i7qMR8=
=pdYQ
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
