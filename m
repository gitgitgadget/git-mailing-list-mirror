Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E39C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 16:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBOQxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBOQxm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 11:53:42 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E393DF
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 08:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676480018; i=tboegi@web.de;
        bh=GuxH/qf2aXpBgmRrGsSep14+nxHmKHYrck5OS+ZdOpg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hGcKHXGTqux3r8sfhL/wqpzEsWH+3kp3AyJw+wareJmecK20WqwXP8Ifckl49ApEA
         330OI2Q2mfxN/K2NaaKfAVSBq9LL40Gitw8rOdtmDm9+3D5f3sZp4IB0WzuZX+zGMj
         imK200xy2XV8Ok9dUeHKaXCcnW1ZXiMNWcB/w4De1JEeQVrrTUoESd+onlwePfIzHl
         XemJJf7agj/I8xiQ1KieZX+8Wg6bPa664PPnsAeaf6th9Ne67gQfQvPjlnLlhHUW/R
         phutEFOTMDfl+1ISjZfnX/mBnx7pSceCEBzI1fz8uNfx9sXVNgpP+SPwZdin1ekQyw
         diVAMSUBKLv5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLifq-1pAoBW2Iro-00HkDS; Wed, 15
 Feb 2023 17:53:38 +0100
Date:   Wed, 15 Feb 2023 17:53:38 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Patakreyp Chandler <patakreyp.chandler@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git oddities with case of branch names on Windows
Message-ID: <20230215165337.kq3d6xx6gbiamfsg@tb-raspi4>
References: <CAAR1xzQwhbHNFFyTJQvkSVLJyJz_Gj5_FQ_udJrjM=ou+3GB3w@mail.gmail.com>
 <CAAR1xzR9Vu8we4kBkd7rM2NAC63frxZs7Zr4wYNj3beNHtw0Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAR1xzR9Vu8we4kBkd7rM2NAC63frxZs7Zr4wYNj3beNHtw0Mg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Sn1jwDASeiIuJKTYRBjLrrf6QI+LenK7viYRHw83l8Pn+hlsz7m
 TV/hUq6+TUD0b7VQ7CC+ln4c+CnW/Z8xJQs2cSLdLilV1IAC4X2hesKashhcYwPVs6HTQLm
 v/u/5RpGfSsn9NQqe4ltxDhHeoshTLQYihIkoqfWu9OCyHR4ChjM3nErswCIBGidQOlXSaW
 VXcO9ufnmPH4loR5MLqIQ==
UI-OutboundReport: notjunk:1;M01:P0:EhSTxHKKob4=;FZt8B7OL6W9QabRKcRT0J/X42yw
 qt1UU58v7q7lRI5jDY2ZClBx5R7vBR79ZR3M2v1sLVgtnpdnunXbNuqp+s8QUSh/oVjE3etYP
 f5EVAObuuez4GnhIhLz7mTfTdska+b+RvsAPbOei0fpJy4HHSYhmLbE4CgsNKUI+XfIXJJxVv
 ui8cR5zylZxpBEd1/5nb2XMRG9HPdFRBP0wOD58Z9Y3wwHoV72mtjD6y+L30iJQqB/3ycdAzj
 bN5clXFK9di8XIbae4Z2HOGPh5wsRSbfGhV03lA/l2Ccb3tzKGdSQp9qcNnn9u0dHgEhSjaD3
 0TrfugGMeHe03j4z1UXyAM5J2eTk5n9hc8vdzlrDFJH2wKAZ+ICIKq1Q5h1HzdDH8BqnFePSn
 1f3D+yYGSpmaEyqO2rpZ1eRhY7PINHv5Ju80Q1bCeBd051AmMJpN45c3pxsD9H3KVb1liGQ68
 n06od7oBJOqc/dK996dUUzQk62zvJ5gnq9sfpNzYOBmgqWe+Wlqe4K733MeA2E3ylGluxJIJj
 QOwEwbMG2hVoGbzSszK2TYsuzVO5B/gKybtXSpjmhnOFEp9Hd8HbFHmwSD1x3k2tennasSrGB
 6ZZs4Z9aHBeOS+F1Swcq7/yXTmXQ+KlMQBIF1bVQxpQ/MGzo/Drda8mo5juLZo7R7dvCmSNzb
 XwTMoJoCTRTztAvQ6uVCgxCkhAsC4SdvX6a9zjHA5FgzXo/cERriIc0Q9E+RaENqErgSxbSXv
 VWU3ZCF1KZcX9vAbtDvSFcJFBRNXy9S5heTj6tyu5E9+XitQKZwgJpHyII8ENqaZmrPIpYAt8
 veASN3udhC5hmHaUJU6Kp+FwB7t7+CcyO2mAxkPkB8IWK47wZkW83Tf1UAXl6CVL+cHSVjiFX
 Xb75MRW4CQUZEK71rh7WkAYR9bFzdaQOiTv4CkFSiwV232udfaOm+L596IEF9plrpsBrVU5Bz
 MzN+UycqlgHKqdu3GpHQDO45Zv8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 02:28:38PM +0100, Patakreyp Chandler wrote:
> Hello,
>
> Here is a scenario for some oddities (bugs?) for case of branch names
> (at least with git version 2.37.3.windows.1).
>
> First, we have created an empty git repository on our internal GitHub
> server and we clone this repository
>     $ git clone git@github.mycompany.com:ID123456/test_branches.git pppp=
ppp
>     Cloning into 'ppppppp'...
>     warning: You appear to have cloned an empty repository.
>
> Then we create an object in this repository on main branch, we add,
> commit and push it:
>     $ cd ppppppp/
>     $ echo foo > foo
>     $ git add foo
>      warning: in the working copy of 'foo', LF will be replaced by
> CRLF the next time Git touches it
>     $ git commit -m 'foo'
>      [main (root-commit) 51789b0] foo
>      1 file changed, 1 insertion(+)
>      create mode 100644 foo
>     $ git push
>      Enumerating objects: 3, done.
>      Counting objects: 100% (3/3), done.
>      Writing objects: 100% (3/3), 869 bytes | 869.00 KiB/s, done.
>      Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
>      To github.mycompany.com:ID123456/test_branches.git
>      * [new branch]      main -> main
>
> We create a new branch in this repository and switch to it:
>     $ git checkout -b gggg
>      Switched to a new branch 'gggg'
>
> We create an object in this repository on the new branch, we add,
> commit and push it:
>     $ echo bar > bar
>     $ git add bar
>      warning: in the working copy of 'bar', LF will be replaced by
> CRLF the next time Git touches it
>     $ git commit -m 'bar'
>      [gggg 8f2fdd0] bar
>      1 file changed, 1 insertion(+)
>      create mode 100644 bar
>     $ git push --set-upstream origin gggg
>      Enumerating objects: 4, done.
>      Counting objects: 100% (4/4), done.
>      Delta compression using up to 4 threads
>      Compressing objects: 100% (2/2), done.
>      Writing objects: 100% (3/3), 929 bytes | 929.00 KiB/s, done.
>      Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
>      remote:
>      remote: Create a pull request for 'gggg' on GitHub by visiting:
>      remote:
> https://github.mycompany.com/ID123456/test_branches/pull/new/gggg
>      remote:
>      To github.mycompany.com:ID123456/test_branches.git
>      * [new branch]      gggg -> gggg
>      branch 'gggg' set up to track 'origin/gggg'.
>
> If we look at the local branches, everything is normal:
>     $ git branch -vv
>      * gggg 8f2fdd0 [origin/gggg] bar
>        main 51789b0 [origin/main] foo
>
> Now we =E2=80=9Cswitch=E2=80=9D to the exact same branch but with a typo=
 (here, 'GGGG'
> instead of 'gggg') in the case of branch name (this does not work with
> git on Linux "error: pathspec 'GGGG' did not match any file(s) known
> to git."):
>     $ git checkout GGGG
>      Switched to branch 'GGGG'
>
> We create an object in this repository on the (not really) new branch
> (with faulty case name), we add, commit and (try to) push it:
>     $ echo foobar > foobar
>     $ git add foobar
>      warning: in the working copy of 'foobar', LF will be replaced by
> CRLF the next time Git touches it
>     $ git commit -m 'foobar'
>      [GGGG 2ed967b] foobar
>      1 file changed, 1 insertion(+)
>      create mode 100644 foobar
>     $ git push
>     fatal: The current branch GGGG has no upstream branch.
>     To push the current branch and set the remote as upstream, use
>             git push --set-upstream origin GGGG
>     To have this happen automatically for branches without a tracking
>     upstream, see 'push.autoSetupRemote' in 'git help config'.
>
> Pushing actually fails because git says "The current branch GGGG has
> no upstream branch ", and if we check this badly cased branch ("GGGG")
> has no upstream tracked branch, but is still the same correctly cased
> branch ("gggg"):
>     $ git branch -vv
>      * GGGG 2ed967b foobar
>         main 51789b0 [origin/main] foo
>     $ git branch -a
>      * GGGG
>        main
>        remotes/origin/gggg
>        remotes/origin/main
>
> Switching back to the correctly cased branch does not seem to put back
> everything in order (list of branches is broken), but "git push"
> works, at least:
>     $ git checkout -
>      Switched to branch 'gggg'
>        Your branch is ahead of 'origin/gggg' by 1 commit.
>        (use "git push" to publish your local commits)
>     $ git branch -vv
>      GGGG 2ed967b foobar
>      main 51789b0 [origin/main] foo
>     $ git push
>      Enumerating objects: 4, done.
>      Counting objects: 100% (4/4), done.
>      Delta compression using up to 4 threads
>      Compressing objects: 100% (2/2), done.
>      Writing objects: 100% (3/3), 962 bytes | 962.00 KiB/s, done.
>      Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
>      To github.mycompany.com:ID123456/test_branches.git
>      8f2fdd0..2ed967b  gggg -> gggg
>
> Even trying to switch to other branches, still does not correct this sit=
uation:
>     $ git branch -vv
>       GGGG 2ed967b foobar
>       main 51789b0 [origin/main] foo
>     $ git checkout main
>      Switched to branch 'main'
>      Your branch is up to date with 'origin/main'.
>     $ git branch -vv
>        GGGG 2ed967b foobar
>      * main 51789b0 [origin/main] foo
>     $ git checkout gggg
>      Switched to branch 'gggg'
>      Your branch is up to date with 'origin/gggg'.
>     $ git branch -vv
>       GGGG 2ed967b foobar
>       main 51789b0 [origin/main] foo
>    $ git branch -a
>       GGGG
>       main
>      remotes/origin/gggg
>      remotes/origin/main
>     $ git checkout Gggg
>      Switched to branch 'Gggg'
>     $ git branch -a
>       GGGG
>       main
>       remotes/origin/gggg
>       remotes/origin/main
>
>  Any idea of what's going on? And how to fix it?

Thanks for the extensive written report,
very much appreciated to see a reproducable example.
For a longer discussion, see below.

If you want to get rid of the GGGG branch, I would suggest something
in tis style:

git checkout -b tmpbranch
git branch -d GGGG
git checkout -b gggg
git branch -d tmpbranch

Is there a better solution ?
The problem is that your file system treats GGGG as gggg

Running `git pack-refs` could help. But there may be disadvantages
for people having many many branches.
(And then there had been some efforts to write a new backend for refs,
but I didn't follow that up).

My suggestion is to use lowercase for branch names only.

https://git.vger.kernel.narkive.com/PrwMfgXR/branch-name-case-sensitivity
