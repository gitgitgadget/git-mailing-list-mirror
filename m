Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648D9C433E9
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 15:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299A46148E
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 15:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhBVPPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:15:52 -0500
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:33444 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhBVPPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 10:15:05 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09024893|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0135266-0.000451105-0.986022;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.JboZOxT_1614006845;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JboZOxT_1614006845)
          by smtp.aliyun-inc.com(10.147.42.241);
          Mon, 22 Feb 2021 23:14:06 +0800
Date:   Mon, 22 Feb 2021 23:14:07 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     git@vger.kernel.org
Subject: noeol when redirect git log output to a file
Message-Id: <20210222231406.CE72.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

noeol when redirect git log output to a file.

[root@T640 ~]# git log '--pretty=format:%h: %an: %s' -- hw/ >a.txt
[root@T640 ~]# cat a.txt
c2accaa: wangyugui:
757bec2: wangyugui:
cefb5d4: wangyugui:
2fc0dbe: wangyugui:
6cfe6cf: wangyugui:
e8a94b1: wangyugui:
ba54c6a: wangyugui:
7de214e: wangyugui:
8f2588a: wangyugui:
5834825: wangyugui:
cd30711: wangyugui:
8807c7d: wangyugui:
edd4e92: wangyugui:
0c6f3dd: wangyugui:
38964f4: wangyugui:
4fd21e8: wangyugui:
52fa7b0: wangyugui:
93f5ddb: wangyugui:
47c7aa4: wangyugui:
ab23c1f: wangyugui: OK
8002e69: wangyugui:
da8a6d5: wangyugui:
ed2f4e0: wangyugui: baseline[root@T640 ~]#

but without redirect, it seems OK.
[root@T640 ~]# git log '--pretty=format:%h: %an: %s' -- hw/
c2accaa: wangyugui:
757bec2: wangyugui:
cefb5d4: wangyugui:
2fc0dbe: wangyugui:
6cfe6cf: wangyugui:
e8a94b1: wangyugui:
ba54c6a: wangyugui:
7de214e: wangyugui:
8f2588a: wangyugui:
5834825: wangyugui:
cd30711: wangyugui:
8807c7d: wangyugui:
edd4e92: wangyugui:
0c6f3dd: wangyugui:
38964f4: wangyugui:
4fd21e8: wangyugui:
52fa7b0: wangyugui:
93f5ddb: wangyugui:
47c7aa4: wangyugui:
ab23c1f: wangyugui: OK
8002e69: wangyugui:
da8a6d5: wangyugui:
ed2f4e0: wangyugui: baseline
[root@T640 ~]#


[System Info]
git version:
git version 2.30.1
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

