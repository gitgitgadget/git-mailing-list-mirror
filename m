Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBA6C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FAA12333D
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbhAFVte (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 16:49:34 -0500
Received: from mout.web.de ([212.227.15.14]:51897 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbhAFVtd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 16:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609969658;
        bh=R4g1tysHfvKd9nm2unQo2JqmgcCcnu0K8I2hzR9aVZE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eFkoMvnIPjnhQcPHq9iw5+HdX/erj2OFa5R+nUbmOteF7p37XeIIBn4ryEZ8dDgxe
         i5k+mCCC5oEszxbR8eFpTP2fSal+mVUeOSggytQT23UHywPtqL6TPx0C4FNRR7BLZl
         NaTnZJC5nxe1J6Zb6xMoNicpT6IOsyBbfSfD5+hw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01Za-1k0daR3igI-00xAO2; Wed, 06
 Jan 2021 22:47:37 +0100
Date:   Wed, 6 Jan 2021 22:47:37 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Daniel Troger <random_n0body@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special
 characters)
Message-ID: <20210106214737.qwlp4jvg3x2voafs@tb-raspi4>
References: <20210106142137.gxd2a4vnrsjj4jq5@tb-raspi4>
 <B311BF22-6193-4CCF-BBDA-DE27709BBCC0@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <B311BF22-6193-4CCF-BBDA-DE27709BBCC0@icloud.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:HmedfWA+mCDtFBBSIzUtEBQG1rT7Fc9l9wP9EfIorVQWST56U3a
 SkY1GrtVh6veD0JVM3KmQup6lIeODgJWpX53/brA5VPVAER0vczduC/lfjjt7h6UXdPrkVV
 KI522ObOqEx8n1M7DvBxZ8JD0+7b8F7g9ZfrR5yBy8rZ1B6RhwIIrUktbedcpDfUjJxeoEL
 fQtHhO7cFf44VshSADGNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wHRqwUcx1xA=:ZIZ3MUEQw/hTG3xlpPejYC
 iBH/w6Su4EqjKpLbl3/aFN+hGhv71lyNwDZWwmeILMJvC5NWeoVAm31PLSFZd2HWzwvzsR7eo
 xx2fKRbur/Gg2K2vwIHt9GmYligz4W67HdHuaQ0PWKrfv5eczfBRPJ2hI0R7482tbmBd1h+pV
 0X2S2Z3Oq7VujlXP+DGjj2UI5Nq1yU/TWFDY01HwpuhXaYLXEPuAEOQuX+BaJFiejA8HOyY/5
 cGPKC45ypYWC7aUeEJ9a6eZ1fsKYCo+z96cWjTSTcI2YZeo+LPPCeh22E8BdKnSgSdfSClVCo
 OrH90TfhPm2obrZAaBDoWCE4Ho6BZYX+oP8QFfYfHQLMAsHLLCFg+djMGNHB99CpiZxue5hDW
 gSL73rcMtL2Qs+Us0OI5MxPIUIDhKbaKYaB9inDpfMuJ8yARYNf3G1iNgaSqqP2mQXQV4p0dv
 ohLSNhQPZKqdE93ZDcwNcKGxGXYC+W4h2sMvXIrp34xmC9x8/mlvxHl85VmPCvDQtDUUWtWbT
 blNROf5sI/cIGUl03QW3111XDYtBZBG817EKUnZcrw1fKEZBRwht+NNX05lORVSjRQ9v2tXzr
 ndIgYB6Oy7HJYOngnURKMa+Z/3D5ddLgrl+XeHCqGPA8OInp0n/BeAg+25lUNI3CVPQ+atKuu
 8STAqXKvN8I8eZAvNfg1IcdlCWhA037WBgsYi/FUXLdBDImGFCdV3/+TAN65rDRII6bm+UdBR
 vdkVSpE1r1FCJVONfmd1gfGGnqfgdPrIqVN+P00Wjhcxi+dv9Y0jxibKPSFd8XGFY8x8+3tnd
 DfxPSVvcHVAnLS3gfrDjFdU/uVRA1+xLdj1YZR1K7RSMfJ5lvKKbNik/UAq8av8VP7fkLpYr3
 el8cgE6JJ5ADCoA4ygWw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 06, 2021 at 05:49:17PM +0100, Daniel Troger wrote:

(Please avoid top-posting in this list)
> Hi, thank you for investigating. Here's the output you asked for + proof=
 the issue still persists on the latest version of git:
>

Thank's for testing the latest version.

Is there any way, that we can reproduce your problem ?

We don't have access to you repo (or do we ?)

Unzipping your zip on a Linux box shows these file:
./__MACOSX
./__MACOSX/paulbrunng=C3=A5rd-springyard
./__MACOSX/paulbrunng=C3=A5rd-springyard/._.DS_Store
./paulbrunng=C3=A5rd-springyard
./paulbrunng=C3=A5rd-springyard/.DS_Store
./paulbrunng=C3=A5rd-springyard/empty

Is it possible to make a step-by-step receipe to get a dummy repo into
this state ?

> ```
>
> me@iMac:[redacted]/paulbrunng=C3=A5rd-springyard/src$ git restore -p .
> BUG: pathspec.c:495: error initializing pathspec_item
> Cannot close git diff-index --cached --numstat --summary HEAD -- :(,pref=
ix:44)[redacted]/paulbrunng=C3=A5rd-springyard/src/ () at /usr/local/Cella=
r/git/2.30.0/libexec/git-core/git-add--interactive line 183.
> me@iMac:[redacted]/paulbrunng=C3=A5rd-springyard/src$ git --version
> git version 2.30.0
> me@iMac:[redacted]/paulbrunng=C3=A5rd-springyard/src$ git config -l | gr=
ep unicode
> core.precomposeunicode=3Dtrue
> ```
>
> > 6 jan. 2021 kl. 15:21 skrev Torsten B=C3=B6gershausen <tboegi@web.de>:
> >
> > =EF=BB=BFOn Wed, Jan 06, 2021 at 12:35:26PM +0100, Daniel Troger wrote=
:
> >> Thank you for filling out a Git bug report!
> >> Please answer the following questions to help us understand your issu=
e.
> >>
> >> What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> >> I ran `git restore -p .`
> >>
> >> What did you expect to happen? (Expected behavior)
> >> git restore to open in interactive mode and letting me select data to=
 discard
> >>
> >> What happened instead? (Actual behavior)
> >> I got an error message:
> >> ```
> >> me@iMac:[redacted]/paulbrunng=C3=A5rd-springyard/src$ git restore -p =
.
> >> BUG: pathspec.c:495: error initializing pathspec_item
> >> Cannot close git diff-index --cached --numstat --summary HEAD -- :(,p=
refix:44)[redacted]/paulbrunng=C3=A5rd-springyard/src/ () at /usr/local/Ce=
llar/git/2.29.2/libexec/git-core/git-add--interactive line 183.
> >> ```
> >>
> >> What's different between what you expected and what actually happened=
?
> >> The main problem is that the command didn't do anything. It basically=
 printed an error message instead of changing a file in the way I wanted.
> >>
> >> Anything else you want to add:
> >> Yeah. So pretty obviously the problem is the "=C3=A5" in the filename=
. The interesting thing is that the folder with the "=C3=A5" in the filena=
me seems to exist twice, with differently encoded "=C3=A5"s. But their con=
tent IS AUTOMATICALLY PERFECTLY SYNCED. And the only tool which recognizes=
 them as two different folders is git. ls in the terminal shows them as on=
e, finder shows them as one, even "glob" in php shows them as one.
> >> This is what git seems to see them at (taken from git status):
> >>
> >> `modified:   "paulbrunnga\314\212rd-springyard/`
> >> And further down:
> >> ```
> >> Untracked files:
> >>  (use "git add <file>..." to include in what will be committed)
> >>    "paulbrunng\303\245rd-springyard/"
> >> ```
> >> Here is a zip containing the folder (emptied): https://arxius.io/f/7e=
c7e1c7
> >> I tried creating a new git repo, extracting the zip in it, going into=
 the folder and running `git add empty` and could reproduce that git sees =
it as two different folders.
> >>
> >>
> >> Please review the rest of the bug report below.
> >> You can delete any lines you don't wish to share.
> >>
> >>
> >> [System Info]
> >> git version:
> >> git version 2.29.2
> >> cpu: x86_64
> >> no commit associated with this build
> >> sizeof-long: 8
> >> sizeof-size_t: 8
> >> shell-path: /bin/sh
> >> uname: Darwin 17.7.0 Darwin Kernel Version 17.7.0: Sun Jun  2 20:31:4=
2 PDT 2019; root:xnu-4570.71.46~1/RELEASE_X86_64 x86_64
> >> compiler info: clang: 10.0.0 (clang-1000.11.45.5)
> >> libc info: no libc information available
> >> $SHELL (typically, interactive shell): /bin/bash
> >>
> >>
> >> [Enabled Hooks]
> >>
> >
> > This uses the decomposed form of "=C3=A5":
> >> `modified:   "paulbrunnga\314\212rd-springyard/`
> > ...
> > And here is the precomposed form og the "=C3=A5"
> >> Untracked files:
> >>  (use "git add <file>..." to include in what will be committed)
> >>    "paulbrunng\303\245rd-springyard/"
> >> ```
> >
> > Both are lowercase, right ?
> >
> > What does
> > git config -l | grep unicode
> > tell you ?
> >
> > I have
> > core.precomposeunicode=3Dtrue
> >
> > and that what we need on a Mac (to handle precomposed and decomposed b=
etter)
