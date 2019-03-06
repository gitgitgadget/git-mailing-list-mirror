Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94ECC202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 06:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfCFGbO (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 01:31:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37151 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbfCFGaq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id a17so9799097ljd.4
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 22:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7Po2fWHLcXI+ma3BHX2wEFDkpCa426g/TdfL67gvg3k=;
        b=rjYs0O0wUB+6poQdaFvMffovxWXufMA99xJ0BgutT/B0rSzGm5YfDYKF3WGmzzcpkV
         4pwge39JgY43jf4EQXcL7t3j+iC6pQudMXPNOiWXEfKEJtEJIhszx2HAWSFoY8nwOgfJ
         0vDvB9js5qX+nbUFbeQpQ/Lnrz1lmcKDJir0Ucv8WVFSGu2Mo68Qy9twDH3ABExNUvVs
         QmfQ0/e2oeknqfbBIA3N3nD3HiVSMxMjHOl9ZKoSKRGoDElECohFcWHAKn0ol7d8MXTV
         asuIOCIpmc3BLrU/xZwnWQbg1ed1dawDRgnnoky56RLNYgEsKjCzs5MB1ohRLz6QKFH9
         +aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Po2fWHLcXI+ma3BHX2wEFDkpCa426g/TdfL67gvg3k=;
        b=JpG2n2J8U6xSiEcnBteZQCDg9f5TgXclbuiL5jxgCKtc4nzR0S5OCtAn18kXfmnkOt
         xSKfFf5NciAchD7Y/h385Nki67a6u47NB45QiNHk3RbTL3Qh+kvHZcowXo4KI/GVrQBO
         J4tcrSUB/dMEpbmd/JN+9YPIZKec3epkEO0GtG1t3xU7mIK0Ut4ceqOCo3W+3wfTbVTE
         V+99yhIOYk2KQfwVixW5zvrJxfslP0Q2s/B2umtjpQptx9MdAOQQaFCh5bGx2ObS4wru
         ZoWo438kOfw5EREJj9VoouoFUK7G4lFuvc+W1jiA3uvrkHpuFnPOcj0v2l+DMDaodQ+B
         wTjA==
X-Gm-Message-State: APjAAAWuzpWxkAZo1OhCFSoqCyd4sNBClalYaKeMw4h40N2Gryf044ud
        CVgAgKkE2qAE1V/QUdu1FbiUAi6x
X-Google-Smtp-Source: APXvYqzHpcHY5S81RiEIaWLFYeUTsouwXef07xpko2l47941PkfC3UhnlwzAuciQy95Ru3ziHJoBhw==
X-Received: by 2002:a2e:8886:: with SMTP id k6mr1493650lji.43.1551853843528;
        Tue, 05 Mar 2019 22:30:43 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u29sm149715ljd.84.2019.03.05.22.30.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 22:30:42 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] Documentation: turn middle-of-line tabs into spaces
Date:   Wed,  6 Mar 2019 07:30:18 +0100
Message-Id: <4348f7b1b661181b90bf25f43c07529fa9757422.1551853194.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551853194.git.martin.agren@gmail.com>
References: <cover.1551853194.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tabs happen to appear in columns where they don't stand out too
much, so the diff here is non-obvious. Some of these are rendered
differently by AsciiDoc and Asciidoctor (although the difference might
be invisible!), which is how I found a few of them. The remainder were
found using `git grep "[a-zA-Z.,)]$TAB[a-zA-Z]"`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/config/diff.txt       | 2 +-
 Documentation/config/gc.txt         | 2 +-
 Documentation/config/gpg.txt        | 2 +-
 Documentation/git-config.txt        | 2 +-
 Documentation/git-grep.txt          | 2 +-
 Documentation/git-http-backend.txt  | 2 +-
 Documentation/git-ls-remote.txt     | 2 +-
 Documentation/git-notes.txt         | 2 +-
 Documentation/gitattributes.txt     | 2 +-
 Documentation/gitremote-helpers.txt | 2 +-
 Documentation/gitweb.conf.txt       | 2 +-
 Documentation/rev-list-options.txt  | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 7a1bae116a..2c4c9ba27a 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -73,7 +73,7 @@ diff.external::
 	environment variable.  The command is called with parameters
 	as described under "git Diffs" in linkgit:git[1].  Note: if
 	you want to use an external diff program only on a subset of
-	your files, you	might want to use linkgit:gitattributes[5] instead.
+	your files, you might want to use linkgit:gitattributes[5] instead.
 
 diff.ignoreSubmodules::
 	Sets the default value of --ignore-submodules. Note that this
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index c6fbb8a96f..73c08b0c00 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -19,7 +19,7 @@ gc.autoPackLimit::
 	When there are more than this many packs that are not
 	marked with `*.keep` file in the repository, `git gc
 	--auto` consolidates them into one larger pack.  The
-	default	value is 50.  Setting this to 0 disables it.
+	default value is 50.  Setting this to 0 disables it.
 
 gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 590fe0d4ba..f999f8ea49 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -16,5 +16,5 @@ gpg.format::
 gpg.<format>.program::
 	Use this to customize the program used for the signing format you
 	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
-	be used as a legacy synonym for	`gpg.openpgp.program`. The default
+	be used as a legacy synonym for `gpg.openpgp.program`. The default
 	value for `gpg.x509.program` is "gpgsm".
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 1bfe9f56a7..7d857f34c6 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -126,7 +126,7 @@ See also <<FILES>>.
 
 --local::
 	For writing options: write to the repository `.git/config` file.
-	This is	the default behavior.
+	This is the default behavior.
 +
 For reading options: read only from the repository `.git/config` rather than
 from all available files.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 84fe236a8e..2d27969057 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -88,7 +88,7 @@ OPTIONS
 	mechanism. Only useful with `--untracked`.
 
 --exclude-standard::
-	Do not pay attention to ignored files specified via the	`.gitignore`
+	Do not pay attention to ignored files specified via the `.gitignore`
 	mechanism.  Only useful when searching files in the current directory
 	with `--no-index`.
 
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index bb0db195ce..558966aa83 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -162,7 +162,7 @@ ScriptAliasMatch ^/git/[^/]*(.*) /usr/libexec/git-core/git-http-backend/storage.
 
 Accelerated static Apache 2.x::
 	Similar to the above, but Apache can be used to return static
-	files that are stored on disk.	On many systems this may
+	files that are stored on disk.  On many systems this may
 	be more efficient as Apache can ask the kernel to copy the
 	file contents from the file system directly to the network:
 +
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index b9fd3770a6..0b057cbb10 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -31,7 +31,7 @@ OPTIONS
 	displayed.
 
 --refs::
-	Do not show peeled tags or pseudorefs like HEAD	in the output.
+	Do not show peeled tags or pseudorefs like `HEAD` in the output.
 
 -q::
 --quiet::
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index df2b64dbb6..f56a5a9197 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -146,7 +146,7 @@ OPTIONS
 
 -C <object>::
 --reuse-message=<object>::
-	Take the given blob object (for	example, another note) as the
+	Take the given blob object (for example, another note) as the
 	note message. (Use `git notes copy <object>` instead to
 	copy notes between objects.)
 
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b8392fc330..c2c10eef7c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -18,7 +18,7 @@ A `gitattributes` file is a simple text file that gives
 
 Each line in `gitattributes` file is of form:
 
-	pattern	attr1 attr2 ...
+	pattern attr1 attr2 ...
 
 That is, a pattern followed by an attributes list,
 separated by whitespaces. Leading and trailing whitespaces are
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 9d1459aac6..4f2905dc5d 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -468,7 +468,7 @@ set by Git if the remote helper has the 'option' capability.
 
 'option dry-run' {'true'|'false'}:
 	If true, pretend the operation completed successfully,
-	but don't actually change any repository data.	For most
+	but don't actually change any repository data.  For most
 	helpers this only applies to the 'push', if supported.
 
 'option servpath <c-style-quoted-path>'::
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index c0a326e388..57e50b6911 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -536,7 +536,7 @@ $omit_owner::
 
 $per_request_config::
 	If this is set to code reference, it will be run once for each request.
-	You can	set parts of configuration that change per session this way.
+	You can set parts of configuration that change per session this way.
 	For example, one might use the following code in a gitweb configuration
 	file
 +
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bab5f50b17..918749b890 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -742,7 +742,7 @@ is supported, which omits all blobs and trees.
 
 --filter-print-omitted::
 	Only useful with `--filter=`; prints a list of the objects omitted
-	by the filter.	Object IDs are prefixed with a ``~'' character.
+	by the filter.  Object IDs are prefixed with a ``~'' character.
 
 --missing=<missing-action>::
 	A debug option to help with future "partial clone" development.
-- 
2.21.0

