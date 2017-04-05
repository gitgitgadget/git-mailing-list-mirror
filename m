Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACBDE20966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbdDENFl (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:05:41 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41178 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932904AbdDENE2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 09:04:28 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id D28AD600051C
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=
        jupiterrise.com; bh=bXzIOvT99Dw9jLQkCXIFcqj9NyY=; b=QVtf2QsfXDW3
        PMWs4gvtbpMuTUaEdkGCJY9nB8mjzsW2q61aJQYw6elns1E1fQ2/vANZvYupgijA
        8zLcJGLBDyb514vMefwAm4dwzNZ57OWUp/odri4bREpwoFeiuU0iTCQUoxuhr4Ro
        ITyBK8pfRedjvtQ4plLRM/R7chBOoB8=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 7D80C600050C
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 06:04:27 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id 18B36612DF
        for <git@vger.kernel.org>; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id 1184B76C89; Wed,  5 Apr 2017 15:04:25 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/7] Allow svnrdump_sim.py to be used with Python 2.2
Date:   Wed,  5 Apr 2017 15:04:20 +0200
Message-Id: <20170405130424.13803-4-tgc@jupiterrise.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170405130424.13803-1-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows running the git-svn testsuite with Python 2.2.

Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
---
 contrib/svn-fe/svnrdump_sim.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 11ac6f692..86bf4a742 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -8,9 +8,9 @@ to the highest revision that should be available.
 import sys
 import os
 
-if sys.hexversion < 0x02040000:
+if sys.hexversion < 0x02020000:
     # The limiter is the ValueError() calls. This may be too conservative
-    sys.stderr.write("svnrdump-sim.py: requires Python 2.4 or later.\n")
+    sys.stderr.write("svnrdump-sim.py: requires Python 2.2 or later.\n")
     sys.exit(1)
 
 
-- 
2.12.2

