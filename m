Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A371F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 22:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfJDWI3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 18:08:29 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44925 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDWI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 18:08:29 -0400
Received: by mail-pl1-f201.google.com with SMTP id h11so4760505plt.11
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+/hxFnO/MBvVuyHypi0CpuNBzRsAkLIiQEcAHtiLtsw=;
        b=WUJpidIB+yT9VydW/RQN/YMn7r/bVHb6BYVUJdy8S3p2VqQ1Ygcv2J6Ru9PWPWy0re
         LXBHyysm48LmrVvese5JniDHo1iwFSPx5OAW1LIQ8vXozvRpOXTaQS7/8lkozlKqOvLb
         88ilDfsG+FpMo0g7GON1l/2PXn0VdxFd6zZ3UppyGPdZ1Epf9jAxaBrQtHTi8UzeRdMv
         ee/G45rb5T3Cam5wu2zoSaLMjgDIKWSPRYCdl/7D/EwiFEq4OTG5uFy/4bbLL7c/RGDR
         1OoAi5QBpdbdwgEKJbkNyGgUR8Q5yEMkWU0TjYdyHx8SP6mW39ZnokZhFIahRhTNWXRD
         bkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+/hxFnO/MBvVuyHypi0CpuNBzRsAkLIiQEcAHtiLtsw=;
        b=QlhxxgEqQRFWLzCdS939KHGkxvFvbYzXIIoXgUpZ4rbiYQF0a1HnZojFdUFoHOEnbA
         4b7FflpY6dJ4mpdzjSz79n57v3U6cnr+KkoCcKcvfaVVFeYZ+9VcjdKuGdeUIh/ejuNK
         DCDvzozy5byGuk+4K+eAEr3u3TBxAOswU4l2Eihpx7bvCs0e/29ZlOwhp4QFJWjobF00
         xzJRuPOy2Fm5Xp3hMJ3t0U7TfOY0A6IRpgT1DQIj4d8Rx/h4hB7Ej7MidD6kuJepLCQ8
         VNlD5WicGYeMFTVkxrLku9zc8i7HBcnlJO0da8GopnowtDlfgsr9hgWr8EnCFQqKWA0+
         h4gQ==
X-Gm-Message-State: APjAAAU5iRQcuXXK2mnoEOcZ2XT/wRDEBarHbVHLYfKGcnQPar1hQBHV
        LT4ZDNn/73h2nUJzqBUZZfw4DyQ4m0bbqVSmOb0MiSgtXMfIbjYvA7jhYaqPbNT6yoTPpR9ezvR
        a6RBudNuh554WUekqiXY4h1UBIekaIEGIYDSC7CE4m72DboY+xOLjlmIl5/ZglTk=
X-Google-Smtp-Source: APXvYqzfnoEDgHf3r4F+s+CHtL5QLp2p7y4BKiEu0hZh3yApKpdcH4Q80dbq0E+UL4N4HRd98xOZyTCtfg0zEg==
X-Received: by 2002:a63:d30f:: with SMTP id b15mr17471708pgg.341.1570226906816;
 Fri, 04 Oct 2019 15:08:26 -0700 (PDT)
Date:   Fri,  4 Oct 2019 15:08:18 -0700
In-Reply-To: <cover.1570225500.git.steadmon@google.com>
Message-Id: <eacffe250d2029f190d04144c9242ae25b8fb094.1570225500.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1570225500.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v5 1/4] docs: mention trace2 target-dir mode in git-config
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the description of trace2's target-directory behavior into the
shared trace2-target-values file so that it is included in both the
git-config and api-trace2 docs. Leave the SID discussion only in
api-trace2 since it's a technical detail.

Change-Id: I3d052c5904684e981f295d64aa2c5d62cfaa4500
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 7 +++----
 Documentation/trace2-target-values.txt | 4 +++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 71eb081fed..80ffceada0 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -142,10 +142,9 @@ system or global config value to one of the following:
 
 include::../trace2-target-values.txt[]
 
-If the target already exists and is a directory, the traces will be
-written to files (one per process) underneath the given directory. They
-will be named according to the last component of the SID (optionally
-followed by a counter to avoid filename collisions).
+When trace files are written to a target directory, they will be named according
+to the last component of the SID (optionally followed by a counter to avoid
+filename collisions).
 
 == Trace2 API
 
diff --git a/Documentation/trace2-target-values.txt b/Documentation/trace2-target-values.txt
index 27d3c64e66..3985b6d3c2 100644
--- a/Documentation/trace2-target-values.txt
+++ b/Documentation/trace2-target-values.txt
@@ -2,7 +2,9 @@
 * `0` or `false` - Disables the target.
 * `1` or `true` - Writes to `STDERR`.
 * `[2-9]` - Writes to the already opened file descriptor.
-* `<absolute-pathname>` - Writes to the file in append mode.
+* `<absolute-pathname>` - Writes to the file in append mode. If the target
+already exists and is a directory, the traces will be written to files (one
+per process) underneath the given directory.
 * `af_unix:[<socket_type>:]<absolute-pathname>` - Write to a
 Unix DomainSocket (on platforms that support them).  Socket
 type can be either `stream` or `dgram`; if omitted Git will
-- 
2.23.0.581.g78d2f28ef7-goog

