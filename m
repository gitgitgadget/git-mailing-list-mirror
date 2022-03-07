Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627BEC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 03:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiCGDqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Mar 2022 22:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiCGDqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Mar 2022 22:46:22 -0500
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Mar 2022 19:45:28 PST
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293E5D5C9
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 19:45:27 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id 23C46812FE;
        Sun,  6 Mar 2022 22:37:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646624262;
        bh=95BIkyMQt6Z4KiVGKY5Jx7I4AEIXX/lRj9IdAUbikY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CseI/e7pg+vQa+5U0o6nE5PJQeQMDtOXMDwLPHutXDR2rSK4li1OjKpZ9AKs4ZIrd
         9q/GC+giM9t2z5Zm9Cl/F0B+Gnwm9uRstXxY5Og8QIAuqVurvn38K4JybMa9JYFh2P
         jgEleoz5yaRE3epGGWQ2Zt7lKppYML/P6jcPHcD1lMWB5JHGT0KXou5L3o5EnpHt+1
         Wh/iE8OGuIho6qtimRIUkaoGTjXJmGeqC1W3TZa/WZu0qutvJ04ibUO34n/5OGvxLG
         XSrNcBrqURkPUHY7wtXC/5hSHjL56w2/fYpL5qVbheI/os++uo+XKnfoQkpTnPBc77
         QNQdKhIn7e6sg==
From:   Jason Yundt <jason@jasonyundt.email>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jason Yundt <jason@jasonyundt.email>
Subject: [PATCH 1/2] comment: fix typo
Date:   Sun,  6 Mar 2022 22:37:22 -0500
Message-Id: <20220307033723.175553-2-jason@jasonyundt.email>
In-Reply-To: <20220307033723.175553-1-jason@jasonyundt.email>
References: <20220307033723.175553-1-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jason Yundt <jason@jasonyundt.email>
---
 t/t9502-gitweb-standalone-parse-output.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 3167473b30..e7363511dd 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -34,7 +34,7 @@ EOF
 #
 # This will check that gitweb HTTP header contains proposed filename
 # as <basename> with '.tar' suffix added, and that generated tarfile
-# (gitweb message body) has <prefix> as prefix for al files in tarfile
+# (gitweb message body) has <prefix> as prefix for all files in tarfile
 #
 # <prefix> default to <basename>
 check_snapshot () {
-- 
2.35.1

