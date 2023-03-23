Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297ACC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 05:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCWFcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 01:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCWFc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:26 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C8D222F8
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 22:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679549471; i=tboegi@web.de;
        bh=BYHyN8ztbVLZi6J58rZmRTdvQTmk12u8uJusdbBnN9g=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZdEaRZE8Vw238uwfgvVG0HkRuB6b7T3+xFD/BXfQ/c/2HoMJRNkpiKPP8BMu9d4gR
         HCuWQKKK5ZQPlpf1NWuIjqcSmEAD+Y57n37ByTI7gz8d0VfVkXRgQFy+VUVmA1KTZg
         MZE0GEV5PT0HrqXn0/CY6PJm4Eyjq5b7+adB91CD9eHnG8TN6XwLpCeuW8BpaqodoB
         8nWx+2+YmIYdb1y20CeNZTICp8FedbjJoo64WDrVrwmKsCmIkGclsvSGndMZcTdIzA
         b/aElhLpVuppW1KLbg77tEcxFWI/WkrdQoHcXHKMxgTCuXuxfiV5c15nRHHPkMe/xS
         mFFBj5zo1TV8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbTH3-1qBoT13NgP-00bvlr; Thu, 23
 Mar 2023 06:31:10 +0100
Date:   Thu, 23 Mar 2023 06:31:10 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Sjur Moshagen <sjurnm@mac.com>
Cc:     git@vger.kernel.org
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
Message-ID: <20230323053110.z64tcce5dy3q7yew@tb-raspi4>
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:7zmiaGpDt+5oHUPS+RqYNqeFbUjf2NQvRoNk/yYgCGuKFn+iQij
 l4d2fPym1PFiJJ3RlzK6tgVzZ8MCG2ocygCxvzpw8ae+etvfbULzUuK4L1sRqb4NpdJ9l3I
 szzPSgdxMIg3rJuozL8bO1bw6p8qNPbmXmHrZ5r9xQtRK8jX7xPUw2UjALSOXaEbEUhk/8F
 waF2Ur5lSHR100HyaDXjA==
UI-OutboundReport: notjunk:1;M01:P0:uUok12wpP9A=;WgsC56c0yNpXjjZajBlJXTU2DEP
 y+jCaZcqaqvNf8/Znutykndu8xkeWP//CrcxEqK4BGz3hacZh8HHgTOq5BcFqDFWkjkEUtKSb
 C3HomGBGW/AYeTe/gJ6+tkS8plY+cIAj6uMuCIST2pLFXNiFzuFlssd7bW+BqxfBZRXsy4XC6
 MdZlz3sSPoxXHMRxNs2bOngutr4xGQY14exKzhgcPUFutnLPCqlYqXGdjYt4OyaSPx9Vsq80x
 Wuxu9vvIPIMT0FLNDP4PSz0SSEEntlDFCo0tTCz6yg5l0jFA5gldd8CfaUMw2jbVrg/3lEAhx
 5JMSkQJvXe85p9S4NK7+noAjhOQ2b6LzQmPQNqIbxZU78Y0Qzw2pwfI/lRLQsvSVCn6Sdb9+G
 hzzwQ8HTZ/utHB6501Z3NSBCE2gazzLoK4jZA0EVaiq6/sEgiAVoeQi9BQe3lpPw0ULUJBAzP
 7izDBBjtUhzROOTWeHGPfQW/Dh6UeD253ywspfsM8DzE99hOGdxI+H4q10P3/CoOsCEYsVkHc
 6UoY50ZPlKLOgu5MEF8UcM50UxLIwfrG5Dz+IP4tM9EEoGmYr7ET9FemNdhlK/tSlMAstS5/Z
 Gj/whKz2ChHHmUQOfUs/vsHDa5wbuIDuwaUxE5uAYF/I7FG2ddyD9SG6m8xNppIMmh0lgfRZB
 I9FPh+4npHxygT/WoJzrev1erdg5HK+ZUcFiijssRN8wV3Kqx7Ksz55hQRpJJsJhF6WsBZ700
 5hJ/W9VvirUOqmwjtOXxhZwy2x4ZAJG++GsymZs7UdC5p3/KPYxXF+7v+R3MDAhuxN4vdcj2M
 26pPb+b7PeaAr31NMxDQYmm8JXpmwE1H5/HfXwzMaNzhvgdBHcetR96NupTLqJ9x2Bia0fRKp
 tbvSRxLmRhw+3/TXb0o1XzemH/WWeebfUW4bYCdir0JhuVx+QLJfUeqm/t9tujPuEpjju3g+x
 n6Bu1btef23lr/PDarEGLAknGSw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 05:28:49PM +0100, Sjur Moshagen wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> git clone https://github.com/giellalt/lang-sma
>
> What did you expect to happen? (Expected behavior)
> Clone to be clean, as reported by git status
>
> What happened instead? (Actual behavior)
> git status reported four changed files
>
> What's different between what you expected and what actually happened?
> Nothing except those four files
>
> Anything else you want to add:
> This only happens on an M2 Macbook Pro. With Apple's git (1.37.1), a hug=
e number of files were reported as modified.
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.40.0
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 22.3.0 Darwin Kernel Version 22.3.0: Mon Jan 30 20:39:46 P=
ST 2023; root:xnu-8792.81.3~2/RELEASE_ARM64_T6020 arm64
> compiler info: clang: 14.0.0 (clang-1400.0.29.202)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
>

As a general note, the current .gitattributes file can still be improved.
The general rule and recommendation would be to start the text attributes
definition by using a "catch all" rule, followed by files that need
special treatment.
The very first text/binary line would be
* text=3Dauto
which will tell Git to auto-detect all files (and file types),
see below,
This basically prevents corruption of binary files.
which are not mentioned later.
Like README.md, LICENCE and so on.
Then there is a list of file extension, that are known to be binary,
you can add them as shown below.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
# List of files to be included in GitHub statistics.
# DO NOT EDIT - the file is updated via the template system.

# Some defaults:
* text=3Dauto
*.aif     binary
*.aiff    binary
*.docx    binary
*.fomabin binary
*.gz      binary
[snip]
*.sh text eol=3Dlf

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Now, lets look at the at the master branch of the repo:
commit 4e0d949dbbd13a4dd9285ae3dee63abc822b805a (HEAD -> main, origin/main=
, origin/HEAD)
Author: Sjur N Moshagen <sjurnm@mac.com>

Please run
git ls-files --eol
And you will see a line like this:
i/-text w/-text attr/text eol=3Dlf	corp/SN=C5SNINGEN 2014/43 uke/N=E6rings=
liv.doc

The "i/-text" will tell us thet Git identified the file, as commited into =
the repo,
as binary ("non-text").
The "w/-text" will tell us thet Git identified the file, as seen on disk,
in you working tree,  as binary ("non-text").
So everything looks fine, so far.
But the comes "attr/text eol=3Dlf", wich tells Git to ignore its feeling,
and possible corrupt the file at the next commit, converting CRLF into LF.

As an exmple, the "corp/SN=C5SNINGEN 2014/43 uke/N=E6ringsliv.doc" will be=
 corrupted.
It may or not be reported as changed. after a fresh clone. And others as w=
ell.
But in any case, it will be corrupted when you commit it.
Oops.

And why is that?
Because people had forgotten a line like
*.doc binary
for the doc files.

To put it in harsh words: I would call the .gitattributes file broken.
Please consider to change the default to auto, as pointed out by
others as well.

My version of a .gitattributes would look like this:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# Some defaults:
# Stay on the safe type for files that may be added later
* text=3Dauto
# shell files need lf
*.sh text eol=3Dlf
# Add other file types, like *.gz

# Include in statistics, no syntax colour ATM, classified as text instead:
[snip]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

