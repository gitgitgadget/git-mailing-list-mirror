Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF6CC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 02:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiDOCtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 22:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiDOCtR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 22:49:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE7A76D6
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649990807;
        bh=lDT1rU7m1JqKChfgq9VBVjdbgRn5u4TXRAa20Rzq8mA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=g2LDW/9qVKbJqMaBehSUd7vMgl/w0slEnNPusGehCsOyI8mtRodUjfaGzITLE1vAK
         FVwAs+Ty36VP1CsX71HMR6IiVJV1fVyEBgklCG6MUi3ZfnhZgDsNrr3niMdLdsir+K
         SGusmOrLX56v7rKx5GYx6iulHmdzpwjG+qYthPV4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az92-249.nbrkuvepa5puroylvvx1wzp50h.ex.internal.cloudapp.net
 ([20.25.255.126]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MMGN2-1nPAlV0G4E-00JNEJ; Fri, 15 Apr 2022 04:46:47 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.35.3
Date:   Fri, 15 Apr 2022 02:46:44 +0000
Message-Id: <20220415024644.4908-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:hXizgkxy0d6MHmoaO1SR4+2sqRnnpeHU0Ik9Y+r0a0Eu+hqKghV
 kaEIE3AYfld2BuX/s3xREl84O0XCDV1VoJPUjdcodipgzRSheFcQsZt6rJK5zF5x7BaT49C
 eclvM4DJk9Dsj5IwnbmhWO3KSu+r+MYhSyodpRE0nfVwM6EjkVWr8BQK0axkvIKjeGGgaj7
 X4lKGoLIxfLkNmIyO/7HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4SG2CnqthTc=:qB9BsHK1h5QWIDOaR8CgsG
 3N5F++ACBeDT3k53ZKZReFPtJfi56n8WfVyXE0YIEDMp3xlmbLa65/2KJU9YRduJudm+lrWHK
 4saP6AKbXxbx+Soe0PZkubNTjy7HG+3BCyQrgb9/RXW3j3TIofozxINEh9DpnmTHT3z6Y9p5X
 ReUs3JVKpo/nPOiHjTOcuSraKe/tHDcgJGdJwbH09m7wIVUG1J/pbht3h+xZ+kAUpJH7hlKTv
 BoRpya1ylRdcf/kfXDBkAsP3ZqAkQCUCXBRWE/4JsGFAUFFyniVT/r1A54VhpzNm4/iBsxnnI
 DGtMX2kN+8kOj78mK0JOEFjYds6HTDiWL1DrzeR4CZXp37g+G26doZ2g2ec3NWvy1mLvXITpw
 BZceLG38q1KCUJey9HHXdCwUsJZyGb58eVQGYNzflbhhYLzGWcst+Oj9vfz66+U0qqv4m9eZI
 cCC47xczkFtMsW7eHGifz1dCSOZjy2ASddkC5Zalxdm+Va10CeBjMq8lGRqYU9BzInXr4uz2v
 Ls78oleLlBbWbNJ9D9mAJTvzClRtt0L/IpU/o3U9oA4Pt2t5xk2bDbh8jsuK0PryEwHhBQTyA
 5watl0xK0ZpXfLaMq2kEvRRteqsm4JZYK40CBbDnIbZYSJ9FxGs0uB/foIWJ5fqXr1+7LWhZ9
 jGRWQUrR1l0xXMdzuBuSsacp/7HHXPpU7dbEKVxnhpADV7jY9PZNtZqi1nc+EFxpKBqq/f3/7
 bZhhB3gtecGlJUoHP54BIAWThF61GQZbZ1kh6p/ytawJzzy0zc7/JgN9vTuJJQNDbvrhdiUup
 3kv8tHf9eS6jm8be4/xc6KUi2DfusWnI0BKV/UkBjQrd1f/rCBZX5oMlmuJke6lxnkJaZ0bWu
 CZKWu8dInySmc1MclV0QFQ+MNCbVIcY0GTeJAJFpGeF6Pxzj4PflVtMpsUV3seaF4wmE3EIjR
 9t+1f5fFyctdNHwGVZ4+kXhOBPE7XrWJFEC4lb3Nst7et7+MSxaeTlfMM/x3s/KveeUpRR4qO
 XfrCqdh0uaCC4WXxSD5uHASj0ruOnJitId3xcGuiILYHiRx9dWzHIYrVUupu/cTBQhyxs164d
 NSu+rSZ6cZ3BK8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.35.3 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.35.2 (April 12th 2022)

New Features

  * Comes with Git v2.35.3.

Bug Fixes

  * The advice indicating how to use the %(prefix) with a network share
    path was updated to use the appropriate number of slashes.
  * Various fixes for usage of the safe.directory and %(prefix) when
    using Windows Subsystem for Linux (WSL).

Git-2.35.3-64-bit.exe | 5862bd6f4f4619d3bfeb4f9c2cdfdf62fd45658650debd535c6af10a8695e181
Git-2.35.3-32-bit.exe | d6b2bb64f264b5edf014f356ec4f1532128f43ab0c1ecbf43f0d19912d81d0b8
PortableGit-2.35.3-64-bit.7z.exe | 53091932db9ed386a667a4b11b5760bb8eb2d44d556b67cb94fa2766daa37182
PortableGit-2.35.3-32-bit.7z.exe | be28dea2619f0d71872adf3c3f0859838773b3785b7c36f520005e93e4fc1190
MinGit-2.35.3-64-bit.zip | 9b88c81ad796acf9969825e8736b953cb0e0bfb4717be57fd59336ae94d521e4
MinGit-2.35.3-32-bit.zip | 1ad43122a8a7dc1633beeabcfa14aec5c35c211be8f3594431046ce3e60fc542
MinGit-2.35.3-busybox-64-bit.zip | 2b257cdbae25253034fb3f38e13118d951c85e476c32719b0a0d4f1cd7516d69
MinGit-2.35.3-busybox-32-bit.zip | daf08717875ce64fff84cc0ad755ebe209066a02c238eec47994f7b0a8023b1d
Git-2.35.3-64-bit.tar.bz2 | a81ac00b01de762920500b58a631c51be0574d2df50d7a089ef9195a57358a42
Git-2.35.3-32-bit.tar.bz2 | 69a6880ac0171918bd333421141f79bc14097097e35b1f9aacc483f4300c8e08

Ciao,
Johannes
