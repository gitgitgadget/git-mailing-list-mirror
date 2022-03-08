Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65982C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 01:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiCHBJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 20:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbiCHBJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 20:09:48 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAAB31502
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 17:08:53 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id 410467F288;
        Mon,  7 Mar 2022 20:08:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646701702;
        bh=95BIkyMQt6Z4KiVGKY5Jx7I4AEIXX/lRj9IdAUbikY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzaBO+3u/zXbOn33wQPCTVw+ONHibs8AtDgrRKmVO0wPOug1RJNIIF/ncxHWnp8Wj
         Tj9eki9xWCkuJwka4T2h19l7pAaGyN4uVIZuGAIAVfW2/lvQ8GJoHHc9is410yRvoS
         m3H7r5iWJQSDTQGJEIBxO+r9UxWZIzIG0nwrCDhwBa1jk71wagl1CvQuTCAo5YqmBW
         QxqrnPh+BKY/orcYuFLEyMSEKil/L5+5gfeUkDseuFqwMY3ZULDNzT+x15KR/Tkku0
         RUZOnLxn9ujhbdXH0rx1YRVtlvm5uuzohPP9Pkq5tgNtcV5eJRf8DYBVfI8wpnnp8W
         bqy7/OxTfBo9w==
From:   Jason Yundt <jason@jasonyundt.email>
To:     git@vger.kernel.org
Cc:     Jason Yundt <jason@jasonyundt.email>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] comment: fix typo
Date:   Mon,  7 Mar 2022 20:07:10 -0500
Message-Id: <20220308010711.61817-2-jason@jasonyundt.email>
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

