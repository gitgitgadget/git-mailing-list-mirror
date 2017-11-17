Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7483F202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 16:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759079AbdKQQJN (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 11:09:13 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36054 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759047AbdKQQJM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 11:09:12 -0500
Received: by mail-wr0-f196.google.com with SMTP id y42so2546064wrd.3
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 08:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kA/vKyWDGpbtBBlNxlfEYhDcmRABhf6kB9P+pdvapAE=;
        b=T1pDg3aYGqbQ/PKqwT2E12Kk1WkkyOf2HMr6jqv2TQyrWEAmmFMK1G29rpZbiKsBmJ
         X4/7nfKbym6tPROYRqHixtwLTgGnimp4y4ZYa8APPrktL0heOWF3Rythsr141AKDyDDn
         Id3EUVzUka2DE85WY5MHpbs1IAeXTnkpxhPmkHAorxy4HMHVFQeP4TF4cOVQJ4VSzg/5
         6Tny0sajKs/4aUSnb2r2tysG5O9yblTdqhSy9fCJKkzwU4fx3nq5HNz/H+yVB6m2os6C
         OD/yNrnCC14SyDOla/V2k1H0tbkndDjBwRoaN2MjfbPvzhljIeio8gwqe77D/e6yT7p3
         8m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kA/vKyWDGpbtBBlNxlfEYhDcmRABhf6kB9P+pdvapAE=;
        b=EpVoSt0jXBxTkRe3lqq5Up17NUqFCRJ7Yk8HrFcUk8+9t6M2g5RCFgj5C87XNhJD2D
         cuNRFaQkfURYu7j8h4G70YYiwZNFWQfnC2c1UD8RJVW+AfJIc5EOFmuBg65Thm+gRN6B
         s9VbFsmBpybF3YUe9ukDlUZVYleuPFr8uxhv1gPfiHSLFuL9AENUtUhWEqRJNuQkrtHc
         /w2CqcfepfbsuObaMXbcU60lGD2IyeGxq8cGUUbz5AvBOI/Buk7iGTILcXxhWgyih/ft
         lJ4W0x/MoUcTJfO4bi7Avt7XAeG9fxgN75x3EZ92jAaPOFTwOlc+DIaQz5OL6yyD++u7
         y6cw==
X-Gm-Message-State: AJaThX7pRdrf55Jn7JAn9SAZbOAgswsawSd3rbRLcRj2mj7Z7ZcwAbgF
        n/ucf5PBhfTUR+0Un4zbe2kOSNLE
X-Google-Smtp-Source: AGs4zMavGiIC19OyjiVTxrFoUXubdYJYSGpizJWPb4nPNio368V6/PecB/SryKpwxecOgxaMocVE2Q==
X-Received: by 10.223.190.134 with SMTP id i6mr5185838wrh.177.1510934950264;
        Fri, 17 Nov 2017 08:09:10 -0800 (PST)
Received: from dnl-413.univ-lyon1.fr (wifi-ext-0165.univ-lyon1.fr. [134.214.214.166])
        by smtp.gmail.com with ESMTPSA id o190sm4777307wmd.32.2017.11.17.08.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Nov 2017 08:09:09 -0800 (PST)
From:   Daniel Bensoussan <danielbensoussanbohm@gmail.com>
X-Google-Original-From: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
To:     git@vger.kernel.org
Cc:     ALBERTIN TIMOTHEE 11514771 <timothee.albertin@etu.univ-lyon1.fr>
Subject: [PATCH 1/2] Documentation about triangular workflow
Date:   Fri, 17 Nov 2017 17:07:58 +0100
Message-Id: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ALBERTIN TIMOTHEE 11514771 <timothee.albertin@etu.univ-lyon1.fr>

---
 Documentation/gitworkflows.txt | 215 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 02569d061..3f1ddba82 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -464,6 +464,221 @@ in patches to figure out the merge base.  See linkgit:git-am[1] for
 other options.
 
 
+TRIANGULAR WORKFLOW
+-------------------
+
+Introduction
+~~~~~~~~~~~~
+
+In some projects, contributors cannot push directly to the project but
+have to suggest their commits to the maintainer (e.g. pull requests).
+For these projects, it's common to use what's called a *triangular
+workflow*:
+
+- The project maintainer publishes a repository, called **UPSTREAM** in
+this document, which is a read-only for contributors. They can clone and
+fetch from this repository.
+- Contributors publish their modifications by pushing to a repository,
+called **PUBLISH** in this document, and request a merge.
+- Opening a pull request
+- If the maintainer accepts the changes, he merges them into the
+  **UPSTREAM** repository.
+
+This workflow is commonly used on different platforms like BitBucket,
+GitHub or GitLab which provide a dedicated mechanism for requesting merges.
+
+........................................
+------------------               -----------------
+| UPSTREAM       |  maintainer   | PUBLISH       |
+|  git/git       |- - - - - - - -|  me/remote    |
+------------------      <-       -----------------
+              \                     /
+               \                   /
+        fetch | \                 / ^ push
+              v  \               /  |
+                  \             /
+                   -------------
+                   |   LOCAL   |
+                   -------------
+........................................
+
+Motivations
+~~~~~~~~~~~
+
+* Allows contributors to work with Git even if they don't have
+write access to **UPSTREAM**.
+
+Indeed, in a centralized workflow, a contributor without write access
+could write some code but could not send it by itself.  The contributor
+was forced to create a mail which shows the difference between the
+new and the old code, and then send it to a maintainer to commit
+and push it.  This isn't convenient at all, neither for the
+contributor, neither for the maintainer. With the triangular
+workflow, the contributors have the write access on **PUBLISH**
+so they don't have to pass upon maintainer(s).  And only the
+maintainer(s) can push from **PUBLISH** to **UPSTREAM**.
+This is called a distributed workflow (See "DISTRIBUTED WORKFLOWS"
+above).
+
+* Code review is made before integration.
+
+The goal of the triangular workflow is also that the rest of the
+community or the company can review the code before it's in production.
+Everyone can read on **PUBLISH** so everyone can review code
+before the maintainer(s) merge it to **UPSTREAM**.  It also means
+that, in a free software, anyone can propose code without danger
+for the stability of the software.
+
+* Encourages clean history by using `rebase -i` and `push --force` to
+the public fork before the code is merged.
+
+This is just a side-effect of the "review before merge" mentionned
+above but this is still a good point.
+
+
+
+Here are the configuration variables you will need to arrange your
+workflow.
+
+Preparation as a contributor
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Cloning from **PUBLISH**, which is a fork of **UPSTREAM** or an empty
+repository.
+
+======================
+`git clone <PUBLISH_url>`
+======================
+
+Setting the behavior of push for the triangular workflow:
+
+===========================
+`git config push.default current`
+===========================
+
+Adding **UPSTREAM** remote:
+
+===================================
+`git remote add upstream <UPSTREAM_url>`
+===================================
+
+With the `remote add` above, using `git pull upstream` pulls there,
+instead of saying its URL. In addition, the `git pull` command
+(without argument) can be used to pull from **UPSTREAM**.
+
+For each branch requiring a triangular workflow, set
+`branch.<branch>.remote` and `branch.<branch>.pushRemote` to set up
+the **UPSTREAM** and **PUBLISH** repositories.
+
+Example with master as <branch>:
+===================================
+* `git config branch.master.remote upstream`
+* `git config branch.master.pushRemote origin`
+===================================
+
+Staying up-to-date
+~~~~~~~~~~~~~~~~~~
+
+Retrieve updates from **UPSTREAM** with `git pull` and send them to
+**PUBLISH** with `git push`.
+
+Making your work available
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The `git push` command sends commits to the **PUBLISH** repository and not to
+the **UPSTREAM** thanks to the configuration you did earlier with the
+`git config remote.pushdefault origin` command.
+
+When a contributor pushes something, the `git config push.default
+current` command can be used to specifies that the name of the
+**PUBLISH** branch is the same as the name of the **LOCAL** one.
+
+.Display the push remote's name:
+[caption="Recipe: "]
+
+=================================
+`git rev-parse --abbrev-ref @{push}`
+=================================
+
+The shorthand `<branch>@{push}` denotes the remote-tracking branch
+where the <branch> would be pushed to. If no <branch> is specified
+(`@{push}`), <branch> takes the value of the current branch.
+
+
+.Display the fetch remote's name:
+[caption="Recipe: "]
+
+===================================
+`git rev-parse --abbrev-ref @{upstream}`
+===================================
+
+The shorthand `<branch>@{upstream}` substitutes the upstream name of
+the branch. If no <branch> is specified (`@{upstream}`), <branch>
+takes the value of the current branch.
+
+.Display commits added to the current branch since last push:
+[caption="Recipe: "]
+
+===============
+`git log @{push}..`
+===============
+
+.Display commits added to a specific branch since last push:
+[caption="Recipe: "]
+
+============================
+`git log <branch_name>@{push}..`
+============================
+
+Alternatively
+~~~~~~~~~~~~~
+
+Cloning from **UPSTREAM**
+[caption="Recipe: "]
+
+In the preparation above, a clone from **PUBLISH** was used. Starting
+with a clone of **UPSTREAM** is possible too.
+
+Cloning from **UPSTREAM**
+
+======================
+`git clone <UPSTREAM_url>`
+======================
+
+Setting the behavior of push for the triangular workflow:
+
+===========================
+`git config push.default current`
+===========================
+
+Because modifications will be often pushed into the **PUBLISH** repository,
+instead of having to type its URL every time, a short name can be used
+to call it.
+
+Adding **PUBLISH** remote:
+
+===================================
+`git remote add publish <PUBLISH_url>`
+===================================
+
+With the `remote add` above, using `git push publish` pushes there,
+instead of saying its URL. In addition, `git push` can push to
+**PUBLISH** without argument.
+
+'Method 1: One option for all branches'
+
+===================================
+`git config remote.pushDefault publish`
+===================================
+
+'Method 2: Each branch its option'
+
+Example with master as <branch>:
+===================================
+`git config branch.master.pushRemote publish`
+===================================
+
+
 SEE ALSO
 --------
 linkgit:gittutorial[7],
-- 
2.11.0

