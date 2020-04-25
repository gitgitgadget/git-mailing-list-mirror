Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D979FC54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 20:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFC72074F
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 20:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="icJor7LL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgDYU5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:57:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37642 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbgDYU5g (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 16:57:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0A1746042C;
        Sat, 25 Apr 2020 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587848254;
        bh=MfcTFGoOl3E8ZYSIbhle/d2jLOqiKL8FQnSMlkmfnwg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=icJor7LLpJHkDBryVGe7niCPtOva+biUV0Sx9Jqh7liy7stn4CV/hTQuW7EOB4mTX
         8m7wZGb+xrPXy2AHiydARSo8VxCJ8TMGkbS6fiIXTrAl4dBXAZ/zsJvCh55eqsPyLJ
         TXGAOfK39tQ+zI4SJqQnBrYAqvi2tDBs1rcjAUx8/K72I6G5cZLvqWvFO1vanyDe2v
         ToBGfLr1Pq3NQqHd4YCTSoY/Pl1qFFqYD5eyPWuQTEly/wdq9GQJWf36l5b2y27tKo
         SDzVSsSbCI7fa5lLwvBvIZTaPC630W+2/LYtOrhGOMHV3UGh1iZgrFpot7lZlr83zn
         PHy9+YOOd4YwlYOGR4lLuhezRJwJTn7CIDYbYtDQzS2RD5IWqRhuRYQsaln9AGJ5Xy
         9Ur6hCUo0g+naUtKCaivsaZwg1jVwv7kCMmHzjormtJ12dxpILSVUOTyHxzCDwijAN
         0xVCtHPUmBdYA1XZV6IDxY4BJHOmnLU0uBgSdJv6AfOIcFK0nLt
Date:   Sat, 25 Apr 2020 20:57:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] doc: propose hooks managed by the config
Message-ID: <20200425205727.GB6421@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200420235310.94493-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <20200420235310.94493-1-emilyshaffer@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-20 at 23:53:10, Emily Shaffer wrote:
> +=3D=3D=3D Config schema
> +
> +Hooks can be introduced by editing the configuration manually. There are=
 two new
> +sections added, `hook` and `hookcmd`.
> +
> +=3D=3D=3D=3D `hook`
> +
> +Primarily contains subsections for each hook event. These subsections de=
fine
> +hook command execution order; hook commands can be specified by passing =
the
> +command directly if no additional configuration is needed, or by passing=
 the
> +name of a `hookcmd`. If Git does not find a `hookcmd` whose subsection m=
atches
> +the value of the given command string, Git will try to execute the string
> +directly. Hook event subsections can also contain per-hook-event setting=
s.

Can we say explicitly that the commands are invoked by the shell?  Or is
the plan to try to parse them without passing to the shell?

> +Also contains top-level hook execution settings, for example,
> +`hook.warnHookDir`, `hook.runHookDir`, or `hook.disableAll`.
> +
> +----
> +[hook "pre-commit"]
> +  command =3D perl-linter
> +  command =3D /usr/bin/git-secrets --pre-commit
> +
> +[hook "pre-applypatch"]
> +  command =3D perl-linter
> +  error =3D ignore
> +
> +[hook]
> +  warnHookDir =3D true
> +  runHookDir =3D prompt
> +----
> +
> +=3D=3D=3D=3D `hookcmd`
> +
> +Defines a hook command and its attributes, which will be used when a hoo=
k event
> +occurs. Unqualified attributes are assumed to apply to this hook during =
all hook
> +events, but event-specific attributes can also be supplied. The example =
runs
> +`/usr/bin/lint-it --language=3Dperl <args passed by Git>`, but for repos=
 which
> +include this config, the hook command will be skipped for all events to =
which
> +it's normally subscribed _except_ `pre-commit`.
> +
> +----
> +[hookcmd "perl-linter"]
> +  command =3D /usr/bin/lint-it --language=3Dperl
> +  skip =3D true
> +  pre-commit-skip =3D false
> +----

This seems fine to me.  I like this design and it seems sane.

> +=3D=3D Implementation
> +
> +=3D=3D=3D Library
> +
> +`hook.c` and `hook.h` are responsible for interacting with the config fi=
les. In
> +the case when the code generating a hook event doesn't have special conc=
erns
> +about how to run the hooks, the hook library will provide a basic API to=
 call
> +all hooks in config order with an `argv_array` provided by the code which
> +generates the hook event:
> +
> +*`int run_hooks(const char *hookname, struct argv_array *args)`*
> +
> +This call includes the hook command provided by `run-command.h:find_hook=
()`;
> +eventually, this legacy hook will be gated by a config `hook.runHookDir`=
=2E The
> +config is checked against a number of cases:
> +
> +- "no": the legacy hook will not be run
> +- "interactive": Git will prompt the user before running the legacy hook
> +- "warn": Git will print a warning to stderr before running the legacy h=
ook
> +- "yes" (default): Git will silently run the legacy hook
> +
> +If `hook.runHookDir` is provided more than once, Git will use the most
> +restrictive setting provided, for security reasons.

I don't think this is consistent with the way the rest of our options
work.  What if someone generally wants to disable legacy hooks but then
works with a program in a repository that requires them?

> +=3D=3D Caveats
> +
> +=3D=3D=3D Security and repo config
> +
> +Part of the motivation behind this refactor is to mitigate hooks as an a=
ttack
> +vector;footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aied=
e.mtv.corp.google.com/]
> +however, as the design stands, users can still provide hooks in the repo=
-level
> +config, which is included when a repo is zipped and sent elsewhere.  The
> +security of the repo-level config is still under discussion; this design
> +generally assumes the repo-level config is secure, which is not true yet=
=2E The
> +goal is to avoid an overcomplicated design to work around a problem whic=
h has
> +ceased to exist.

I want to be clear that I'm very much opposed to trying to "secure" the
config as a whole.  I believe that it's going to ultimately lead to a
variety of new and interesting attack vectors and will lead to Git
becoming a CVE factory.  Vim has this problem with modelines, for
example.

I think we should maintain the status quo that the only safe things you
can do with an untrusted repository are clone and fetch because it sets
a clear security boundary.

Having said that, I'm otherwise pretty happy with this design and I'm
looking forward to seeing it implemented.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXqSkNQAKCRB8DEliiIei
gce4AQDXHfehwtuPZPD8TaTWddWn/MYtV0Y2c1I1nFZJ/VIBOgEAn3f7UWHfqH3S
+HSAZqlM9nDZ4MdILOM/XpebstVzdg8=
=02Ux
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
