Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C5C6FA83
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 10:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIKKYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 06:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIKKYL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 06:24:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD823A16E
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 03:24:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 65so5955178pfx.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 03:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I6fRadOjbFA3fsrtN7bzrn3R6tp4oxniJzdAYsLo0dQ=;
        b=0ScT+o00LzScb+ZWthnRAY739Y6tfLKk0Q5GnIwi/z0f0+BNeKVnzC4bh7I8jtZ+rF
         HBKv8Uxf90liPlSLGKXUqY6UATkTvMm/4tWYRqUNPMCaTSpDIoI4jtnckJ/mQ/IGMqtR
         lUu9odYBTW6f2i2dHmQzdCmJ7GMDF9nmwHEVQViconC+UW86S9V6A/BGciq4Swmg9AaF
         G6C8RTTUkAKsvsKUAaSEQDVqMV+oetAvMuPB78GgBMuSOzAHKw8octyCffRsI7bL16Iz
         TtjPDd7iTjFdJvbdhLUA1LSGwDYJm7Ct71G9LI0OczRHHsfZrrHCJJUHUYPaIQSI8Aiw
         0VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I6fRadOjbFA3fsrtN7bzrn3R6tp4oxniJzdAYsLo0dQ=;
        b=6IKQf34wgkiAxLeXXrdxz2Fwp2JNUcrxqXaMTZH691wLDpifLtYp51pvrA+xm5oKrg
         ld5Hjm4YgpPk09ymZN8yfKQkXO/i3w4JSOkE+dlWX1f1LkE5t9hyBQu0TD+HjXVsbMQM
         gMvAlUN9w/jjHC7RW3Y6VA6fzcoR2zE5ZcmtQPScgOabhznHG2XDvz8OVkcBMp6y1EZg
         6vNqqVdgD+DikFeqm3WJPuBMi2277Wk8BdH0bAeed8cV4hqMPdkfqnTyuzTkGpz/Jcdk
         EM8q53BdDN0ixhQ5eLREQ2Bi4OtvWe4E5lJV1ESUjh1K9m+chjhvqxXOmK9YgDR5vSvy
         vrGw==
X-Gm-Message-State: ACgBeo1lqadyiA3qO20UnS40f3no7LvhBLicRlm73hxHwmbXRtAGFcz+
        6ASEyhNWggKiOcUy5CG0dz9/5VMM2GwwLQ==
X-Google-Smtp-Source: AA6agR7Du48wvE9k8xHL39KcwISmp0CKthn6qAMkg94o91NuwaRicg+Ca50MwoHhgHNasqq7GJrugw==
X-Received: by 2002:a63:d511:0:b0:438:91d5:5a43 with SMTP id c17-20020a63d511000000b0043891d55a43mr8368766pgg.587.1662891849754;
        Sun, 11 Sep 2022 03:24:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:8801:9c0a:f300:b5d1:79e9:801c:571f])
        by smtp.gmail.com with ESMTPSA id z14-20020aa79e4e000000b00537eb0084f9sm3079874pfq.83.2022.09.11.03.24.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Sep 2022 03:24:09 -0700 (PDT)
From:   Jacob Stopak <jacob@initialcommit.io>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH 1/1] Documentation: fix various repeat word typos
Date:   Sun, 11 Sep 2022 03:23:20 -0700
Message-Id: <20220911102320.39954-2-jacob@initialcommit.io>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220911102320.39954-1-jacob@initialcommit.io>
References: <20220911102320.39954-1-jacob@initialcommit.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inspired by 24966cd982 ("doc: fix repeated words", 08-09-2019),
I ran "egrep -R "\<([a-zA-Z]+)\> \<\1\>" ./Documentation/*" to
find current cases of repeated words such as "the the" that were
quite clearly typos.

There were many false positives reported, such as "really really"
or valid uses of "that that" which I left alone.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 Documentation/CodingGuidelines                         | 2 +-
 Documentation/config/transfer.txt                      | 2 +-
 Documentation/git-bundle.txt                           | 2 +-
 Documentation/git-update-index.txt                     | 2 +-
 Documentation/git-upload-pack.txt                      | 2 +-
 Documentation/howto/keep-canonical-history-correct.txt | 2 +-
 Documentation/technical/remembering-renames.txt        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4c756be517..9fca21cc5f 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -606,7 +606,7 @@ Writing Documentation:
     avoidance of gendered pronouns.
 
   - When it becomes awkward to stick to this style, prefer "you" when
-    addressing the the hypothetical user, and possibly "we" when
+    addressing the hypothetical user, and possibly "we" when
     discussing how the program might react to the user.  E.g.
 
       You can use this option instead of --xyz, but we might remove
diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index 7ed917f5fc..264812cca4 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -13,7 +13,7 @@ Note that this is currently limited to detecting credentials in
 You might want to enable this to prevent inadvertent credentials
 exposure, e.g. because:
 +
-* The OS or system where you're running git may not provide way way or
+* The OS or system where you're running git may not provide a way or
   otherwise allow you to configure the permissions of the
   configuration file where the username and/or password are stored.
 * Even if it does, having such data stored "at rest" might expose you
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 6da6172243..18a022b4b4 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -42,7 +42,7 @@ BUNDLE FORMAT
 Bundles are `.pack` files (see linkgit:git-pack-objects[1]) with a
 header indicating what references are contained within the bundle.
 
-Like the the packed archive format itself bundles can either be
+Like the packed archive format itself bundles can either be
 self-contained, or be created using exclusions.
 See the "OBJECT PREREQUISITES" section below.
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 5ea2f2c60e..f4bb9c5daf 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -420,7 +420,7 @@ as `switch`, `pull`, `merge`) will avoid writing these files.
 However, these commands will sometimes write these files anyway in
 important cases such as conflicts during a merge or rebase.  Git
 commands will also avoid treating the lack of such files as an
-intentional deletion; for example `git add -u` will not not stage a
+intentional deletion; for example `git add -u` will not stage a
 deletion for these files and `git commit -a` will not make a commit
 deleting them either.
 
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 3f89d64077..b656b47567 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -40,7 +40,7 @@ OPTIONS
 	Used by linkgit:git-http-backend[1] to serve up
 	`$GIT_URL/info/refs?service=git-upload-pack` requests. See
 	"Smart Clients" in linkgit:gitprotocol-http[5] and "HTTP
-	Transport" in in the linkgit:gitprotocol-v2[5]
+	Transport" in the linkgit:gitprotocol-v2[5]
 	documentation. Also understood by
 	linkgit:git-receive-pack[1].
 
diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
index 35d48ef714..08f02847da 100644
--- a/Documentation/howto/keep-canonical-history-correct.txt
+++ b/Documentation/howto/keep-canonical-history-correct.txt
@@ -13,7 +13,7 @@ that appears to be "backwards" from what other project developers
 expect. This howto presents a suggested integration workflow for
 maintaining a central repository.
 
-Suppose that that central repository has this history:
+Suppose that the central repository has this history:
 
 ------------
     ---o---o---A
diff --git a/Documentation/technical/remembering-renames.txt b/Documentation/technical/remembering-renames.txt
index 2fd5cc88e0..af091a7556 100644
--- a/Documentation/technical/remembering-renames.txt
+++ b/Documentation/technical/remembering-renames.txt
@@ -20,7 +20,7 @@ Outline:
   3. Why any rename on MERGE_SIDE1 in any given pick is _almost_ always also
      a rename on MERGE_SIDE1 for the next pick
 
-  4. A detailed description of the the counter-examples to #3.
+  4. A detailed description of the counter-examples to #3.
 
   5. Why the special cases in #4 are still fully reasonable to use to pair
      up files for three-way content merging in the merge machinery, and why
-- 
2.32.0 (Apple Git-132)

