Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01274C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3F561159
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 17:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhGQRIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 13:08:35 -0400
Received: from mout.web.de ([212.227.17.12]:51169 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231767AbhGQRIf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 13:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1626541536;
        bh=KkQ9iRfFCHbBHWOTs+lVIqsYxV+LEKJwCmk3pkra9Zk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EDvITcNZQFj675PqBEbjzekXgpTtOLN+75A6UH7iMfrtp/g0M8/xoa/M2P3scCyic
         1WVelj4c22/iyHTo/0ubTp9eVHsoI6n8gVFtVfqlCuqydF46MIx/51Sfe03mTjtUnT
         aMdCnwP3Rq4B4cFadgIYCu5F2xfppNwRDGdzdkLg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgJM-1lr6dW2d6o-00Dssy; Sat, 17
 Jul 2021 19:05:36 +0200
Date:   Sat, 17 Jul 2021 19:05:36 +0200
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Rostislav Krasny <rosti.bsd@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Incorrect and inconsistent End-Of-Line characters in .gitmodules
 after "git submodule set-branch --branch <branch_name>"
Message-ID: <20210717170536.x2n443dtejk76wfp@tb-raspi4>
References: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:q3v8/M5M1tWme6zzm7rumg/xhQ89TDGWLpPQyCh+yPKteDXyDRG
 deTvnpCDagTN/RRZkyHkAlnAE9ULFYUbfNEblNiXMJQiRV5x/+f+wvl37LZm9WCtstBeRGV
 kvJHG5+YmqKyto2qU7pIR2jHoDjI+YkHEkVs/bPLOT+dLiD/k+O3TP+S1zM83VtOiDjSRoQ
 vVJpTAr23foHyJsqpIQEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ki+sJeNpFTY=:wi9GLvFMtgPaaRW8FVdm5z
 TGF4bMqixRJs2124dNGFHd69jisfZTCHWDsdDMA9GiwiVC8/z61eTJv02x+iG+5AOYvlWk+go
 NVFFP1IWXI/yF7TxnwtDfE9czyy9rSSMR4MfSzn5EZoLe08y4KS7rHN8MNiSc/x3KQEbfNW0+
 dYdCThZUugKweJVv/4HYkq57ETXmTX+QqTxWMm+wmMdoibH2K4e92GJPDkeaBWhOO5RYJbqIT
 6KoP6jGQiVHcxHoX7BtTf+I8VRpUKUgWhFfZFxiRM+PNfkd7amAhMT8AdYF8eLOtbxN1fWOAG
 pmNB956Vx31RUV5Af6MY8NzyIlq0g6clfEceWTHEb7Mk2fJU9QBpHDw8gTJi/OFOBlOhBtlWL
 3uHG6R1NVtcdjNlhQwg3N4AwZLvOVXmcwRsQcsxDnLaFdGhbx+K3UcAk6VHLGJPSDFNp5Vd/A
 6HleF3LRSg2YEtAKjy73RgdjxQqR0lPnVLxeVLqyXB0RTPrJsEn1X31YWFanJe/26m7YwZ2y3
 Q9WhnCe6ORj+R44BVSKVkG39Sxs4LpV/67AfnEEunx/mW6ic7Fn6ztBsxp2uyVVq3HGO5fU8I
 NiS9mitiHyRZ2JV5wxngayuNxxKB5JTM5IyPZHqAb0JWA2o8oozwQYqg4zy1CpJNhEMRnk1Bs
 PIFxL+AQRt+x21WzERhpajM561Euiaz4ZpAleryAlwApndbVwvrHQjncP4pE+9ZxnzRNXj16/
 2K/hlA/7crJfW/5VBDJamfiVnlYVMqiwys5pp38BapyZc6JDblYAQENN/VduyOgfJa8lhs/O9
 RZxv49uPUfcZVbl74j+Fr/bzF7chtELVk2q4MlpJPnLjGCtkmlcLT6N64s2907OvWG7pCCbKB
 T2wdtlGAugR6U4enLfpffz4/MMIV4HaQn1ablWmD9isRk38kXpD2q+ZhHb1vxl5Qg2SCTIUtJ
 4tMofK+ZjzMdREkHRdjieE+JeZOFYKF8ulX4fkJjSDe6+vWQU+D5II0da8axHh+cUaEfwVEAe
 DRCEgRSztl2dD7rzjx8hXbTZ5JGGEGV3XbgpGgAyEuvGDiTwHq0bD1XfCnpN7SwJcvbOkK0gr
 bcf18kOh04Yne7MGTyI2Vn54yBlnRHCW0sF
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 12:55:07AM +0300, Rostislav Krasny wrote:
> Hello,
>
> Originally this bug was reported in the Git for Windows project and
> contains two screenshots:
> https://github.com/git-for-windows/git/issues/3321
> Johannes Schindelin (dscho) is convinced that this is not a
> Windows-specific issue. Following is a brief description of this bug
> as I've faced it:
>
> After running the "git submodule set-branch --branch master -- ms1"
> I've noticed that the .gitmodules file is encoded with both DOS and
> UNIX End-of-Line characters simultaneously: all original lines use DOS
> EOL characters but the added "branch =3D master" line uses UNIX EOL.

First of all: Thanks for posting this here.

Then there are some questions, at least from my side.
How did you get there ?
In which shell did you enter the command ?

Could you run
od -c .gitmodules
and post the results here ?

Or is it possible to set up a dummy repo, which does show the problem,
somewhere ?

What we appreciate is a fully reproducable receipt, so that anybody can
reproduce the problem.

I have the slight suspicion that the CR as part of CRLF had sneaked in
somewhere via the command line. But that is already a speculation.

And I don't know, if there is a problem at all, or is it just cosmetics ?

Anyway, a full set of commands would be good to have.


>
> Found on the following environment:
>
> $ git --version --build-options
> git version 2.32.0.windows.2
> cpu: x86_64
> built from commit: 3d45ac813c4adf97fe3733c1f763ab6617d5add5
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
>
> $ cmd.exe /c ver
>
> Microsoft Windows [Version 10.0.19042.1083]
>
> $ cat /etc/install-options.txt
>
> Editor Option: VIM
> Custom Editor Path:
> Default Branch Option:
> Path Option: Cmd
> SSH Option: OpenSSH
> Tortoise Option: false
> CURL Option: OpenSSL
> CRLF Option: CRLFAlways
> Bash Terminal Option: MinTTY
> Git Pull Behavior Option: Merge
> Use Credential Manager: Core
> Performance Tweaks FSCache: Enabled
> Enable Symlinks: Enabled
> Enable Pseudo Console Support: Disabled
> Enable FSMonitor: Disabled
>
> Comments of Johannes Schindelin (dscho) in the GitHub bug report:
>
> > I don't believe that Git considers its config files free game regardin=
g line endings.
> > Therefore, I think that having DOS line endings in there is already a =
violation of Git's
> > assumptions. In any case, this is not a Windows-specific issue, even i=
f DOS line
> > endings are much more prevalent on Windows than on other platforms. Pl=
ease take
> > it to the Git mailing list (send plain-text messages, HTML messages ar=
e dropped
> > silently).
