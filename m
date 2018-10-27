Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB161F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeJ0PE7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33346 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbeJ0PE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so3126917ljz.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4d6YDHFBfDMFi+TZDIrT97tJmdS5fZm/ztrqyBCqdTw=;
        b=qF+ArwBX7d+JeO28j2ITkE4BQYQnTu6/eqGW8G43imlTxy/Gy6eXgwkr3lsMZQUehK
         146A0qxe0b0k3OkAhTNoUby+O+7+jZdGVzO7TV+FsJB2CVePHAC7oboDHcfIfSIBw6cm
         4jEvC5aQnZjwHTHo8VwUdd0yToSBpz2p8bLGagcTYh86tuqhDf6gi8BYZ9UWJN2gYl0/
         bRMcdaQgbyOWJiSTdbadAnos0LAiyfKOESBz/MvwTIa1ex1fA5a8EjwD9Gx63zWEQbi7
         9mLBPJ3XEpSyZyhSkJFKDCdz8suJVvrZ08vN7AwmGpFrdrpvAN1WNGeVE+fcE4GoK4Jy
         3w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4d6YDHFBfDMFi+TZDIrT97tJmdS5fZm/ztrqyBCqdTw=;
        b=nK0BPuXRqKAjqWHOAORcatXx9CB1faWGsxYZkh7CIljTMolhg0TIc/yPA11By3P0zT
         KmwxgSazUQqxktfheRTRYZubEYtO5ibt20o5D3Ex1/VsMSf8UXoO+JXS6YRDzO4Fob6h
         YX3C9fT7YvDoz2ohxYtH2E0kuNd1dTDq1cImOYu8YNBFG/vbUvddgIPCbEZ1gjTB8Vig
         7tHVlo1A5SkyoFQsjFdFSVgtztacGhiWfQqg7GhX9CrT0Omu+vTb+kFTwxDgbyvxTWMy
         2l6rKQRUlCNIHAvZTh3tdMgkIA0qZCt9jU71pOA/rv/OcaCUdB5KZRyBm3gmK3PJOWuK
         Iilg==
X-Gm-Message-State: AGRZ1gKzc9Fr+sPZyz3hEbvW0yE5V48C2cQFq7oQ9GyEzcIsJTx0ONrq
        CW+XeZU07Dqb36ERa6J6Wy6zob8P
X-Google-Smtp-Source: AJdET5eblEd2GW/WI7INSpSFB8t+m0bPdcQnBmZd+EL8MxCBGlxEs57BTzjdmpj05/yEEHL7/M4jMA==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr4566634ljh.0.1540621501617;
        Fri, 26 Oct 2018 23:25:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 57/78] config.txt: move remote.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:30 +0200
Message-Id: <20181027062351.30446-58-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt        | 79 +--------------------------------
 Documentation/config/remote.txt | 78 ++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/config/remote.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 465dc2abec..b7aafdbf17 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -393,84 +393,7 @@ include::config/rebase.txt[]
 
 include::config/receive.txt[]
 
-remote.pushDefault::
-	The remote to push to by default.  Overrides
-	`branch.<name>.remote` for all branches, and is overridden by
-	`branch.<name>.pushRemote` for specific branches.
-
-remote.<name>.url::
-	The URL of a remote repository.  See linkgit:git-fetch[1] or
-	linkgit:git-push[1].
-
-remote.<name>.pushurl::
-	The push URL of a remote repository.  See linkgit:git-push[1].
-
-remote.<name>.proxy::
-	For remotes that require curl (http, https and ftp), the URL to
-	the proxy to use for that remote.  Set to the empty string to
-	disable proxying for that remote.
-
-remote.<name>.proxyAuthMethod::
-	For remotes that require curl (http, https and ftp), the method to use for
-	authenticating against the proxy in use (probably set in
-	`remote.<name>.proxy`). See `http.proxyAuthMethod`.
-
-remote.<name>.fetch::
-	The default set of "refspec" for linkgit:git-fetch[1]. See
-	linkgit:git-fetch[1].
-
-remote.<name>.push::
-	The default set of "refspec" for linkgit:git-push[1]. See
-	linkgit:git-push[1].
-
-remote.<name>.mirror::
-	If true, pushing to this remote will automatically behave
-	as if the `--mirror` option was given on the command line.
-
-remote.<name>.skipDefaultUpdate::
-	If true, this remote will be skipped by default when updating
-	using linkgit:git-fetch[1] or the `update` subcommand of
-	linkgit:git-remote[1].
-
-remote.<name>.skipFetchAll::
-	If true, this remote will be skipped by default when updating
-	using linkgit:git-fetch[1] or the `update` subcommand of
-	linkgit:git-remote[1].
-
-remote.<name>.receivepack::
-	The default program to execute on the remote side when pushing.  See
-	option --receive-pack of linkgit:git-push[1].
-
-remote.<name>.uploadpack::
-	The default program to execute on the remote side when fetching.  See
-	option --upload-pack of linkgit:git-fetch-pack[1].
-
-remote.<name>.tagOpt::
-	Setting this value to --no-tags disables automatic tag following when
-	fetching from remote <name>. Setting it to --tags will fetch every
-	tag from remote <name>, even if they are not reachable from remote
-	branch heads. Passing these flags directly to linkgit:git-fetch[1] can
-	override this setting. See options --tags and --no-tags of
-	linkgit:git-fetch[1].
-
-remote.<name>.vcs::
-	Setting this to a value <vcs> will cause Git to interact with
-	the remote with the git-remote-<vcs> helper.
-
-remote.<name>.prune::
-	When set to true, fetching from this remote by default will also
-	remove any remote-tracking references that no longer exist on the
-	remote (as if the `--prune` option was given on the command line).
-	Overrides `fetch.prune` settings, if any.
-
-remote.<name>.pruneTags::
-	When set to true, fetching from this remote by default will also
-	remove any local tags that no longer exist on the remote if pruning
-	is activated in general via `remote.<name>.prune`, `fetch.prune` or
-	`--prune`. Overrides `fetch.pruneTags` settings, if any.
-+
-See also `remote.<name>.prune` and the PRUNING section of
-linkgit:git-fetch[1].
+include::config/remote.txt[]
 
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
new file mode 100644
index 0000000000..6c4cad83a2
--- /dev/null
+++ b/Documentation/config/remote.txt
@@ -0,0 +1,78 @@
+remote.pushDefault::
+	The remote to push to by default.  Overrides
+	`branch.<name>.remote` for all branches, and is overridden by
+	`branch.<name>.pushRemote` for specific branches.
+
+remote.<name>.url::
+	The URL of a remote repository.  See linkgit:git-fetch[1] or
+	linkgit:git-push[1].
+
+remote.<name>.pushurl::
+	The push URL of a remote repository.  See linkgit:git-push[1].
+
+remote.<name>.proxy::
+	For remotes that require curl (http, https and ftp), the URL to
+	the proxy to use for that remote.  Set to the empty string to
+	disable proxying for that remote.
+
+remote.<name>.proxyAuthMethod::
+	For remotes that require curl (http, https and ftp), the method to use for
+	authenticating against the proxy in use (probably set in
+	`remote.<name>.proxy`). See `http.proxyAuthMethod`.
+
+remote.<name>.fetch::
+	The default set of "refspec" for linkgit:git-fetch[1]. See
+	linkgit:git-fetch[1].
+
+remote.<name>.push::
+	The default set of "refspec" for linkgit:git-push[1]. See
+	linkgit:git-push[1].
+
+remote.<name>.mirror::
+	If true, pushing to this remote will automatically behave
+	as if the `--mirror` option was given on the command line.
+
+remote.<name>.skipDefaultUpdate::
+	If true, this remote will be skipped by default when updating
+	using linkgit:git-fetch[1] or the `update` subcommand of
+	linkgit:git-remote[1].
+
+remote.<name>.skipFetchAll::
+	If true, this remote will be skipped by default when updating
+	using linkgit:git-fetch[1] or the `update` subcommand of
+	linkgit:git-remote[1].
+
+remote.<name>.receivepack::
+	The default program to execute on the remote side when pushing.  See
+	option --receive-pack of linkgit:git-push[1].
+
+remote.<name>.uploadpack::
+	The default program to execute on the remote side when fetching.  See
+	option --upload-pack of linkgit:git-fetch-pack[1].
+
+remote.<name>.tagOpt::
+	Setting this value to --no-tags disables automatic tag following when
+	fetching from remote <name>. Setting it to --tags will fetch every
+	tag from remote <name>, even if they are not reachable from remote
+	branch heads. Passing these flags directly to linkgit:git-fetch[1] can
+	override this setting. See options --tags and --no-tags of
+	linkgit:git-fetch[1].
+
+remote.<name>.vcs::
+	Setting this to a value <vcs> will cause Git to interact with
+	the remote with the git-remote-<vcs> helper.
+
+remote.<name>.prune::
+	When set to true, fetching from this remote by default will also
+	remove any remote-tracking references that no longer exist on the
+	remote (as if the `--prune` option was given on the command line).
+	Overrides `fetch.prune` settings, if any.
+
+remote.<name>.pruneTags::
+	When set to true, fetching from this remote by default will also
+	remove any local tags that no longer exist on the remote if pruning
+	is activated in general via `remote.<name>.prune`, `fetch.prune` or
+	`--prune`. Overrides `fetch.pruneTags` settings, if any.
++
+See also `remote.<name>.prune` and the PRUNING section of
+linkgit:git-fetch[1].
-- 
2.19.1.647.g708186aaf9

