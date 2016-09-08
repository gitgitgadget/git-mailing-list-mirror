Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A8E1F859
	for <e@80x24.org>; Thu,  8 Sep 2016 04:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbcIHEeJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 00:34:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35247 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbcIHEeH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 00:34:07 -0400
Received: by mail-it0-f68.google.com with SMTP id c198so3407088ith.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 21:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=APMq14ZPM5G8AiWguucR+0iQTFzMYA6ChVC21K/7xA8=;
        b=MYYtFf3Y/faPKE7HywowZT9cTXQnaaCjBHtfxvU/dYuWYtyirHqnzZSvulo2z+tP2N
         NH+v7XjkwO7m4BzPNqjsYw2lrgsO/ZhoTZGvNrWCzYVyhRjIRxEeZPTYqQVEn6cae9ar
         2Y8rZVR+4lfUHSAKAylToEmud8JwAj0yJOt9tQiBvD01W9NpUXZx9H8Ajc8DHUz3IUQ+
         NLMBp8LSG2GSG1lTjxJf0Xl58fPeHMupp7xDxTC4ZlhrgZOa/rWe/BRgXJWKh++UxQqq
         Ahr7XgYT6EACgTTkwKhkWiorbWYlnnJsDaUjuFZ4ftkFQ/hbydw+C0ao7p4DQm0Mzump
         w7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=APMq14ZPM5G8AiWguucR+0iQTFzMYA6ChVC21K/7xA8=;
        b=bVlI3+whPyGUOLtm0APrgGcgrXdELmYO5nwsnmEUUms7EcMFEqyJc18sj1K/u0O4Uy
         a5OgGGD781Ppau+I4wvWWxJyO5lAbVCtF5o7kxgnGZ6zrn6aw5vvveI8pAzqX1uWCXRC
         ntQO9qS8FvRXTi4sjmAHn4agq8+S9g99+eTnbzhgnYHp0KhDdVa+vOYPjQvsENtuYJmR
         alHgNR3eBQjg/r1f2jeZy9b7hscn1Ii4JEMBBShbNswOqykvtQ5Jhp7UyD+pQJCCodq3
         +4BqHZf1oTLJeiljsvvYopQKjJ5Sc6tXzG1MFeqqDxg7q2oVcQgOjTf6DNc52les1o5N
         gdcw==
X-Gm-Message-State: AE9vXwNFOmJpKXBTTc9jfL7ouELVOeCmCwV2OyM4sPLARETYHrECxYnZ/SxfyD/wrmSYYg==
X-Received: by 10.36.6.1 with SMTP id 1mr12324524itv.50.1473309246750;
        Wed, 07 Sep 2016 21:34:06 -0700 (PDT)
Received: from wolverine.localdomain (c-67-182-247-84.hsd1.ut.comcast.net. [67.182.247.84])
        by smtp.gmail.com with ESMTPSA id u75sm5566810ita.16.2016.09.07.21.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 21:34:05 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     karthik.188@gmail.com, gitster@pobox.com, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 2/5] cat-file: put spaces around pipes in usage string
Date:   Wed,  7 Sep 2016 22:34:00 -0600
Message-Id: <20160908043400.5898-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the style a little more consistent with other usage strings,
and will resolve a warning at
https://www.softcatala.org/recursos/quality/git.html

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2dfe626..560f6c2 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -440,7 +440,7 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t [--allow-unknown-type]|-s [--allow-unknown-type]|-e|-p|<type>|--textconv) <object>"),
+	N_("git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-type] | -e | -p | <type> | --textconv) <object>"),
 	N_("git cat-file (--batch | --batch-check) [--follow-symlinks]"),
 	NULL
 };
-- 
2.9.3

