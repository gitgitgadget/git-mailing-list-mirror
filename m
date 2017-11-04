Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B573F202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 12:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbdKDMQ6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 08:16:58 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:50007 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbdKDMQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 08:16:57 -0400
Received: by mail-qt0-f195.google.com with SMTP id k31so6136973qta.6
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeancarlomachado-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1rPp9bvk4IICqYuSToXcaX84i3tUR4iurvj8kbOmhf8=;
        b=Oxcd+lwlg9mHkxBDRQ6XuH23Gdt/soAUbON4nYbaEGB2pxq82RG2z/vJcIZ8gMeLiM
         pyUsMxq/4RuNVEwnkxo7BXfxbnNvuZNF2+CeZdnZPUpt4gcGDjdYzYJ27EBPTKDKuo4B
         XrXIYoG8gjJmR1jKHCM11PzR5os4FksSHjxLofb5xxOl985kfrf+pc5UrgxLlI0JOvWK
         0RKJWKKo3+fpTelZobDX9+JQVwtlWnP0bMiZxc/x38nzACf+zgDhPXYb/bUFb3ldt3iU
         MBAiRf/KcTOTtpOo4RMUDIdCqnJ0ZzDOVC2nI75sjQ0CNmnwn+XhkbTVI1ZUKm52fo8a
         roBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1rPp9bvk4IICqYuSToXcaX84i3tUR4iurvj8kbOmhf8=;
        b=RcorxJN5qjpN3ryDCWVr5ymUV5p6qaTdvT+86C58589SIX8eMwnTepTIkaNWpOkBPR
         4zl/GE6fE/tPdO2pI0CBDlLM/2GExkXkr9oUQ6HECpy99gT6SW61qkvz72YDyaPJnaLP
         ZEoaTGyn0o1ea+b7fokNCiggFp8CwBg+eAk9JO6FCx+BZ9Ao0q3Ce6UlqWgpR3mAugIe
         qUMVyzAjj/JLm5swe4i1EYpmE+TGLHrVVBhBDcxl3q0K90f3xieOIe1D4m/+6ipo3hEV
         DRgRbD8pom8tzwVvVcISuNkXcWU0cKFocNTFdyne+d81WPBB/d5allsRlbZzNpk8vqEN
         +vLQ==
X-Gm-Message-State: AMCzsaU7AIrHmc6EmlFCr4O7O1xVHOHY8YUmUmDIwFaGbdF+SEAhhDiJ
        LLjDW/SRdupThMICPt2MY6g1AQ==
X-Google-Smtp-Source: ABhQp+S2d/auMicrEGMeFL349A8oQF82hQg3DXvP1DWCBb3GO3W8+Pgpukjh/eOOpllPeHq2pqZ5qQ==
X-Received: by 10.200.6.136 with SMTP id f8mr14863125qth.265.1509797816816;
        Sat, 04 Nov 2017 05:16:56 -0700 (PDT)
Received: from localhost.localdomain ([200.18.122.31])
        by smtp.gmail.com with ESMTPSA id d5sm5173817qkf.44.2017.11.04.05.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2017 05:16:56 -0700 (PDT)
From:   Jean Carlo Machado <contato@jeancarlomachado.com.br>
To:     jrnieder@gmail.com
Cc:     contato@jeancarlomachado.com.br, git@vger.kernel.org
Subject: [PATCH] fix typos in 2.15.0 release notes
Date:   Sat,  4 Nov 2017 10:16:16 -0200
Message-Id: <20171104121616.22264-2-contato@jeancarlomachado.com.br>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171104121616.22264-1-contato@jeancarlomachado.com.br>
References: <20171103232831.yrfi6qdq4q4zul4e@aiede.mtv.corp.google.com>
 <20171104121616.22264-1-contato@jeancarlomachado.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean Carlo Machado <contato@jeancarlomachado.com.br>
---
 Documentation/RelNotes/2.15.0.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes/2.15.0.txt b/Documentation/RelNotes/2.15.0.txt
index 248ba70c3..cdd761bcc 100644
--- a/Documentation/RelNotes/2.15.0.txt
+++ b/Documentation/RelNotes/2.15.0.txt
@@ -65,7 +65,7 @@ UI, Workflows & Features
    learned to take the 'unfold' and 'only' modifiers to normalize its
    output, e.g. "git log --format=%(trailers:only,unfold)".
 
- * "gitweb" shows a link to visit the 'raw' contents of blbos in the
+ * "gitweb" shows a link to visit the 'raw' contents of blobs in the
    history overview page.
 
  * "[gc] rerereResolved = 5.days" used to be invalid, as the variable
@@ -109,13 +109,13 @@ Performance, Internal Implementation, Development Support etc.
  * Conversion from uchar[20] to struct object_id continues.
 
  * Start using selected c99 constructs in small, stable and
-   essentialpart of the system to catch people who care about
+   essential part of the system to catch people who care about
    older compilers that do not grok them.
 
  * The filter-process interface learned to allow a process with long
    latency give a "delayed" response.
 
- * Many uses of comparision callback function the hashmap API uses
+ * Many uses of comparison callback function the hashmap API uses
    cast the callback function type when registering it to
    hashmap_init(), which defeats the compile time type checking when
    the callback interface changes (e.g. gaining more parameters).
-- 
2.15.0

