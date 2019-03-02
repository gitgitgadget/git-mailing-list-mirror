Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588D320248
	for <e@80x24.org>; Sat,  2 Mar 2019 20:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfCBUF3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 15:05:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:49987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCBUF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 15:05:28 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbOoG-1gjbyH3aaK-00Inhd; Sat, 02
 Mar 2019 21:05:21 +0100
Date:   Sat, 2 Mar 2019 21:05:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
In-Reply-To: <20190301213619.GA1518@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
References: <pull.130.git.gitgitgadget@gmail.com> <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com> <20190301213619.GA1518@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k3ql2lfDXs54s/DOMx7245PstqSKd51EtypyLJE1yOqRw+rmP/n
 NDsIzd5RVCiitG6asvNuZwS5VST9M96FuNOtXTDESfjpd4j1X2RYrhrI0qwugyPxpshzPj+
 TzR9yCNQuydSHxlWR3c9NCAF+26Vd+idcl9N0OH+UFMkpbYsdWmsBl5Cv7EDeyl2aW0g0yU
 UcgD5YyJjqAU2/akukoiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Izs56piHzOE=:DeN/CTsiAcM6K+RaFFwaNl
 30SsvvZKVnqrs3KOR7ND+mFx0PjZwz+sASE+tSXCwJ8HqHgSAmjnmQZnQ76RsL7NTZqAypQfX
 GOBLxwgTD4uD+JxbQ/8TdjbAB64/5Pfdnlujf/RjflvOFasd1JE7oRiizvYFqivKXP6+Akklf
 wJz3DrVQE5X2IBPet5YYcoEEvkuUXjycQWDbDSTcU2lZwgqca0fyXhCPzl2cv2NmXQUm2TuXp
 Mie61fVtVjj+EPBQaQ2Svs4Bdap6mNArLpTSgyIqldkSUpzhec3HVHH1wPNAkJ3pyFw46TyXJ
 SpXsoCMDOAumeFQXa/xsP5FxBi+qNBOxH5Caf+9dsxuvyFkODibWLdqZNR5vp4+jEbLjn62KO
 q9e+DMcZ/4vgGS00Xpkp78gLp8aFvr0B3Mun3aw8NORz+gB3IBtvrGi4GZeWwSy778uV9zIBg
 dSYIJwtsW5BFYyDnrL1vr4cuSBAidt39oracqjR/WZDB6sM2tXIHFHluBBpDQhfxPPM+s2NF0
 qcDgTvDBSsfukI1TvhZIABAH6ryNqiGhkZS2zYxDiPkWFhopU9hcZBseMV1bd4Fhl4E7PNK5d
 FXQ0Gzy2ojIvXZugRoI63bVHa9zt2XGHyb+qZOr32BW6cvytxvs03XOnYzL3LrVgY0LNNo3EG
 5KmCqluXQcN/BczkQbr5TDotqScLrI3qdhLPGJt1ZV3wWvnwzrIJG3BktKyobfSxleMV8Xjly
 Mwv0An5ZgXFtImUc6ZlrI0AudsEiVICWWJn3q4eoFe1E/iBOuqhduiigAS94W/NyM+OM8BLDw
 iS8ydma/TXdZ4V4lRzC8NJAst08ReF83mmFB5Wj5jrlzRrBxwTtxkStEfrfjcnaSuPNY+wgXP
 7MwtlHeciPVKOQ+Z6azrseKpW4W+/VkCjGQqmpXXgvJPCVgwPxwruqZ7Ej6t3HVTK420ASriG
 fhSMtt0CUMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 1 Mar 2019, Jeff King wrote:

> On Fri, Mar 01, 2019 at 11:57:46AM -0800, Johannes Schindelin via GitGitGadget wrote:
> 
> > In d85b0dff72 (Makefile: use `find` to determine static header
> > dependencies, 2014-08-25), we switched from a static list of header
> > files to a dynamically-generated one, asking `find` to enumerate them.
> > 
> > Back in those days, we did not use `$(LIB_H)` by default, and many a
> > `make` implementation seems smart enough not to run that `find` command
> > in that case, so it was deemed okay to run `find` for special targets
> > requiring this macro.
> > 
> > However, as of ebb7baf02f (Makefile: add a hdr-check target,
> > 2018-09-19), $(LIB_H) is part of a global rule and therefore must be
> > expanded. Meaning: this `find` command has to be run upon every
> > `make` invocation. In the presence of many a worktree, this can tax the
> > developers' patience quite a bit.
> 
> I'm confused about this part. We don't run hdr-check by default. Why
> would make need the value of $(LIB_H)? Yet empirically it does run find.
> 
> Worse, it seems to actually run it _three times_. Once for the $(HCO)
> target, once for the .PHONY, and once for the hdr-check target. I think
> the .PHONY one is unavoidable (it doesn't know which names we might
> otherwise be building should be marked), but the other two seem like
> bugs in make (or at least pessimisations).
> 
> It makes me wonder if we'd be better off pushing hdr-check into a
> separate script. It doesn't actually use make's dependency tree in any
> meaningful way. And then regular invocations wouldn't even have to pay
> the `ls-files` price.
> 
> If we are going to keep it in the Makefile, we should probably use a
> ":=" rule to avoid running it three times.

Good point.

> > Even in the absence of worktrees or other untracked files and
> > directories, the cost of I/O to generate that list of header files is
> > simply a lot larger than a simple `git ls-files` call.
> > 
> > Therefore, just like in 335339758c (Makefile: ask "ls-files" to list
> > source files if available, 2011-10-18), we now prefer to use `git
> > ls-files` to enumerate the header files to enumerating them via `find`,
> > falling back to the latter if the former failed (which would be the case
> > e.g. in a worktree that was extracted from a source .tar file rather
> > than from a clone of Git's sources).
> 
> That seems reasonable (regardless of whether it is in a script or in the
> Makefile). Another option is to use -maxdepth, but that involves
> guessing how deep people might actually put header files.

It would also fail to work when somebody clones an unrelated repository
that contains header files in the top-level directory into the Git
worktree. I know somebody like that: me.

> > This has one notable consequence: we no longer include `command-list.h`
> > in `LIB_H`, as it is a generated file, not a tracked one.
> 
> We should be able to add back $(GENERATED_H) as appropriate. I see you
> did it for the non-computed-dependencies case. Couldn't we do the same
> for $(LOCALIZED_C) and $(CHK_HDRS)?

As you figured out, CHK_HDRS *specifically* excludes the generated
headers, and as I pointed out: LOCALIZED_C includes $(GENERATED_H)
explicitly.

So I think we're good on that front.

> > Likewise, we no longer include not-yet-tracked header files in `LIB_H`.
> 
> I think that's probably OK.

It does potentially make developing new patches more challenging. I, for
one, do not immediately stage every new file I add, especially not header
files. But then, I rarely recompile after only editing such a new header
file (I would more likely modify also the source file that includes that
header).

So while I think this issue could potentially cause problems only *very*
rarely, I think that it would be a really terribly confusing thing if it
happened.

But I probably worry too much about it?

Ciao,
Dscho
