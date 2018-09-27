Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793811F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeI1Bce (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:32:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36620 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbeI1Bce (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:32:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id p89-v6so3518607ljb.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Xva8vQDZEMUAE1Q6f9lSk4IcxNRk30fbL+PPGRBeEk=;
        b=KHL1GmtKO907sM0XeXCmwpBSLIo/OVK/QtLrLjsrhj/2tIqHU3Cfb3XebwziHaRkvu
         EyzXycK/aLlgZWcSqUlvSBEPu6e9nVeZdh+JZOt8hEDO65rRNkta64q7udTky+7FEtbX
         npua7lmTsJZe/EYWGsbgW2xVPMIFzIrgzYE284uFWJQTKIyp4XQQLLOPFDPayjAAQafN
         cfdIUUmK1gD4JFeiATJIaNXBxAlVf5epYVV1ywy6luP1Rx1NAJktVUt9Ub2As0WpBMSR
         YUgQxina4eJ01zJsWKCiad5dKZrPZRFX7st7wYiZo9o5dWzFOFHMg2mjpDiGJZM08rKv
         snvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Xva8vQDZEMUAE1Q6f9lSk4IcxNRk30fbL+PPGRBeEk=;
        b=NxwFXVp1Fiulg27Sha48oHSkl/GaFt05hbjTuXn+IZdBj7zOHbaLqiyrrMJpkJuOTZ
         Z7DDBr4TnLQEtJnQMXHaffTXcsjUAzOcck1FxXtLE89VeXSyrfgXbWCW60kBI3N3B4aX
         iFMsntGECyJwJqY8aaf5zTsKT2welFqHO2ebyKh/JcFgbIlfS9dOblamq1qXVok5frjh
         zxp6lDxQ2+NGlIo2kMM8O6yPlYUYEMaU8wCjYSqqnbbWCnuRT0TTCtxnb5WUq+3AJSYg
         3VqR+O9Qkdse3UIjPZXC/7Nvszgeb3xP1qmzcgkC4cWOHuyciTTo6/nhwhCTFkqS1dNg
         O5mQ==
X-Gm-Message-State: ABuFfojQtk1NlPVCx6uf1/qr2wKUjIMt3qLcamU9ZL+xxjfbv90tTMaV
        fPG6GDAx83svEIQcpC9/mdAMk/+5
X-Google-Smtp-Source: ACcGV60XgoXfYBAQM2l+HzvWIM+bNZVm4gMg1qw7g4rJ77vewig4jGWIOcUM2qHRTmpM3CwQ2OVqHw==
X-Received: by 2002:a2e:8346:: with SMTP id l6-v6mr7450827ljh.72.1538075566016;
        Thu, 27 Sep 2018 12:12:46 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id r79-v6sm561673ljb.84.2018.09.27.12.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 12:12:45 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 4/4] Doc: refer to the "commit-graph file" with dash
Date:   Thu, 27 Sep 2018 21:12:22 +0200
Message-Id: <99b64287ec22e8690d5518002240be3e9147cb8e.1538075326.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <cover.1538075326.git.martin.agren@gmail.com>
References: <6b1cb43e-a1a8-921f-cd66-3697609854e0@gmail.com> <cover.1538075326.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file processed by `git commit-graph` is referred to as the
"commit-graph file", also with a dash. We have a few references to the
"commit graph file", though, without the dash. These occur in
git-commit-graph.txt as well as in Doc/technical/commit-graph.txt. Fix
them.

Do not change the references to the "commit graph" (without "... file")
as a data structure.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit-graph.txt       | 12 ++++++------
 Documentation/technical/commit-graph.txt |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index f33330a171..624470e198 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -3,7 +3,7 @@ git-commit-graph(1)
 
 NAME
 ----
-git-commit-graph - Write and verify Git commit graph files
+git-commit-graph - Write and verify Git commit-graph files
 
 
 SYNOPSIS
@@ -17,16 +17,16 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Manage the serialized commit graph file.
+Manage the serialized commit-graph file.
 
 
 OPTIONS
 -------
 --object-dir::
-	Use given directory for the location of packfiles and commit graph
+	Use given directory for the location of packfiles and commit-graph
 	file. This parameter exists to specify the location of an alternate
 	that only has the objects directory, not a full `.git` directory. The
-	commit graph file is expected to be at `<dir>/info/commit-graph` and
+	commit-graph file is expected to be at `<dir>/info/commit-graph` and
 	the packfiles are expected to be in `<dir>/pack`.
 
 
@@ -34,7 +34,7 @@ COMMANDS
 --------
 'write'::
 
-Write a commit graph file based on the commits found in packfiles.
+Write a commit-graph file based on the commits found in packfiles.
 +
 With the `--stdin-packs` option, generate the new commit graph by
 walking objects only in the specified pack-indexes. (Cannot be combined
@@ -66,7 +66,7 @@ database. Used to check for corrupted data.
 EXAMPLES
 --------
 
-* Write a commit graph file for the packed commits in your local `.git`
+* Write a commit-graph file for the packed commits in your local `.git`
   directory.
 +
 ------------------------------------------------
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index c664acbd76..6b7dde011e 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -15,13 +15,13 @@ There are two main costs here:
 1. Decompressing and parsing commits.
 2. Walking the entire graph to satisfy topological order constraints.
 
-The commit graph file is a supplemental data structure that accelerates
+The commit-graph file is a supplemental data structure that accelerates
 commit graph walks. If a user downgrades or disables the 'core.commitGraph'
 config setting, then the existing ODB is sufficient. The file is stored
 as "commit-graph" either in the .git/objects/info directory or in the info
 directory of an alternate.
 
-The commit graph file stores the commit graph structure along with some
+The commit-graph file stores the commit graph structure along with some
 extra metadata to speed up graph walks. By listing commit OIDs in lexi-
 cographic order, we can identify an integer position for each commit and
 refer to the parents of a commit using those integer positions. We use
@@ -103,7 +103,7 @@ that of a parent.
 Design Details
 --------------
 
-- The commit graph file is stored in a file named 'commit-graph' in the
+- The commit-graph file is stored in a file named 'commit-graph' in the
   .git/objects/info directory. This could be stored in the info directory
   of an alternate.
 
@@ -127,7 +127,7 @@ Future Work
     - 'log --topo-order'
     - 'tag --merged'
 
-- A server could provide a commit graph file as part of the network protocol
+- A server could provide a commit-graph file as part of the network protocol
   to avoid extra calculations by clients. This feature is only of benefit if
   the user is willing to trust the file, because verifying the file is correct
   is as hard as computing it from scratch.
-- 
2.19.0.216.g2d3b1c576c

