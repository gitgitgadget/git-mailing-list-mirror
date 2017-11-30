Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9EE20A40
	for <e@80x24.org>; Thu, 30 Nov 2017 01:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbdK3BuI (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 20:50:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:64221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752711AbdK3BuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 20:50:07 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9aX9-1eOsID0YuN-00CwW6; Thu, 30
 Nov 2017 02:50:06 +0100
Date:   Thu, 30 Nov 2017 02:50:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.15.1(2), was Re:Git for Windows
 2.15.1
In-Reply-To: <20171129135723.11664-1-johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.21.1.1711300245250.6482@virtualbox>
References: <20171129135723.11664-1-johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ffNGmUm0Fw4famcvIs8puSRcqi5FewELJCeqJHCzOgqVSLLlwAW
 Id1H3h+kRRDQ3qa+jtOMq+ODBppk7AhPtuklWJjp9qa4P3ZbtS9qsSCjLVmm3zOsrrOQ1dO
 KBKZJt6bcKLLw1ECPFOLBRbMLLjYUithwNRkvQxApKFRpaPjHijnzi6DoyDyPbQyvqggAz/
 PKXigA2VpcjGoNCm0pkng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1iAXnSC6MhY=:0TRzg1bSkDcmel+ARWrQDx
 o9oODX+PbRUpl6uy1P2EJ+YukChI4cSFTCNE+ODrgqvy/+IldsL0j+7aoemDUEJjtkaM/22lE
 i0rY2Utp2nmKOgFWjIqpQzIM0lwhOWR8/eevStxlbHM14jtY01v13tOVQh4Olk8WWkJ32JwJt
 9tbCmFpdu+u+7jS5fuzSjy8Xobown8vXvB1YCfR6IIWHRi77H6ulRwnHOhAR1bN1eN4HW4qqZ
 FWK3utatZG58U+B3GCehPpc0273VElvBltw9iRE9JB1PphU0az5jGNBZ4N7e3zXXjOqQ0rygI
 YlL340J1BdXPpPd/d5RwdWOMqgbqr3kqmebqCfUtkrGkIuUJ8LlsRfFBpPVUTZluuM/TrXWoT
 7J5LhdPDUDrURDOcjeRe9IxaSbPUHoTHgS8zLLFs+NUYuFQ6aDUUdEgywmqm2uxKDZSRXwyFw
 KBuI6uSCKk4AyRe23yY7nMAB0Te0boFk2bkCsUBjQl+33f9SOXfBOH3la3VCA40KeqXiFzHnf
 xOnydgYFXsXk2WJBNN/y4yGoHIbJXGg3q9mbPmt+H7PfE9rzfCjUDIBisMEH0RxK83QGyZvUh
 OH/r10GPxGXZ5pK/CngRC94Ot5KsdQ9DZm0MQRFMe8YWYP2OyP6kh/ayGyVKqZq6vd2sRUMwL
 oO1e9ND0e0pNsj1Vm/h4t2ZmQe9kakU4rr1RMndQlKZUcRiCCFTnQzr0wlsQj1CDgWg8nsySu
 Eup9M+PVoiHOUCIpXo490ytgFxRb3x17nj/hSK85nSo6AvwNunSVJ8j0Dg8/hSobqqlv2h1AK
 H56Ub4BfXrhiJmMT5Ugh58sCcZ19Qzz7GfQPJMtuA0TmYnvF+U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

unfortunately, a last-minute bug slipped in: MSYS2 updated vim (including
its defaults.vim, in a way that interacted badly with Git for Windows'
configuration). The result was that an ugly warning is shown every time a
user opens vim (which is still the default editor of Git for Windows, for
historical reasons).

Git for Windows v2.15.1(2) fixes just this one bug, and can be downloaded
here:

	https://github.com/git-for-windows/git/releases/tag/v2.15.1.windows.2

Ciao,
Johannes

P.S.: Oh, yes, you're right, I forgot the SHA-256s:

Git-2.15.1.2-64-bit.exe
5eaffe3f364c89d2811f572678b3d4bbd092b887f2dda1f2d12b7b81eea4e6a7
Git-2.15.1.2-32-bit.exe
d227c0694fe1eef9a7299570167549aaf454bf28a5ac6d34ad3d288d9185f7e2
PortableGit-2.15.1.2-64-bit.7z.exe
36847f62418a5c62a7f50650f3662283f8d324602f4a611d592095ee296cd912
PortableGit-2.15.1.2-32-bit.7z.exe
8b1973bde82718684945c7373266976c70be55022ac554847a8a201c941952af
MinGit-2.15.1.2-64-bit.zip
59060c93425709d66db1756f884d8f235b012d58f6de0963087afbac46134c57
MinGit-2.15.1.2-32-bit.zip
6d2e782c9fd714feab86a6a6358353da32adb4975eaca8a6532bc51aa0ad4ed9
MinGit-2.15.1.2-busybox-64-bit.zip
2d2f3ac49caf7296dd4299236ca9425dc11954b3486f5a3301bf7b7a63286dbc
MinGit-2.15.1.2-busybox-32-bit.zip
2b25fcc2b27e8f1e75eae79912c59a35b066397195597600fd48e32140df0f24
Git-2.15.1.2-64-bit.tar.bz2
174f1a37f313a4ac6cb617693d10d28304d6b952121b41a934e5c484eb68444c
Git-2.15.1.2-32-bit.tar.bz2
709c15a33c0c25f4b293438eef5cf8c501e84032be36a5f4de8815df1e927eaf

On Wed, 29 Nov 2017, Johannes Schindelin wrote:

> Dear Git users,
> 
> It is my pleasure to announce that Git for Windows 2.15.1 is available from:
> 
> 	https://git-for-windows.github.io/
> 
> Changes since Git for Windows v2.15.0 (October 30th 2017)
> 
> New Features
> 
>   * Comes with Git v2.15.1.
>   * Operations in massively-sparse worktrees are now much faster if
>     core.fscache = true.
>   * It is now possible to configure nano or Notepad++ as Git's default
>     editor instead of vim.
>   * Comes with OpenSSL v1.0.2m.
>   * Git for Windows' updater now uses non-intrusive toast notifications
>     on Windows 8, 8.1 and 10.
>   * Running git fetch in a repository with lots of refs is now
>     considerably faster.
>   * Comes with cURL v7.57.0.
> 
> Bug Fixes
> 
>   * The experimental --show-ignored-directory option of git status
>     which was removed in Git for Windows v2.15.0 without warning has
>     been reintroduced as a deprecated option.
>   * The git update command (to auto-update Git for Windows) will now
>     work also work behind proxies.
> 
> Filename | SHA-256
> -------- | -------
> Git-2.15.1-64-bit.exe | a2ba53197db79b361502836eecf97f09881703148774f9b4e9e6749d41d4ff71
> Git-2.15.1-32-bit.exe | 73154bdfd1ad4ced8612d97b95603ff2b2383db9d46b4c308827fb5233d52592
> PortableGit-2.15.1-64-bit.7z.exe | 94d485454af33a32d08680950aaf38f0825a189ef8b617054b81b2c48d817699
> PortableGit-2.15.1-32-bit.7z.exe | 7d804748a7de735133d78c5420d9b338379123734509415035593e106b03515a
> MinGit-2.15.1-64-bit.zip | 5e38d13241b0742e6673bc5116ac82e851dd1fad01c660c943017f4549b6afea
> MinGit-2.15.1-32-bit.zip | 2fc85f67cabe3c13aceb6868b4bb6bda28ddfecd6f32d7e0da9ddce8cee9b940
> MinGit-2.15.1-busybox-64-bit.zip | 02611486e3c8c427f09d2c4639484cd604ea812471248ae928960f1e0dc59633
> MinGit-2.15.1-busybox-32-bit.zip | a6dfb770f5cfa7b120ba49922d3434577b8601c5d322ad473dd2e2adc91e92b3
> Git-2.15.1-64-bit.tar.bz2 | bb630e5f3d7b650db67134b0187cf0cb8f5ed75990838ee65fed85e21777f08a
> Git-2.15.1-32-bit.tar.bz2 | ec3938e161ac1bbcf2b4f5d41fae1c05ea229fa0276b4db8530ec50b69131832
> 
> Ciao,
> Johannes
> 
