Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514B6C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36541603E9
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhIJLM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:12:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:54713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232732AbhIJLM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631272304;
        bh=P7Q6dxukcBMeirAXhmrenWsa6zclChlmKOEtKes0oPo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BHQJLcSLmMM6fQrgEQ4nvuYdb3EbLoy1rASMHgDel9jxyQp10/7jzHo9XlYAZ9WHz
         FVChdQoGljPE4P0jv/eBAUeAqyrY9z1sQTGHVOZW8f5FKG/raJvOUmqXvZe7vOtTc6
         vG3EJ47oR1Z+X+JaRrPUuWgMzlMjtjYjMRd7kMo4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1maVrR2a7h-00PeVF; Fri, 10
 Sep 2021 13:11:44 +0200
Date:   Fri, 10 Sep 2021 13:11:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Lucas Araki <lucas.t.araki@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Error: error converting ".git" to absolute: EvalSymlinks: too
 many links
In-Reply-To: <CALM-bLiWrJQnU3M5ToQo+72hvToHRknfvH5RVy2zHUgnnsdpXg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109101303370.59@tvgsbejvaqbjf.bet>
References: <CALM-bLiWrJQnU3M5ToQo+72hvToHRknfvH5RVy2zHUgnnsdpXg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lzTQ4aX3wTTgfcb1D6srphLN/uj1Gj2oWoYg9/405EzIjaSwyWp
 +gVU1aMI79n50rXC6m7X5JfbwbLG8HnD7b7lggFxRRuxGTsfetAHuYk1UeB6NG9KJMb4Igz
 +vHHuHpOklvPCTOyz0W4t0A7i/+t4pe3OiFj7Ps+OPcGicBn6TFvGP5YdXcUTZpNQgK/aDv
 xTkWNE/q7qX8HhL67johw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GUMi/jJ+rOo=:o25w0yN3lVi74N2a5QBJ7d
 VGtGY5pj9M/Hk+vKyRmNyZ7zfInZ9gsf/BBSSfzOWvWl8d92xn2jweMXNIm/Dc9AvOrmpAXL0
 vTVNd/pSkStFpNX539lpP65wZGnM7/3xtjZQDGQXhMWqT3MGMYIe4rQr0Dn5VVt9Z0786NbXq
 +hHjdrEXOy0XA6ZYs5grSmW2EqaVQHZFQxND4hnAjDsBO76mw6GUSB4zn1oOmKLjeRuewrVBT
 bJE6WNM5loSC0awTegtfdkafU5YYsiEPsgVKbmYRbdsgY575GpHcThqg1Q3NHjmU5u0JEMkGr
 JC3fUI2lX16OusaAvETr0USmoVZHBIzB9Q/UV6Yut9OBUdqPDX0Cqts8WDAQMMt1ERKBFsFHl
 vs3BTpinahaXDC96ODtYt36Fb3ZQwqgKoI6co9kVF/ehrvIDxiWOSZTdMimnMnjAWMhl4rJpZ
 Il4nmmFLzlylm9xl8eAPEjlYOn3CvT+C19mvmJzJK3uvAELBtWdU/CwaaDahosl2PsK1GVmdS
 LOHCX3c1H+FDQDH3jL7RGJOEm0aBHjuOBqa8pFBnADR5qWRXc1kyM6Qth+3pY9deaZw2zT9Ea
 5MkYHRxA2WHJvwDIzLXg3eqPgE7YBfcvoDKC3Re+ziJBmv8RXhNwOeWbhJsvCSuQ8N12HlAje
 DjYdcu2mdjIoQZuvbxjCGzB4FJPnIPsGMWVeF5hj6MODyX/WJX8CbjrQmcxEcjYrwbhx/qcLU
 tmWxkk9wBT2hjYf1gq8xm0AHkEmMG4ai/cDAknPHHyq+qKZvqYBCqscSfKVWS1w+uYtH0EX0x
 d4zaUd7U6edvJlhaU1E47sFShyabGzB8tLMtx2s3f3jSsRTWZUveFqoLg2fB1cJSl/uX/mUo4
 0arN+GM2RuPrrpfhCzjaBR8PCndFkhROBXodl3ctR2Rdjzg/yS6foOeNQScikhzamAayD0OvD
 5o+80EUPUrSBLBJedXqBPYNdIu2vNcMVcDB9LXfmHPeGewBb7U5KOzr6bNy41hG403qixmpPE
 DGpfoS2akrS8F/szhCQkMpbATyKVZOeHmThudaJk1JgtbTn8ylDigMdBo+vEhiWd10vCiw4VO
 9i867nfZ6XkfyE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lucas,

On Thu, 9 Sep 2021, Lucas Araki wrote:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Attempted push operation
>
> What did you expect to happen? (Expected behavior)
> push operation success, no error message
>
> What happened instead? (Actual behavior)
> Push operation failed with error message:
> Error: error converting ".git" to absolute: EvalSymlinks: too many links

The "EvalSymlinks" part makes me believe that this is an error message
produced by Go, and since you indicated that you use Git LFS (which is
implemented in Go), that's where I looked. And I think I found a relevant
bug report:

	https://github.com/git-lfs/git-lfs/issues/4333

It points to https://github.com/git-lfs/git-lfs/issues/4012, which in turn
points to https://github.com/git-lfs/git-lfs/pull/4418 which was merged on
March 4th, well in time for Git LFS v2.13.3, which was released on March
26th.

However, you mention in passing something like "Box"? Maybe that's an
important piece of the puzzle.

In any case, I would recommend taking this to Git LFS's bug tracker.

Ciao,
Johannes

> ref feature/feature_name:: EvalSymlinks: too many links
> error: failed to push some refs to 'https://my_server_name/my_project.gi=
t'
>
> In addition, lfs/ directory was created in project folder instead of
> .git folder.
>
> What's different between what you expected and what actually happened?
> Did not expect lfs/ directory to be created in project folder.
> Don't expect error on push operation.
>
> Anything else you want to add:
> After reading issues #4050 and #4012, attempted:
> `git lfs env` and got output:
> git-lfs/2.13.3 (GitHub; windows amd64; go 1.16.2; git a5e65851)
> git version 2.33.0.windows.2
>
> Error: error converting ".git" to absolute: EvalSymlinks: too many links
> Endpoint=3Dhttps://my_server_name/my_project.git/info/lfs (auth=3Dbasic)
> LocalWorkingDir=3D
> LocalGitDir=3D
> LocalGitStorageDir=3D
> LocalMediaDir=3Dlfs\objects
> LocalReferenceDirs=3D
> TempDir=3Dlfs\tmp
> ConcurrentTransfers=3D8
> TusTransfers=3Dfalse
> BasicTransfersOnly=3Dfalse
> SkipDownloadErrors=3Dfalse
> FetchRecentAlways=3Dfalse
> FetchRecentRefsDays=3D7
> FetchRecentCommitsDays=3D0
> FetchRecentRefsIncludeRemotes=3Dtrue
> PruneOffsetDays=3D3
> PruneVerifyRemoteAlways=3Dfalse
> PruneRemoteName=3Dorigin
> LfsStorageDir=3Dlfs
> AccessDownload=3Dbasic
> AccessUpload=3Dbasic
> DownloadTransfers=3Dbasic,lfs-standalone-file
> UploadTransfers=3Dbasic,lfs-standalone-file
> GIT_EXEC_PATH=3DC:/Program Files/Git/mingw64/libexec/git-core
> git config filter.lfs.process =3D "git-lfs filter-process"
> git config filter.lfs.smudge =3D "git-lfs smudge -- %f"
> git config filter.lfs.clean =3D "git-lfs clean -- %f"
>
>
> Realized that project was in Box drive folder, set to keep local copy,
> but based on issues #4050 and #4012, decided to try moving project to
> a different local location.
> I copied entire project directory our of Box folder, then re-ran `git
> lfs env` and got output:
> git-lfs/2.13.3 (GitHub; windows amd64; go 1.16.2; git a5e65851)
> git version 2.33.0.windows.2
>
> Endpoint=3Dhttps://git.elsys.gtri.org/scm/tads/tads-suite-test-plan.git/=
info/lfs
> (auth=3Dbasic)
> LocalWorkingDir=3DC:\Users\username\myProject
> LocalGitDir=3DC:\Users\username\myProject\.git
> LocalGitStorageDir=3DC:\Users\username\myProject\.git
> LocalMediaDir=3DC:\Users\username\myProject\.git\lfs\objects
> LocalReferenceDirs=3D
> TempDir=3DC:\Users\username\myProject\.git\lfs\tmp
> ConcurrentTransfers=3D8
> TusTransfers=3Dfalse
> BasicTransfersOnly=3Dfalse
> SkipDownloadErrors=3Dfalse
> FetchRecentAlways=3Dfalse
> FetchRecentRefsDays=3D7
> FetchRecentCommitsDays=3D0
> FetchRecentRefsIncludeRemotes=3Dtrue
> PruneOffsetDays=3D3
> PruneVerifyRemoteAlways=3Dfalse
> PruneRemoteName=3Dorigin
> LfsStorageDir=3DC:\Users\username\myProject\.git\lfs
> AccessDownload=3Dbasic
> AccessUpload=3Dbasic
> DownloadTransfers=3Dbasic,lfs-standalone-file
> UploadTransfers=3Dbasic,lfs-standalone-file
> GIT_EXEC_PATH=3DC:/Program Files/Git/mingw64/libexec/git-core
> git config filter.lfs.process =3D "git-lfs filter-process"
> git config filter.lfs.smudge =3D "git-lfs smudge -- %f"
> git config filter.lfs.clean =3D "git-lfs clean -- %f"
>
> Noticed that LocalGitDir looked correct and was no longer blank.
> Re-tried `git push` from new project location and push operation succeed=
ed.
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.33.0.windows.2
> cpu: x86_64
> built from commit: 8735530946cced809cc6cc4c2ca3b078cdb3dfc8
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19042
> compiler info: gnuc: 10.3
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>
>
> [Enabled Hooks]
> post-commit
> post-checkout
> post-merge
> pre-push
>
