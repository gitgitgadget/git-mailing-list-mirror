Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EBFC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA75C206F1
	for <git@archiver.kernel.org>; Tue, 26 May 2020 18:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgEZSh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 14:37:59 -0400
Received: from outbound.soverin.net ([116.202.65.218]:50679 "EHLO
        outbound.soverin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgEZSh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 14:37:58 -0400
Received: from smtp.soverin.net (unknown [10.10.3.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 1DAF660060
        for <git@vger.kernel.org>; Tue, 26 May 2020 18:37:57 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [159.69.232.142]) by soverin.net
From:   Toon Claes <toon@iotcl.com>
To:     git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 1/1] Documentation: correct hash environment variable
Date:   Tue, 26 May 2020 20:37:20 +0200
Message-Id: <20200526183720.120314-2-toon@iotcl.com>
In-Reply-To: <20200526183720.120314-1-toon@iotcl.com>
References: <20200526183720.120314-1-toon@iotcl.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.3 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To set the default hash algorithm you can set the `GIT_DEFAULT_HASH`
environment variable. In the documentation this variable is named
`GIT_DEFAULT_HASH_ALGORITHM`, which is incorrect.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9d6769e95a..12890841c4 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -493,7 +493,7 @@ double-quotes and respecting backslash escapes. E.g., the value
 	details. This variable has lower precedence than other path
 	variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
 
-`GIT_DEFAULT_HASH_ALGORITHM`::
+`GIT_DEFAULT_HASH`::
 	If this variable is set, the default hash algorithm for new
 	repositories will be set to this value. This value is currently
 	ignored when cloning; the setting of the remote repository
-- 
2.27.0.rc1.73.g31835d1b01

