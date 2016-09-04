Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94751FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 11:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbcIDLkM (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 07:40:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36307 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbcIDLkL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 07:40:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id l65so1368974wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kb/ZOMgdcaWnIRjCXfiycOcPMykBjHpzelZcaOl8uDw=;
        b=efQ32wtPKJR2kmKOSUoiPx97wf1pdRyBwrJ/y2sxtlRhira/rX+Ccu37/dwK6GmZLn
         Y+JmYwwsbub/6m39waTyxvKpvjLUgVAZSbh57okQsV6XpaRoUN/PfhTC01lhYBmvQsxq
         agJcmYJVMsSXxpILQFLuIJlZ0AqUiXWoHZDBECbKlQDJ69Drg9txwvMAIr2GwuCCtgo7
         JMiYArFneL51vYPASjnG3JgspbXKYzttdApmOilerHkCXo2MqZFb64OjsQ0sAp1U05jC
         zyOtg+mu5AHBcidczy8X+jwduyYQGS9GaFSwr2cIn5X3k+yBtUmM+25ugxC5ZLLY2ZaF
         QiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kb/ZOMgdcaWnIRjCXfiycOcPMykBjHpzelZcaOl8uDw=;
        b=ZVysCQKe/+iZh7KeStUqKqp8OOy1jhlInVIQgjBx+DG/SH6V/VquJMi3NTH0HWbiDM
         JgRUjD1CO2bkAUDOlLRrVRDCoG8XDc5qUrDomq2SwrDaUwOlQwu1mpWgSLrp/4+hjLfQ
         66U2T+L6hDnEV6G0qYitRNJvxE5z4nisEqqFA4LyCB28FDuCXixlo10uS6kQqhafb3fO
         0M/DKpoxtZy+GjZ/bv/b71pQOugZCkGpwmQW8mFDXULKeok7T/9ZpMrItnBWw9Od4ALs
         AnAOVWh6P0LLN59F+xpIMdv9MSBGgE23jw0P/h3xlF4YG5zZg8TQPlIZl6m4p8JDIZDB
         5C/Q==
X-Gm-Message-State: AE9vXwNVbJTwKyTB5oNA9v+lC6mLNY1oKpgjit9fqirHXFnmhUjKypKWLWJZ66J1NIHqGw==
X-Received: by 10.28.140.5 with SMTP id o5mr11535608wmd.13.1472989209603;
        Sun, 04 Sep 2016 04:40:09 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id b128sm13947604wmb.21.2016.09.04.04.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Sep 2016 04:40:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        git@vger.kernel.org,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/4] add: document the chmod option
Date:   Sun,  4 Sep 2016 12:39:51 +0100
Message-Id: <20160904113954.21697-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160904113954.21697-1-t.gummerer@gmail.com>
References: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com>
 <20160904113954.21697-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git add --chmod option was introduced in 4e55ed3 ("add: add
--chmod=+x / --chmod=-x options", 2016-05-31), but was never
documented.  Document the feature.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-add.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 6a96a66..8caa691 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
-	  [--] [<pathspec>...]
+	  [--chmod=(+|-)x] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -165,6 +165,11 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	be ignored, no matter if they are already present in the work
 	tree or not.
 
+--chmod=(+|-)::
+	Override the executable bit of the added files.  The executable
+	bit is only changed in the index, the files on disk are left
+	unchanged.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
-- 
2.10.0.304.gf2ff484

