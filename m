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
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E5E1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 23:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfJCXdF (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 19:33:05 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43000 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfJCXdF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 19:33:05 -0400
Received: by mail-pg1-f201.google.com with SMTP id d3so3031548pgv.9
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 16:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qVnqpH3h8oCKfyBF6a9bDdxgKtpHWtZSjCn/mKy7u3Y=;
        b=U6vtP4GNz8gSVkdobeU9NJazWvIVfTFvYc0OhVTNE79pwTNuuPpVLhu/OtFLLSm+8i
         hTOPXv7D84DeSppL3l4jPBLRyoks48FNP9M3Kfrf+8PmhxO5gdsB5MhZkZY4UNYMzRYo
         xPELOK9wSvoxxNDyn+Oum25gbE3tIzFVH6mki8NhtsrgJ7lueEwkHmCNihquFcGpqm2Y
         /t03E8L1kn3p2zx//xCN/IIn4Eb3gVI4gnK/k39HyLRpaEi+1ps9HkDkzAwORow8kmQH
         aFX66N7LIpuoErHYEjJEpwTEp6lh5j9TyAZbuREYua7vr6TAboEaGwQoh/S2K5gi72JZ
         3VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qVnqpH3h8oCKfyBF6a9bDdxgKtpHWtZSjCn/mKy7u3Y=;
        b=gkSEvbDDFt/3gmIW4A+R6fKkdjKceCVIJbHuIZj3rdmYILVleYezGSQ+eXO3cF98P5
         HwgyGs9I9+M7R4taobOgDxNofF1IF/3K81/ybtq1kJaGEm1F0beSLEw1grVLFeS3zBNe
         rg39KNY/XcZyd22a+MwQaLrVkVvUVHXB5ADG26uIlc5jzJsv0FFZQ047DXVkKxaNzM5n
         sUTyjRtuR8WK/sxYkXaxBFkjGtwl4BUeaHS+w0nWMhoKap0d9NYsbRZJqYoZUMT13ZDj
         8Al72Zaw0zY6eallePd0IGXnVm/fwYa4CVL1CQ8tU8B8fPVeqM/i+leC0I+2l4d6QfOh
         Q9Tw==
X-Gm-Message-State: APjAAAXw/JbP3jq4pDKumyXdviLh9L80S0qkoZrSqLULQX3OGgq5DCpt
        h0AyWNDohhIPQXM7zRLInF573l9AbIqEGYc5ZwbAgUBvuf4w6a+7T+ToLmZP7RMFEbdHJsVfWK+
        /HMbbSjOgtP4LQuiTJnUxI1lGmpjcnN5rLwbkjo5H7qD5/DPFzfJ4oO3UQic8IxQ=
X-Google-Smtp-Source: APXvYqxWFfozsMWxY839NGq/mDmnYuVDfaNHN5byZhwl8IHR2wu5AQSeShXjklNZdKOjcP2kf1m4Ig8w4pvZ+Q==
X-Received: by 2002:a63:211c:: with SMTP id h28mr12215821pgh.372.1570145584625;
 Thu, 03 Oct 2019 16:33:04 -0700 (PDT)
Date:   Thu,  3 Oct 2019 16:32:56 -0700
In-Reply-To: <cover.1570144820.git.steadmon@google.com>
Message-Id: <eacffe250d2029f190d04144c9242ae25b8fb094.1570144820.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1570144820.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v4 1/4] docs: mention trace2 target-dir mode in git-config
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     stolee@gmail.com
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

