Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D502FC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D55D239A1
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbhANIwM convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 14 Jan 2021 03:52:12 -0500
Received: from remote.fiveco.ch ([46.14.118.250]:36948 "EHLO remote.fiveco.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbhANIwM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 03:52:12 -0500
X-Greylist: delayed 942 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 03:52:11 EST
Received: from FIVECO-MX01.fiveco.local (192.168.16.44) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 09:35:47 +0100
Received: from FIVECO-MX01.fiveco.local ([fe80::c512:b974:5da:2168]) by
 FIVECO-MX01.fiveco.local ([fe80::c512:b974:5da:2168%4]) with mapi id
 15.01.2106.006; Thu, 14 Jan 2021 09:35:47 +0100
From:   Kevin Bernard <kevin.bernard@fiveco.ch>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug: checkout --recurse-submodules discard uncommited changes in
 submodule
Thread-Topic: bug: checkout --recurse-submodules discard uncommited changes in
 submodule
Thread-Index: AdbqUBNPEWEQfD/6RDy17JZxGXkKfg==
Date:   Thu, 14 Jan 2021 08:35:47 +0000
Message-ID: <570e77a07f0b4d4ea09307e5fa819d6f@fiveco.ch>
Accept-Language: fr-CH, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.16.29]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Make a git repository with a submodule in it.
Make two different commits in the main repository with two different versions of
the submodule, one of them is the head of the branch.
Checkout the head of the branch in the main repository, and make a submodule update.
Make a modification, do not commit it, in a submodule file that will not result
in a "error: Your local changes to the following files would be overwritten by
checkout" when the other version of the library will be checked out.
Go back to the main repository and make a checkout of the other commit with the
switch --recurse-submodules.

What did you expect to happen? (Expected behavior)
The checkout with the switch --recurse-submodules should fail when there are
uncommitted changes in the submodule.

What happened instead? (Actual behavior)
Uncommitted changes in the submodule are discarded without any notifications.

What's different between what you expected and what actually happened?
Loss of the uncommitted changes in the submodule.

Anything else you want to add:
I stay at your disposal if you need more information.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.0.windows.1
cpu: x86_64
built from commit: 18da6dbba950f8cc7b7d07057f7c30bf7cf207b6
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 19041 
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]

Sincerely yours,

Kevin Bernard

