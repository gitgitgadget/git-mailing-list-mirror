Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471CC1F731
	for <e@80x24.org>; Sat,  3 Aug 2019 20:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfHCUWo (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 16:22:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:60995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbfHCUWo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 16:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564863758;
        bh=MRcbtW4O4wFKaHCkPxrtb9TZTvW9YmVB5HCHBkFsysE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KdY53VIF4/r6xppcpvYOnkNh3DnhN7FEUMCXGgrIATWUzu5HpbTHaJo1lFooP1UPG
         Ed8sXkJuaE7gjgkkbVwJll/myAKJt8aB1qhesixXbY1AHHsvgIoExW0rVsTMxuylJX
         Gcu3aGPosMEJ33IUcE7V4txW4bTfx9awudOi80eA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1iTsax2jOP-00cwZN; Sat, 03
 Aug 2019 22:22:38 +0200
Date:   Sat, 3 Aug 2019 22:22:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/visual-studio, was Re: What's cooking in git.git (Aug 2019,
 #01; Thu, 1)
In-Reply-To: <xmqqk1bvlds0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908032217420.46@tvgsbejvaqbjf.bet>
References: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1908021405450.46@tvgsbejvaqbjf.bet> <xmqqk1bvlds0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:icxrvpDOIAQzjsApubOoSczg4sdGEByXk9P+kIFq3bLtwpwnU7Z
 W4hvLhh1Bz8TdLQ1SpoZHeVgZCBF8+CrMO7o40gNOkslRVaoJcZbtRVhf5vp2rVoqIz7UTe
 KjI71wP8cLfeFwH5eU577WZ7p0vFjZ3dPfLW/KtC+wt1UVwOnTmUp+2cP7W/RtH44S2DlNX
 jsIJ9pocgsAsPBZzsU8Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L7jnVwuVcoc=:OHrM46TcxfEJmDOeUVSkRu
 jLNcn3yOL9TC2WwWVvdKP4oj5JycqOnpGzgb0beKpRxcgP7lVOBdxOTWxoG07jlns2uDgEBpm
 2HXO/R3k/0wD5ImHOO1OhuvQzX/7vryLAUqyH1LUe4YG8o+AOAKepu/XBqhfH/j/j9kpgR0dQ
 oUtQIzglqV9f/NMaHWaaPf/XRWeAd6jjFq06JshSsUqP5FgqjlEUkSfkx5NojADiXDv4nzRQd
 aou4gEn47g3aiUp5ENDU4gPFtm+hLxFmZcFuIWoOEV4FYX8rztL2wFewnpeZSsraBJdm2LbCp
 E6udPlmFnN6//MT3CGP4U9Pp8+kjOTk4IQQkI8n5BcJ7Xyv/ErLvi8wAnRkVqop5hmmUXNyFD
 4L5R7BjNhwB6M1AuREJv5Wo9P5lPkfZR+6VdnTrZCP6h91GL8OtSi4pWdDz0LQsAsXtKHex8L
 uYnhv6sIIvxYCEkMvI2FjBszN5SamnsybbNVqzzNMEi4fYE/shPT9TdzwH1qD3lgmNeo227R1
 y7T6jParyYFScJWFJ0/aSCnQXufYNK0i46x47PkBQfVq9GdAtz78q8bK/rQGkWChlZOPPRMa6
 B/3T8fFn+UrVIiwhu2TBUma/bGJ4CViUoThz00CjJUc4MC42SQ7onPPq89/0e+8CgGSvGk6lH
 x2ixlVpntumMBZph4WZaZa1887rXYOum+2W4aqzB71lLpf8iJdffIJqMYQ+S1QLRo6NJEDKjU
 qgJ5JCOmj4IF+y4iy9pOj+/MJf1d3HlvTi8lTz7Q7NgdkLWqPupfKGk/ltVQTUPcdKzpU7Jgz
 5OvANlRGOBcNvNPsHwT3dIaWdHAMOKNppJKkzzDLjqDosgstFyo1jjh8t5jYMhquInW47Xh5+
 9KrR5/GfoOR5U5MYtSOxqOAIiOTm269NpQg6+4V5yUxtpV3jhcR94tb42cPnU3uYnk8BqY7UD
 rzZDjwRfbg7nokmqo9/mTo2X0ymxXnVEXNbfjt4qszQHAVC9iWhaaBbmNwW/5f0QRh81V3c9x
 ygQS+13sXLTJp8RX8ZoiqNGHQeI0vbZNIZ+jiGYr6k3kNXLcHc/WXNvLiBq5WanUD+a0Yk7Lb
 Co8QePBtqXyDiqz1wUuv8e+BUSr77P2ANCCgNMPM3TJLfHDTK8fI2BS81krMyTxYW3Nxtfxg5
 JPFFo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 2 Aug 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >
> > On Thu, 1 Aug 2019, Junio C Hamano wrote:
> >
> >> * js/visual-studio (2019-07-29) 23 commits
> >>  - git: avoid calling aliased builtins via their dashed form
> >>  - bin-wrappers: append `.exe` to target paths if necessary
> >>  - .gitignore: ignore Visual Studio's temporary/generated files
> >>  - .gitignore: touch up the entries regarding Visual Studio
> >>  - vcxproj: also link-or-copy builtins
> >>  - msvc: add a Makefile target to pre-generate the Visual Studio solu=
tion
> >>  - contrib/buildsystems: add a backend for modern Visual Studio versi=
ons
> >>  - contrib/buildsystems: handle options starting with a slash
> >>  - contrib/buildsystems: also handle -lexpat
> >>  - contrib/buildsystems: handle libiconv, too
> >>  - contrib/buildsystems: handle the curl library option
> >>  - contrib/buildsystems: error out on unknown option
> >>  - contrib/buildsystems: optionally capture the dry-run in a file
> >>  - contrib/buildsystems: redirect errors of the dry run into a log fi=
le
> >>  - contrib/buildsystems: ignore gettext stuff
> >>  - contrib/buildsystems: handle quoted spaces in filenames
> >>  - contrib/buildsystems: fix misleading error message
> >>  - contrib/buildsystems: ignore irrelevant files in Generators/
> >>  - contrib/buildsystems: ignore invalidcontinue.obj
> >>  - Vcproj.pm: urlencode '<' and '>' when generating VC projects
> >>  - Vcproj.pm: do not configure VCWebServiceProxyGeneratorTool
> >>  - Vcproj.pm: list git.exe first to be startup project
> >>  - Vcproj.pm: auto-generate GUIDs
> >>
> >>  Support building Git with Visual Studio
> >>
> >>  The bits about .git/branches/* have been dropped from the series.
> >>  We may want to drop the support for it, but until that happens, the
> >>  tests should rely on the existence of the support to pass.
> >
> > As of v2, the tests rely on that existence again.
>
> Yup.  I think they are now in good shape to be among the first to
> graduate post release.  Building the warning facility necessary to
> start dropping the $GIT_DIR/branches/ support would be too late for
> this cycle, but now this topic is independent from that, so it may
> even be worth considering to have it in the upcoming release.

I see that you made up your mind and graduated the branch to `master`
already. Very happy about that, and of course I hope that this was
intentional ;-)

Just so you know what's building on top of this: I do have a PR lined up
that adds an MSVC build to the Azure Pipeline, but I have second
thoughts about it and think that it would probably be better to make
that a full Visual Studio build (the difference being: the MSVC build
requires both Visual Studio's Command Line Prompt *and* Git for Windows'
SDK to be installed, while the Visual Studio build would require only
Visual Studio for the build, and the Git for Windows SDK only for
generating the project files -- and maybe even a Linux agent could
generate those now).

In short: I hope to get the CI to the point of using the Visual Studio
support and testing it, over the next cycle.

Thanks,
Dscho
