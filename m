Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787DC1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 10:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeGYLa6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 07:30:58 -0400
Received: from mail.127011.net ([62.113.201.202]:60746 "EHLO mail.127011.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbeGYLa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 07:30:58 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jul 2018 07:30:57 EDT
Received: from [147.87.242.84] (unknown [147.87.242.84])
        by mail.127011.net (Postfix) with ESMTPA id BA94F3E0458
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 10:12:56 +0000 (UTC)
Reply-To: mail@daniel-baumann.ch
To:     git@vger.kernel.org
From:   Daniel Baumann <mail@daniel-baumann.ch>
Subject: [PATCH] git-rebase--interactive.sh: Remove superfluous tab in rebase
Message-ID: <db70d275-584e-3a3b-5201-dc04e4c5950b@daniel-baumann.ch>
Date:   Wed, 25 Jul 2018 12:12:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4EC7AAD37091AC53476D188D"
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------4EC7AAD37091AC53476D188D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

the attached patch removes a superfluous tab indentation in the
interactive git-rebase messages.

It would be nice to get rid of this to avoid visual disturbance with
whitespace highlighting editors.

Regards,
Daniel

--------------4EC7AAD37091AC53476D188D
Content-Type: text/x-patch;
 name="0001-git-rebase-interactive.sh-Remove-superfluous-tab-in-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-git-rebase-interactive.sh-Remove-superfluous-tab-in-.pa";
 filename*1="tch"

From 353eb1c2c44d5117a3fad1323ca6852b13e4c86a Mon Sep 17 00:00:00 2001
From: Daniel Baumann <mail@daniel-baumann.ch>
Date: Wed, 25 Jul 2018 11:58:40 +0200
Subject: [PATCH] git-rebase--interactive.sh: Remove superfluous tab in rebase
 file

Removing superfluous tab indentation in interactive git-rebase
file to avoid visual disturbance with whitespace highlighting editors.

Signed-off-by: Daniel Baumann <mail@daniel-baumann.ch>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 299ded213..0bf9eefad 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -224,7 +224,7 @@ EOF
 	gettext "
 	However, if you remove everything, the rebase will be aborted.
 
-	" | git stripspace --comment-lines >>"$todo"
+" | git stripspace --comment-lines >>"$todo"
 
 	if test -z "$keep_empty"
 	then
-- 
2.18.0


--------------4EC7AAD37091AC53476D188D--
