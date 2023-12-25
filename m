Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9F53E04
	for <git@vger.kernel.org>; Mon, 25 Dec 2023 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9r0Ib95"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d31116dbeso48735695e9.3
        for <git@vger.kernel.org>; Mon, 25 Dec 2023 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703539291; x=1704144091; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJZZ4c85vj0uLFt67mpASO29sOd/3z6AK05WEXuAWvY=;
        b=M9r0Ib9546DjhrOBRbrxHfqJfxMeqex1fJPG3PCvHg275dXUHXYLR+3z2XgfHyRKye
         gaU9ioABwCFhKisIsPl8n8ehnqXWopriGGptHwJSGwhxVd4Y0BFlIJzRdX/YBOW2K2Dp
         XdumUz3YW6pLhbtTjUTbAOltK5sqD1izCD3Uq9c19ORZkbENEQ1ZkGVwJo0+s0g0JhjZ
         YgnJg3RLjgLEDT7ScJrgaTvj6LRhYItVPuC8WGqXuAVFSyRMWkSKxAlajUJIlDVAdGEM
         7B4be5f+9H1ABMWWFmi5Q9jCb41ZCoBkiAAx+PbqegjF696c1JAmA2XP2A0qUT0Wa5Nj
         w1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703539291; x=1704144091;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJZZ4c85vj0uLFt67mpASO29sOd/3z6AK05WEXuAWvY=;
        b=IANSjynm/crbiQ/rpPCWwbZ7OjYMWOBGkASdfG84FvM4TgBXZ1PMCHG150qP2VIGXJ
         S65aidjOxMLh2OsdPbqv6d3xKvtqLDiEFrBJJNCJKoHN2ZKfCgHp8c0aLRkbZ2hhlZPV
         7DX0IGnAG16/UzrWTZ1JR/hO5pP2SPnfewJGEUAJk5uxb8N3tJYYBjuhgPBDW8k+9qPO
         RxWSo0UpesMTUcdR3Ll5lvo0/FNzo+LTjTU0dqq/e8KHSlClMt3yDQEZ1q9pj8GWXVKb
         QWpP0roeV3ovc5gp52jFKlzdQag2cemIUUjop+55dkuBhVR9x6BwCQkpqiGD1hajfvB/
         r95Q==
X-Gm-Message-State: AOJu0YwIxN+jA76+HM4c0cHEobwxaYPtquw+z+0UCZ4BUiI/0SQ1jyHj
	6UCjOk3DHAr6atV6Cvm6A5y5Ic1j/a0=
X-Google-Smtp-Source: AGHT+IEe/cHmTYw8JeJrD4qDeY4JvvR2YAiMkP4TlcO/OqCk6U2XkLdsbSAtlPouG+EgmEn3SSeoGQ==
X-Received: by 2002:a05:600c:4593:b0:40d:3fee:97fa with SMTP id r19-20020a05600c459300b0040d3fee97famr3269063wmo.33.1703539290813;
        Mon, 25 Dec 2023 13:21:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040d56075463sm5114894wmq.44.2023.12.25.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 13:21:30 -0800 (PST)
Message-ID: <e928f273c2a26310d8bf77a075207c15626766dd.1703539288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1626.git.1703539287.gitgitgadget@gmail.com>
References: <pull.1626.git.1703539287.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Dec 2023 21:21:27 +0000
Subject: [PATCH 2/2] doc: enforce placeholders in documentation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Any string that is not meant to be used verbatim in the documentation
should be marked as a placeholder.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-options.txt | 2 +-
 Documentation/git-config.txt   | 8 ++++----
 Documentation/git-daemon.txt   | 4 ++--
 Documentation/git-difftool.txt | 2 +-
 Documentation/git.txt          | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 53ec3c9a347..aaaff0d46f0 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -299,7 +299,7 @@ and accumulating child directory counts in the parent directories:
 	Synonym for --dirstat=cumulative
 
 --dirstat-by-file[=<param1,param2>...]::
-	Synonym for --dirstat=files,param1,param2...
+	Synonym for --dirstat=files,<param1>,<param2>...
 
 --summary::
 	Output a condensed summary of extended header information
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index b1caac887ae..dff39093b5e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -103,11 +103,11 @@ OPTIONS
 	names are not.
 
 --get-urlmatch <name> <URL>::
-	When given a two-part name section.key, the value for
-	section.<URL>.key whose <URL> part matches the best to the
+	When given a two-part <name> as <section>.<key>, the value for
+	<section>.<URL>.<key> whose <URL> part matches the best to the
 	given URL is returned (if no such key exists, the value for
-	section.key is used as a fallback).  When given just the
-	section as name, do so for all the keys in the section and
+	<section>.<key> is used as a fallback).  When given just the
+	<section> as name, do so for all the keys in the section and
 	list them.  Returns error code 1 if no value is found.
 
 --global::
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 6ab792228a1..ede7b935d64 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -141,8 +141,8 @@ otherwise `stderr`.
 	specified with no parameter, a request to
 	git://host/{tilde}alice/foo is taken as a request to access
 	'foo' repository in the home directory of user `alice`.
-	If `--user-path=path` is specified, the same request is
-	taken as a request to access `path/foo` repository in
+	If `--user-path=<path>` is specified, the same request is
+	taken as a request to access `<path>/foo` repository in
 	the home directory of user `alice`.
 
 --verbose::
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 50cb080085e..c05f97aca96 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -90,7 +90,7 @@ instead.  `--no-symlinks` is the default on Windows.
 --extcmd=<command>::
 	Specify a custom command for viewing diffs.
 	'git-difftool' ignores the configured defaults and runs
-	`$command $LOCAL $REMOTE` when this option is specified.
+	`<command> $LOCAL $REMOTE` when this option is specified.
 	Additionally, `$BASE` is set in the environment.
 
 -g::
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d51473a3274..8d565142024 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -202,7 +202,7 @@ If you just want to run git as if it was started in `<path>` then use
 	Do not perform optional operations that require locks. This is
 	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
 
---list-cmds=group[,group...]::
+--list-cmds=<group>[,<group>...]::
 	List commands by group. This is an internal/experimental
 	option and may change or be removed in the future. Supported
 	groups are: builtins, parseopt (builtin commands that use
-- 
gitgitgadget
