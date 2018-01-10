Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD361FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 06:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeAJGu3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 01:50:29 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:40389 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbeAJGu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 01:50:28 -0500
Received: by mail-pl0-f50.google.com with SMTP id 62so6746131pld.7
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 22:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cN+/WQI6lEEY/OpyzlBmyUjkUidQcFs/4zTB7olXnNg=;
        b=i85/U3rpDUFSz27XInLR89FqGDd0FVNGSr3vqMZpURE0/vMPieazjZ8szrB/1KT2ar
         G5Mw0guFI6X+MW9K9v3JgN7kp3xp+pnBNVIBWGHfEuk9aAVLT3JMHCT/JvnyPGAskbbh
         qIUcu9MC648x4qT0F2yNqSAtp3T5IBlXfkhar/auqU0OF23Cg24dNqX26/IySX6wjtsh
         XGY17glXtnsLmQeyOuzNR/OIWWxzsbkRIVP58iCkLljHFmAlvRfDEV3eN37taOoUy2My
         IYOMSmnOtiegNCRS2jxyNdecqTsfpn9HpuqNCA4qDNkf+Yhdtly51jm58/3847CSFvXh
         7nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cN+/WQI6lEEY/OpyzlBmyUjkUidQcFs/4zTB7olXnNg=;
        b=GtGton207STqx+G1D7bjguDb1XL9yfvslH9cmwpvL58uD9thcwr6Y5qEB4KXghQnUw
         2FNXfHerX4OpF6NdBAKF2BDHjtyv/p+DZnJzp4nR+Xfq+Dbs8Zfmc4miQVxf7l2DwylV
         k4jZTuR1RG/OPGgmOpFhi+OCOtRvSq4Le905Y3KXtPDKsvH0wxtdLYFlUqTnAlnwMa9+
         n4kKFstJ4Khdl0JbYueKmi9t0kBSfPOvVJF/9EXsXjQoP8lRYJaKkUmeheqTeiHITZnN
         EvhFHfiLqMOIdejxqyPfdalJFbY4OK12Qmkx+fMnuTPRGkaQuh4FpamjpGpvd4lxIQXN
         Ou4w==
X-Gm-Message-State: AKGB3mK7oqtJj2VVkbowStjAFCrnI+35//O78Q2AEZ3WCbwQoC8bdlpV
        9seGSv32ntEAlp/YKr13M7cVIToN
X-Google-Smtp-Source: ACJfBov2xEwk1Z/hkPVq7XZj7g2EeqtZKhaGzB2mnMh3O08whLMCieNq5jA2/dOQsoZCO/Wt4TyMeA==
X-Received: by 10.84.130.78 with SMTP id 72mr18144428plc.278.1515567027695;
        Tue, 09 Jan 2018 22:50:27 -0800 (PST)
Received: from unique-pc.sce.com ([117.209.247.76])
        by smtp.gmail.com with ESMTPSA id b69sm22407237pfk.128.2018.01.09.22.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 22:50:26 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jon Forrest <nobozo@gmail.com>
Subject: [PATCH v2 0/2] Doc/submodules: a few updates
Date:   Wed, 10 Jan 2018 12:19:57 +0530
Message-Id: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting from v1,

    These are just a few improvements that I thought would make the documentation
    related to submodules a little better in various way such as readability,
    consistency etc., These were things I noticed while reading thise documents.

Change since v2: 

 I've squashed the fine grained patches into 2 patches that touch two distinct
 documents. This v2 conatins a lot of changes suggested for v1 and few that I
 caught by myself since v1.

This patch is based on 'master' just like v1.

Inter-word-diff v1..v2:

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 5c4d941cc..801d291ca 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -140,7 +140,7 @@ through the `submodule.<name>.update` configuration are:
	    checked out in the submodule on a detached HEAD.
+
If `--force` is specified, the submodule will be checked out (using
`git checkout [---force` if appropriate),-]{+--force`),+} even if the commit specified
in the index of the containing repository already matches the commit
checked out in the submodule.

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 339fb73db..ce2369c2d 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -36,7 +36,7 @@ The `gitlink` entry contains the object name of the commit that the
superproject expects the submodule’s working directory to be at.

The section `submodule.foo.*` in the `.gitmodules` file gives additional
hints to [-Gits-]{+Git's+} porcelain layer. For example, the `submodule.foo.url`
setting specifies where to obtain the submodule.

Submodules can be used for at least two different use cases:
@@ -51,21 +51,21 @@ Submodules can be used for at least two different use cases:

2. Splitting a (logically single) project into multiple
   repositories and tying them back together. This can be used to
   overcome current limitations of [-Gits-]{+Git's+} implementation to have
   finer grained access:

    * Size of the [-git-]{+Git+} repository:
      In its current form Git scales up poorly for large repositories containing
      content that is not compressed by delta computation between trees.
      [-Therefore-]{+For example,+} you can use submodules to hold large binary assets
      and these repositories [-are then-]{+can be+} shallowly cloned such that you do not
      have a large history locally.
    * Transfer size:
      In its current form Git requires the whole working tree present. It
      does not allow partial trees to be transferred in fetch or clone.
      If [-you have your-]{+the+} project [-as-]{+you work on consists of+} multiple repositories tied
      together as submodules in a superproject, you can avoid fetching the
      working trees of the repositories you are not interested in.
    * Access control:
      By restricting user access to submodules, this can be used to implement
      read/write policies for different users.
@@ -76,10 +76,10 @@ The configuration of submodules
Submodule operations can be configured using the following mechanisms
(from highest to lowest precedence):

 * The command line [-arguments of-]{+for+} those commands that support taking [-submodule-]
[-   specifications.-]{+submodules+}
{+   as part of their pathspecs.+} Most commands have a boolean flag
   [-'--recurse-submodules'-]{+`--recurse-submodules`+} which specify whether [-they should-]{+to+} recurse into submodules.
   Examples are [-`ls-files` or-]{+`grep` and+} `checkout`.
   Some commands take enums, such as `fetch` and `push`, where you can
   specify how submodules are affected.

@@ -101,17 +101,17 @@ remotes are configured in the submodule as usual in the `$GIT_DIR/config`
file.

 * The configuration file `$GIT_DIR/config` in the superproject.
   [-Typical configuration at this place is controlling if a submodule-]
[-   is recursed-]{+Git only recurses+} into [-at all via the `active` flag for example.-]{+active submodules (see 'ACTIVE SUBMODULES'+}
{+   section below).+}
+
If the submodule is not yet initialized, then the configuration
inside the submodule does not exist yet, so[-configuration-] where to
obtain the submodule from is configured here for example.

 * The `.gitmodules` file inside the superproject. [-Additionally, if mapping-]
[-   is required between a submodule's name and its path, a-]{+A+} project usually
   uses this file to suggest defaults for the upstream collection
   of [-repositories.-]{+repositories for the mapping that is required between a+}
{+   submodule's name and its path.+}
+
This file mainly serves as the mapping between the name and path of submodules
in the superproject, such that the submodule's Git directory can be
@@ -141,8 +141,8 @@ directory is automatically moved to `$GIT_DIR/modules/<name>/`
of the superproject.

 * Deinitialized submodule: A `gitlink`, and a `.gitmodules` entry,
but no submodule working directory. The submodule’s [-git-]{+Git+} directory
may be there as after deinitializing the [-git-]{+Git+} directory is kept around.
The directory which is supposed to be the working directory is empty instead.
+
A submodule can be deinitialized by running `git submodule deinit`.
@@ -164,6 +164,53 @@ from another repository.
To completely remove a submodule, manually delete
`$GIT_DIR/modules/<name>/`.

{+Active submodules+}
{+-----------------+}

{+A submodule is considered active,+}

{+  (a) if `submodule.<name>.active` is set+}
{+     or+}
{+  (b) if the submodules path matches the pathspec in `submodule.active`+}
{+     or+}
{+  (c) if `submodule.<name>.url` is set.+}

{+For example:+}

{+    [submodule "foo"]+}
{+        active = false+}
{+        url = https://example.org/foo+}
{+    [submodule "bar"]+}
{+        active = true+}
{+        url = https://example.org/bar+}
{+    [submodule "baz"]+}
{+        url = https://example.org/baz+}

{+In the above config only the submodule bar and baz are active,+}
{+bar due to (a) and baz due to (c).+}

{+Note that '(c)' is a historical artefact and will be ignored if the+}
{+pathspec set in (b) excludes the submodule. For example:+}

{+    [submodule "foo"]+}
{+        active = true+}
{+        url = https://example.org/foo+}
{+    [submodule "bar"]+}
{+        url = https://example.org/bar+}
{+    [submodule "baz"]+}
{+        url = https://example.org/baz+}
{+    [submodule "bob"]+}
{+        ignore = true+}
{+    [submodule]+}
{+        active = b*+}
{+        active = (:exclude) baz+}

{+In here all submodules except baz (foo, bar, bob) are active.+}
{+'foo' due to its own active flag and all the others due to the+}
{+submodule active pathspec, which specifies that any submodule+}
{+starting with 'b' except 'baz' are also active, no matter if+}
{+the .url field is present.+}

Workflow for a third party library
----------------------------------



Kaartic Sivaraam (2):
  Doc/gitsubmodules: make some changes to improve readability and syntax
  Doc/git-submodule: improve readability and grammar of a sentence

 Documentation/git-submodule.txt | 12 +++---
 Documentation/gitsubmodules.txt | 93 +++++++++++++++++++++++++++++++----------
 2 files changed, 78 insertions(+), 27 deletions(-)

-- 
2.16.0.rc0.223.g4a4ac8367

