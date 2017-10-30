Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0331FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbdJ3RTu (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:19:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:59657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932252AbdJ3RTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:19:49 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWQSM-1dg0gf3NTm-00Xb7X; Mon, 30
 Oct 2017 18:19:43 +0100
Date:   Mon, 30 Oct 2017 18:19:42 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mingw: include the full version information in the
 resources
Message-ID: <d6447dddb2a5196c3785ef7b758764d7873e3153.1509383748.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KHhKWFk6BeQ9hAPNdRuxv4st7J54A7CjY7/S1IX1Ghezfadksta
 AK6aTgbjon75DBSTgb8hcngJ2WOrDYtBjdfbOMYf5GBsANYbY7n+mfLby31DnynSFF6gkI0
 /r/r920nxixIzA/X8Q40+8alhdttjnR2lSoeVXB4u+HeKPaxivYmVxLEHYzCiX/XM+9fPjm
 ILP0Cg8EX2jK9A558oBVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aOb2tAQcTqg=:DzWBfq0Ql2W1tirKn1Iyge
 z+K4GLj0UNWfAZBgSJezSOcheefK0RB0sgsRvw4GIZaRaGg8bI09K5u8A2lN5xqZEt0/FyG45
 IyGy+yHbqI/XfzAjY5NNlW12AW0TntEpnASC2VXCif+eXaHinM6RU6zczxc77t6XHs0MW2NwT
 nOugxvby4O3XbCScNDysyaK/TsqtaWTKs94lXuVzRLakcQpqQfEYQpRAPGTY1eF6FW8r4kjP8
 YSSHDEo3LP+CYbZBeHHZdHPrmyEJIDgWOPZjtqD1EjjLxligzssfveijLZM2CA3yDs/K545Lj
 PXaAQyZgeNQllAljov91DJZd0M8l1nGxQeXCfXwFRLDT1HLMmXJqRFRXTW1ZHQy0cNx9u8dUG
 xSHq/vQAKoBfrDbYr+/4gpeRL/y86LTvKZ9X9a/M04USxKj/UNmnLMc1PFFMQCclOzHRNSHS5
 8WtXQqccrGJFgnnMFIdSfsxhCfsjOkeQA7AkM6KHkhQMdOFyGSEEcfG5Wl99Z36poW2NVzDuJ
 01w4yp2CNZcgUeWYHsrYV2Qn2q3pMBh0kWA/Zg6ghocZ4fB/egsnYccpJ7XmYdhPZSwEslqeU
 tX2JnOvuXPZc4d6MpL2rsmKXmlagHBbzJfYqROCmh1on5eAPLwSeUH0qkLBS/XrTPderYY7u1
 DHE9SOhtjdB63YAuStcJTBUIEldv9R8YrLR+U1IH/GBJzUGaVP3PmY8QVIQfWzYSWVDl/svbZ
 ZWZ6ch2kLyQKz4OQlXDMT0s9KqhKK9Pwc0gcAaXUrQhP0+9e6fObuto0AQouJV0z/AsgTOtpr
 f1B5CNh1seifxOcXAVXYK6fYRZ4PlULc+YPXmpNtkefgw8hn+9zZdsTVlsbrmCNNNlO+mTI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes https://github.com/git-for-windows/git/issues/723

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This patch has been carried in Git for Windows in this form since
	Git for Windows v2.11.0(2). It seems to be ready for prime time.

	I could just imagine *one* change: to use

		tr -d 0-9 ' '

	instead of

		tr '.a-zA-Z-' ' '

	However, I am reluctant to do that, as any character that is not
	caught by this pattern would be indicative of something really
	funny going on.

	Plus, I have had really bad experience with changing a well-tested
	patch series just to get it into core Git, only to see an
	immediate breakage introduced to appease reviews. Therefore, this
	time around I will need to be convinced quite a bit more if I am to
	risk breakages.

 Makefile | 3 ++-
 git.rc   | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index cd75985991f..ee9d5eb11ee 100644
--- a/Makefile
+++ b/Makefile
@@ -1940,7 +1940,8 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 
 git.res: git.rc GIT-VERSION-FILE
 	$(QUIET_RC)$(RC) \
-	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
+	  $(join -DMAJOR= -DMINOR= -DMICRO= -DPATCHLEVEL=, $(wordlist 1, 4, \
+	    $(shell echo $(GIT_VERSION) 0 0 0 0 | tr '.a-zA-Z-' ' '))) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" -i $< -o $@
 
 # This makes sure we depend on the NO_PERL setting itself.
diff --git a/git.rc b/git.rc
index 33aafb786cf..49002e0d541 100644
--- a/git.rc
+++ b/git.rc
@@ -1,6 +1,6 @@
 1 VERSIONINFO
-FILEVERSION     MAJOR,MINOR,0,0
-PRODUCTVERSION  MAJOR,MINOR,0,0
+FILEVERSION     MAJOR,MINOR,MICRO,PATCHLEVEL
+PRODUCTVERSION  MAJOR,MINOR,MICRO,PATCHLEVEL
 BEGIN
   BLOCK "StringFileInfo"
   BEGIN

base-commit: cb5918aa0d50f50e83787f65c2ddc3dcb10159fe
-- 
2.15.0.windows.1

Published-As: https://github.com/dscho/git/releases/tag/resource-version-v1
Fetch-It-Via: git fetch https://github.com/dscho/git resource-version-v1
