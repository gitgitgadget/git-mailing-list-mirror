Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE3C433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D6D64E40
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 13:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhBVNSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 08:18:54 -0500
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:59988 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhBVNRE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 08:17:04 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06661037|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00991067-0.000713321-0.989376;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Jbm5e61_1613999780;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Jbm5e61_1613999780)
          by smtp.aliyun-inc.com(10.147.42.198);
          Mon, 22 Feb 2021 21:16:20 +0800
Date:   Mon, 22 Feb 2021 21:16:21 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     git@vger.kernel.org
Subject: git format-patch lost the last part when branch merge
Message-Id: <20210222211621.0C5D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git format-patch lost the last part when branch merge

Here is an example.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
Merge tag 'for-5.12/block-2021-02-17' of git://git.kernel.dk/linux-block

1, from the web interface,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/btrfs?id=582cd91f69de8e44857cb610ebca661dac8656b7

the last part 'diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c' can be confirmed.

2, but from ' commit | 582cd91f69de8e44857cb610ebca661dac8656b7 (patch)' of this web page,
the last part 'diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c' is not in the patch file.

3, git format-patch 4f016a316f22.. fs/btrfs/ will not output 'diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c' too.

Best Regards


[System Info]
git version:
git version 2.30.1 and 2.27.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.17-3.el7.x86_64 #1 SMP Mon Feb 22 10:43:13 CST 2021 x86_64
compiler info: gnuc: 4.8
libc info: glibc: 2.17
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
None


Best Regards
王玉贵
2021/02/22

--------------------------------------
北京京垓科技有限公司
王玉贵	wangyugui@e16-tech.com
电话：+86-136-71123776

