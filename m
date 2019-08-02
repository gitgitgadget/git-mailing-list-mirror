Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C34D1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 22:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfHBWCl (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 18:02:41 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:49865 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbfHBWCl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 18:02:41 -0400
Received: by mail-yw1-f73.google.com with SMTP id b195so56097512ywa.16
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fh+k1iw8l8YXVYTzl+/v7uhVFJ8bjo09JnGCTnYUBWU=;
        b=SJGH5wuj5qaq7ThT+/grAIoeHLoprCwy3pFCNQ+Uvk705H3bXeQrwO3lEdjX33tTk6
         al6YzLtcei0b55cSLRB6dFITOA+ClCRWJS0Fn8tjmNQCF9yry5uFjM69C2zsN/EdsrpW
         eb2ZkHxzilzfEK9D8AP1CGfIj+ue6xfJa71Z/AiHaUif2PAzBsEyiZnIvaLbP4yLHQ0X
         joxFwvhqf2twPWq10dxgZn0vj0D46GGlCpWJYruflfPhlTOW7J6i8+QSOzBbkPMNXF4h
         KeZlFepmBnPb8T+4Ks36zZBa2kGinbyEhqxWS/SWya0yKI6VdiKPtvRaRJIutmezw3JB
         gDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fh+k1iw8l8YXVYTzl+/v7uhVFJ8bjo09JnGCTnYUBWU=;
        b=pc4J498b2S5KfHzgaDsP2wcLmDG9LObO1PpUgVtJTzyQBPh0e0C0O2qJVoNXkaUYrg
         uJFSF+GYiRmj3Ta4nmfP09l4YvgeE9GLsRXHjh5RBvYzdCG7Bz8KPKfvJtpf+VEAUwCH
         lhY02VzFFuaKsJJXYy+tIKIkOEriMQdyr+knOD22Z5zPc4p9foXL1jQZKY450VsPqms/
         Twp5K8aUJvrpmVwY/O67u1fONSziELmPPmu/0Vg7aeA9dQTXvFzKNJ/tqaoGAO40zyGS
         bx3GI4VCiuLMeF8No+I+OeNHSBuNXWcpLnwATuKtXg/gFxkCnnpQstt/fY+PKwg6Ak56
         ww2w==
X-Gm-Message-State: APjAAAU8YfsLx1yGAHo/VEcBfaBxL+uJ9J/tHv5FYABpQOGuKL7JC4RA
        jN1790gCuuvz2THqfbfX+qGnawx22nX4M402wWJca0APrfVcULsgWQqGLyWAi2W/xjB0Si7eGIs
        EQUyBi7kMF7Bk9eig8N7I8TGq6tUyoKY0Qz5bgg4S1QU7oLHD/AKFbrDa1VxS6iU=
X-Google-Smtp-Source: APXvYqxrZPLKeZj4DYtQEzQTRB7NOVY9XFeyaBWi7zpzD2on5Y0Abw+1Nu/fVIKRKYIscQhNQ/NBoCt2HhEPnA==
X-Received: by 2002:a81:9a01:: with SMTP id r1mr79009137ywg.490.1564783360627;
 Fri, 02 Aug 2019 15:02:40 -0700 (PDT)
Date:   Fri,  2 Aug 2019 15:02:34 -0700
In-Reply-To: <cover.1564771000.git.steadmon@google.com>
Message-Id: <65e05a3db59ec62ae7105ffe1cb4225b843dedc6.1564771000.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1564771000.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [RFC PATCH v2 1/2] docs: mention trace2 target-dir mode in git-config
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the description of trace2's target-directory behavior into the
shared trace2-target-values file so that it is included in both the
git-config and api-trace2 docs. Leave the SID discussion only in
api-trace2 since it's a technical detail.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 7 +++----
 Documentation/trace2-target-values.txt | 4 +++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index f7ffe7d599..b831d65460 100644
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
2.22.0.770.g0f2c4a37fd-goog

