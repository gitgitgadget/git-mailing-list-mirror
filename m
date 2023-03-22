Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57100C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCVQiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCVQiY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:38:24 -0400
X-Greylist: delayed 531 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 09:38:14 PDT
Received: from qs51p00im-qukt01071902.me.com (qs51p00im-qukt01071902.me.com [17.57.155.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190145FA40
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1679502543; bh=pSTpKshU8MqKCmbobieLXH1FPZN7Ucud4wD0NpxXa4I=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=ZSsFxjEV/7+VC9h7ipku3K9YRC3dXk92/Nmo8JmnCTUfV2fRrh7Nz3pB2F8Oh5G5T
         jpH/E6tNKu5vfrt7KBiQ1chf3z/SprZTBLbKP6PpqFNz3BJFU5cAyw9hDhtfa1pWlU
         CwTz908/JXfVy03GbM/5sbP1kBIJjR9h+xwW3I9AQpOAEVEcu//YDlDtP3EnpvXjmw
         uwCaK1VKWjU10lx61FS9kMO2JyX0jWRw7mYLIDBbp9+sxjBXGBRahnR/Xf7IR24r8r
         AzhwAMn9VTwyC6IfRZYVtQVAi/vMooOfzxWc8TeDlFSmr15Oyrxp0LW5tfo7QSIGvF
         UDLTgPUc7sVqQ==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071902.me.com (Postfix) with ESMTPSA id 1A7DB5EC0C23
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 16:29:01 +0000 (UTC)
From:   Sjur Moshagen <sjurnm@mac.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
Message-Id: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
Date:   Wed, 22 Mar 2023 17:28:49 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Proofpoint-ORIG-GUID: fEc5JkxrMEfxEmAorVw5Kon5M-VdvtDv
X-Proofpoint-GUID: fEc5JkxrMEfxEmAorVw5Kon5M-VdvtDv
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1011
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=829 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303220116
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git clone https://github.com/giellalt/lang-sma

What did you expect to happen? (Expected behavior)
Clone to be clean, as reported by git status

What happened instead? (Actual behavior)
git status reported four changed files

What's different between what you expected and what actually happened?
Nothing except those four files

Anything else you want to add:
This only happens on an M2 Macbook Pro. With Apple's git (1.37.1), a =
huge number of files were reported as modified.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.40.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.3.0 Darwin Kernel Version 22.3.0: Mon Jan 30 20:39:46 =
PST 2023; root:xnu-8792.81.3~2/RELEASE_ARM64_T6020 arm64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

