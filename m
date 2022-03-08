Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52292C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348116AbiCHP75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 10:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348889AbiCHP6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 10:58:48 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C291A397
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 07:57:50 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id 28F247E74F;
        Tue,  8 Mar 2022 10:57:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646755039;
        bh=95BIkyMQt6Z4KiVGKY5Jx7I4AEIXX/lRj9IdAUbikY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfKZsp9fM2EcD1vRzHm3syK/0DHo9W4fh3248boQz9rxiGbZjYiQdJAwJHG1FDaGl
         K1l3N7dzxdZz1o3Tq0vUquB9Gvzfwmpvwr6bOUB79E4M8DKtKH0wkfIOpkWI5nz6Ee
         2VGlYOacl83qrC0v//wUYsQ43T/RwGglbCGsN4wgPXTr8ZVHthKNLJ7571tT+7uvas
         +4stWSAmRSXZ1Hr19VCowMiZLMK6cT/BwCSeD61ofjuRlqLJwRh/ymvr2ZIbm2O8nS
         47KAnoyNKLKVmcrjzT1eqiTwQw+UC6v77f+6v4yZm7gCYPOR35fNw+IC8rBmnb3phe
         lS49aMn1oKWQA==
From:   Jason Yundt <jason@jasonyundt.email>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jason Yundt <jason@jasonyundt.email>
Subject: [PATCH v3 1/2] comment: fix typo
Date:   Tue,  8 Mar 2022 10:56:11 -0500
Message-Id: <20220308155612.105957-2-jason@jasonyundt.email>
In-Reply-To: <20220308155612.105957-1-jason@jasonyundt.email>
References: <20220308010711.61817-1-jason@jasonyundt.email>
 <20220308155612.105957-1-jason@jasonyundt.email>
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

