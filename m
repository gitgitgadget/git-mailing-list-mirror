Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2552BECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiHaQDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiHaQCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:02:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100A980B58
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h1so7606465wmd.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=NHckKwoRME6izHezy19QDuLVea12ybAgp0ADMPSukzw=;
        b=aGDdFHH2klE3q+vHfSLone/CkLw+JBcfgLz1yKi6qqutiQSAvUQTtFx5xYl/IJWKqU
         t3EMkbrLFqRvXJfqrAQkSHPk+I4A3Paq8SiAOi367Wpcu7OyOWdxLzTMneSuw7d/vERt
         pISus+haneTZpW3GW686bwgf78C9WBCejF9Duw0L4QZy48aO6HkAyJt/I4X/OeZB296h
         PwWcKSEJY6imWHjpymzYZkIb5yY21l8PeztL3czg72TPWC31eOLi/IrKAYHGIgloihbF
         wtU6d6T/UIshfUms/CBz2Mr/EpGPdZ5A4ytJvyO9vkdqZdEgVyf1CVu7EYvustRIWsZI
         9eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=NHckKwoRME6izHezy19QDuLVea12ybAgp0ADMPSukzw=;
        b=SGhz4kkhc23Wao9B9xF/ZQw7UuvmWFzoa844ipBWsnqwOIMaOmZjf/qaHrd08+f+q9
         KiBNR/X7IjZ5CickXO9fA4IZIUreDPB3kDS6aEToOjxyiCijhzi0JsFe8S8yrtNVY3gn
         WFgHS+FgIghBXJ8bbKx2c8iOjKSth4v622UeBexFdGeO5HTVlWlXmltF2PDdJZDoq50n
         zKDPEs0aKSHQR+U+2mZJsSNBzSIxh2r7545/AsHCQzrvchjbCkHsRn2gEjg70wXP8Zqj
         yastRkuyG1BXbMBkoiY/LI8tj0GwWUeRCruFlfPL2VdAU0y25ejVc7Oqo/qYfgj5vyb2
         gp0Q==
X-Gm-Message-State: ACgBeo2DsEhIOiuQFhuWSubFKiht6YseD+aqJ7YZJ+zxpIbIfTJmTzLW
        +1WyzIVJP60n7ze7pHGu/AYkXvr4dHQ=
X-Google-Smtp-Source: AA6agR4TMOfYyGoAqS1XM0I0QmDCVe0N6F+/ctklPxAhvWjWBUP6sieOqgYwZTAWijx6kcJm1DHhwA==
X-Received: by 2002:a1c:a107:0:b0:3a6:8b06:cf19 with SMTP id k7-20020a1ca107000000b003a68b06cf19mr2435895wme.195.1661961772218;
        Wed, 31 Aug 2022 09:02:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o26-20020a05600c511a00b003a643ac2b08sm2595246wms.8.2022.08.31.09.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:02:51 -0700 (PDT)
Message-Id: <8bbe913dccf91bc4e6c76cbe85c585d223fc4aef.1661961746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:02:25 +0000
Subject: [PATCH 8/8] Documentation/technical: include Scalar technical doc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Include 'Documentation/technical/scalar.txt' alongside the other HTML
technical docs when installing them.

Now that the document is intended as a widely-accessible reference, remove
the internal work-in-progress roadmap from the document. Those details
should no longer be needed to guide Scalar's development and, if they were
left, they could fall out-of-date and be misleading to readers.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/Makefile             |  1 +
 Documentation/technical/scalar.txt | 61 ------------------------------
 2 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 16c9e062390..9ec53afdf18 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -116,6 +116,7 @@ TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
+TECH_DOCS += technical/scalar
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
 TECH_DOCS += technical/trivial-merge
diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.txt
index 0600150b3ad..921cb104c3c 100644
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@ -64,64 +64,3 @@ some "global" `git` options (e.g., `-c` and `-C`).
 Because `scalar` is not invoked as a Git subcommand (like `git scalar`), it is
 built and installed as its own executable in the `bin/` directory, alongside
 `git`, `git-gui`, etc.
-
-Roadmap
--------
-
-NOTE: this section will be removed once the remaining tasks outlined in this
-roadmap are complete.
-
-Scalar is a large enough project that it is being upstreamed incrementally,
-living in `contrib/` until it is feature-complete. So far, the following patch
-series have been accepted:
-
-- `scalar-the-beginning`: The initial patch series which sets up
-  `contrib/scalar/` and populates it with a minimal `scalar` command that
-  demonstrates the fundamental ideas.
-
-- `scalar-c-and-C`: The `scalar` command learns about two options that can be
-  specified before the command, `-c <key>=<value>` and `-C <directory>`.
-
-- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
-
-- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
-  into `git diagnose` and `git bugreport --diagnose`.
-
-- 'scalar-add-fsmonitor: Enable the built-in FSMonitor in Scalar
-  enlistments. At the end of this series, Scalar should be feature-complete
-  from the perspective of a user.
-
-Roughly speaking (and subject to change), the following series are needed to
-"finish" this initial version of Scalar:
-
-- Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
-  `git`. This includes a variety of related updates, including:
-    - building & installing Scalar in the Git root-level 'make [install]'.
-    - builing & testing Scalar as part of CI.
-    - moving and expanding test coverage of Scalar (including perf tests).
-    - implementing 'scalar help'/'git help scalar' to display scalar
-      documentation.
-
-Finally, there are two additional patch series that exist in Microsoft's fork of
-Git, but there is no current plan to upstream them. There are some interesting
-ideas there, but the implementation is too specific to Azure Repos and/or VFS
-for Git to be of much help in general.
-
-These still exist mainly because the GVFS protocol is what Azure Repos has
-instead of partial clone, while Git is focused on improving partial clone:
-
-- `scalar-with-gvfs`: The primary purpose of this patch series is to support
-  existing Scalar users whose repositories are hosted in Azure Repos (which does
-  not support Git's partial clones, but supports its predecessor, the GVFS
-  protocol, which is used by Scalar to emulate the partial clone).
-
-  Since the GVFS protocol will never be supported by core Git, this patch series
-  will remain in Microsoft's fork of Git.
-
-- `run-scalar-functional-tests`: The Scalar project developed a quite
-  comprehensive set of integration tests (or, "Functional Tests"). They are the
-  sole remaining part of the original C#-based Scalar project, and this patch
-  adds a GitHub workflow that runs them all.
-
-  Since the tests partially depend on features that are only provided in the
-  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.
-- 
gitgitgadget
