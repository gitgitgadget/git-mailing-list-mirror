Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E925EC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 18:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjASSTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASSTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 13:19:41 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 10:19:38 PST
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6786EAC
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 10:19:38 -0800 (PST)
Received: from localhost.localdomain ([88.110.98.79])
        by smtp.talktalk.net with SMTP
        id IZUipjyTdLVi2IZUjpC7TU; Thu, 19 Jan 2023 18:18:37 +0000
X-Originating-IP: [88.110.98.79]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:117
 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=7VUszD0-uzAVliQ8AR4A:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        self <philipoakley@iee.email>
Subject: [PATCH v5 3/5] doc: pretty-formats document negative column alignments
Date:   Thu, 19 Jan 2023 18:18:25 +0000
Message-Id: <20230119181827.1319-4-philipoakley@iee.email>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <20230119181827.1319-1-philipoakley@iee.email>
References: <20221112143616.1429-1-philipoakley@iee.email>
 <20230119181827.1319-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKjmWDDidILLRDqZI4JfqPxXhx1+6DJpE85VAVVwD/HbvHJ9KCP5dEd4rs3ON1QiHRtNnO0KWF7JDsrMj8EIKCFRV60EB5PXpVJk71yxiBwbkthTJaQ0
 vGbc5Jgpyg4zXpzDbBzic7zkMun3QwdKEHaHB3W1ysYb/+1BXRsGAIK6bkvSl+/W1uVZnuJnqwIh70TozmxCrNfLooxpBwAOHH0YY7piZJbc3ZFxf7aedb53
 Jpdfl8lR9nlGMvIoM3CThr9JnXA/7CKMPphE1Stg1BgVA8X26m74YEYEiBqTKIXL+dmhuswhYjHErc9UWgdkhw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 066790d7cb0 (pretty.c: support <direction>|(<negative number>) forms,
2016-06-16) added the option for right justified column alignment without
updating the documentation.

Add an explanation of its use of negative column values.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/pretty-formats.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 8cc1072196..cbca60a196 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -158,7 +158,9 @@ The placeholders are:
 				  Note 2: spaces around the N and M (see below)
 				  values are optional.
 '%<|( <M> )':: make the next placeholder take at least until Mth
-	     display column, padding spaces on the right if necessary
+	     display column, padding spaces on the right if necessary.
+	     Use negative M values for column positions measured
+	     from the right hand edge of the terminal window.
 '%>( <N> )', '%>|( <M> )':: similar to '%<( <N> )', '%<|( <M> )' respectively,
 			but padding spaces on the left
 '%>>( <N> )', '%>>|( <M> )':: similar to '%>( <N> )', '%>|( <M> )'
-- 
2.39.1.windows.1

