Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BCE1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeJWFGb (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:06:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51568 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbeJWFG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:06:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so11601649wmf.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LhMNufZzSgQItXyW/Og2mFsutqsu+K5cKxiaHLyTyM=;
        b=Cw1rIOC7EINjA7QdsNE87Kj4xMw8G+vWbkpEo3Pe7SYFemuHmxiLHHKm5xLCR2OXjE
         aETxGCaZ51JSYh47V96qJ3VHOUj69P/XhLDEecDF/mHQcTUZ5yPnH0g6vhdOOjwyzOQH
         UQA7O25WZMCqUs55VYpiEWGXQruATMH0l/KxgFLnI+F4J0esBZrsFbejGI4kXCbj6f/P
         O3wqIYI1fRd8pdLoksvnkkhqo+Nr/xmw+NqaU6XhzA+zP8sU3DSzS4hSaP42Z1zDEC9f
         h6aurJXyq6qw6IFydzQpndRXOHf6WcsXkE3FMJl/w+Jw8DZ9+01FbLlucd6I8Mp5nGNM
         9+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LhMNufZzSgQItXyW/Og2mFsutqsu+K5cKxiaHLyTyM=;
        b=Npt7zjncJf6bGuG8Uqs6C22KriH3xR2i3G/nM6aQqVAhc6n3k5JTYfllMhHeUa7l9F
         OwLIYs3c/Fo86DP+mO5T0eiIvK+bQKFABauOXTIT80NKth7jWVQTDWe/6o4a2DFdB3Iq
         2xymWwaVoYRJHCAUlF4VWcO0DF7IIfyaPqfptJXIKBxu4wOzg1FZP0P4eMlYHm0y8Uhy
         30n/bZNzfU2NzjKtnHp5atQZ/xPnJciIeknpbtbL3jxwDtL+f7e1IMKWh52gvCg9X39y
         2W+tQqjDYmqdqb/EfFbYzwJKCu3Gqv4PBF9MQYqlIqCLuesepjoS8w7SxFEnK8NCbxvN
         5bFw==
X-Gm-Message-State: ABuFfog+NDkwKgFD8Sr4ceB4Zxf6mzigmZ+nYelXP24IC1ok//0hx5Fp
        nSmkttNYbFCjCHKHByuyHf5xaymy
X-Google-Smtp-Source: ACcGV61CtKxNSUVFWvGMv+Hz1R3gugQkZxInBFky43Tlz7hkdm22eLOAkC8g9qnPE3Cq9exEW43HAA==
X-Received: by 2002:a1c:8601:: with SMTP id i1-v6mr17002960wmd.148.1540241182767;
        Mon, 22 Oct 2018 13:46:22 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:4936:e72c:acbd:e1bd])
        by smtp.gmail.com with ESMTPSA id r134-v6sm9526526wmg.9.2018.10.22.13.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:46:21 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 3/6] doc: fix inappropriate monospace formatting
Date:   Mon, 22 Oct 2018 22:45:43 +0200
Message-Id: <20181022204546.20354-4-asheiduk@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022204546.20354-1-asheiduk@gmail.com>
References: <20181022204546.20354-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-upload-pack.txt |  1 +
 Documentation/git.txt             | 10 +++++-----
 Documentation/gitattributes.txt   | 30 +++++++++++++++---------------
 Documentation/gitmodules.txt      | 17 ++++++++++-------
 Documentation/gitsubmodules.txt   | 14 +++++++++-----
 5 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 822ad593af..998f52d3df 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git-upload-pack' [--[no-]strict] [--timeout=<n>] [--stateless-rpc]
 		  [--advertise-refs] <directory>
+
 DESCRIPTION
 -----------
 Invoked by 'git fetch-pack', learns what
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2ac9b1c7fe..00156d64aa 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -402,11 +402,11 @@ Git so take care if using a foreign front-end.
 	of Git object directories which can be used to search for Git
 	objects. New objects will not be written to these directories.
 +
-	Entries that begin with `"` (double-quote) will be interpreted
-	as C-style quoted paths, removing leading and trailing
-	double-quotes and respecting backslash escapes. E.g., the value
-	`"path-with-\"-and-:-in-it":vanilla-path` has two paths:
-	`path-with-"-and-:-in-it` and `vanilla-path`.
+Entries that begin with `"` (double-quote) will be interpreted
+as C-style quoted paths, removing leading and trailing
+double-quotes and respecting backslash escapes. E.g., the value
+`"path-with-\"-and-:-in-it":vanilla-path` has two paths:
+`path-with-"-and-:-in-it` and `vanilla-path`.
 
 `GIT_DIR`::
 	If the `GIT_DIR` environment variable is set then it
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 92010b062e..b8392fc330 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -303,21 +303,21 @@ number of pitfalls:
   attribute. If you decide to use the `working-tree-encoding` attribute
   in your repository, then it is strongly recommended to ensure that all
   clients working with the repository support it.
-
-  For example, Microsoft Visual Studio resources files (`*.rc`) or
-  PowerShell script files (`*.ps1`) are sometimes encoded in UTF-16.
-  If you declare `*.ps1` as files as UTF-16 and you add `foo.ps1` with
-  a `working-tree-encoding` enabled Git client, then `foo.ps1` will be
-  stored as UTF-8 internally. A client without `working-tree-encoding`
-  support will checkout `foo.ps1` as UTF-8 encoded file. This will
-  typically cause trouble for the users of this file.
-
-  If a Git client, that does not support the `working-tree-encoding`
-  attribute, adds a new file `bar.ps1`, then `bar.ps1` will be
-  stored "as-is" internally (in this example probably as UTF-16).
-  A client with `working-tree-encoding` support will interpret the
-  internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
-  That operation will fail and cause an error.
++
+For example, Microsoft Visual Studio resources files (`*.rc`) or
+PowerShell script files (`*.ps1`) are sometimes encoded in UTF-16.
+If you declare `*.ps1` as files as UTF-16 and you add `foo.ps1` with
+a `working-tree-encoding` enabled Git client, then `foo.ps1` will be
+stored as UTF-8 internally. A client without `working-tree-encoding`
+support will checkout `foo.ps1` as UTF-8 encoded file. This will
+typically cause trouble for the users of this file.
++
+If a Git client, that does not support the `working-tree-encoding`
+attribute, adds a new file `bar.ps1`, then `bar.ps1` will be
+stored "as-is" internally (in this example probably as UTF-16).
+A client with `working-tree-encoding` support will interpret the
+internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
+That operation will fail and cause an error.
 
 - Reencoding content to non-UTF encodings can cause errors as the
   conversion might not be UTF-8 round trip safe. If you suspect your
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 4d63def206..312b6f9259 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -67,7 +67,8 @@ submodule.<name>.fetchRecurseSubmodules::
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. The following values are supported:
-
++
+--
 	all;; The submodule will never be considered modified (but will
 	    nonetheless show up in the output of status and commit when it has
 	    been staged).
@@ -84,12 +85,14 @@ submodule.<name>.ignore::
 	    differences, and modifications to tracked and untracked files are
 	    shown. This is the default option.
 
-	If this option is also present in the submodules entry in .git/config
-	of the superproject, the setting there will override the one found in
-	.gitmodules.
-	Both settings can be overridden on the command line by using the
-	"--ignore-submodule" option. The 'git submodule' commands are not
-	affected by this setting.
+If this option is also present in the submodules entry in .git/config
+of the superproject, the setting there will override the one found in
+.gitmodules.
+
+Both settings can be overridden on the command line by using the
+"--ignore-submodule" option. The 'git submodule' commands are not
+affected by this setting.
+--
 
 submodule.<name>.shallow::
 	When set to true, a clone of this submodule will be performed as a
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 504c5f1a88..57999e9f36 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -169,11 +169,15 @@ ACTIVE SUBMODULES
 
 A submodule is considered active,
 
-  (a) if `submodule.<name>.active` is set to `true`
-     or
-  (b) if the submodule's path matches the pathspec in `submodule.active`
-     or
-  (c) if `submodule.<name>.url` is set.
+  a. if `submodule.<name>.active` is set to `true`
++
+or
+
+  b. if the submodule's path matches the pathspec in `submodule.active`
++
+or
+
+  c. if `submodule.<name>.url` is set.
 
 and these are evaluated in this order.
 
-- 
2.19.1

