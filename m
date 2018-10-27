Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2721F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeJ0PEr (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43720 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeJ0PEr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id g26-v6so1844419lja.10
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/Im3mJ33mbbS7npXAvUaG1c6jlFf6OXyOQJBNvPaIE=;
        b=nGRH6zNQtVX5ANhstsMKXlZqu/EVwOBkxm5jRcZDJYmbjGEqtGdMYitJkgvKXwFfVc
         fVFWopf6AVPY4jdJ/I2IqXjBumTQx+e1ofb3eheMLIPNylwk7+8a4s+forni1CG/nDa9
         WU+uI938KjFH9jm3zAUzEKOfdzHGXhkwUTnHxMo1kqJfq6c1Bhzu9JGcNjYC44Z/1ZLO
         bFV4wzZVEwNudE/P/d9zPkWvaGgPe/WTQiMxo9x6BNzMSAAq2zwXSxvCS3Yh2xhS/4Mp
         Jg+7VVaql0jVUuq6tPccoktZZBwDV88ylgCT9sYP+rI4BcRC80fKD4P8wbIsuBsiPcvL
         vYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/Im3mJ33mbbS7npXAvUaG1c6jlFf6OXyOQJBNvPaIE=;
        b=jqUe9XTUZGbHIazR5IT9x7LzMdoq4534Uv3h0rQu1fkEAQRKywt+lYwH39ivQvkA2p
         /K3KO8JoSKMzrYiIIYLnp183lJhWT9xm/SFrKsezA4NCoEg9KP4wAMdI2nUIIsLH8dWD
         1M/hALXKur1COchhp46HCE2/hGeavo5ETR6I7AT8doc1MSO8EzUl9XomlT3PYfxYBBNO
         3Ntjlx91n0zdcG9gU5ff6jJOQ7yeFeu2VLe0QECASl0w1RGeKzBVNS+zOEHT8AorFzcM
         TIy8A6HJ2o28tdSUAmt+YArQg+aoLJ2NyYcpzBOxrsE3gsO6NZf0iF8lGm8Qh4I+292C
         7r6A==
X-Gm-Message-State: AGRZ1gLN+WjPtgDCzO0nVq355Plft4JnLv/49IvZb3epPrzbvBS7rpt2
        byy8IE1tPz2QPIKPTFh7CR+BSIVE
X-Google-Smtp-Source: AJdET5dSl5tuZXe0WcffDEoggniFv0fjyT9FjTE3nckCp256G2CzUYvdnbd/8npjj50de0002XdCVA==
X-Received: by 2002:a2e:9615:: with SMTP id v21-v6mr4144077ljh.150.1540621490920;
        Fri, 26 Oct 2018 23:24:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 47/78] config.txt: move mergetool.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:20 +0200
Message-Id: <20181027062351.30446-48-pclouds@gmail.com>
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
 Documentation/config.txt           | 54 +-----------------------------
 Documentation/config/mergetool.txt | 53 +++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/config/mergetool.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 441787e815..35a6b4e0e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -373,59 +373,7 @@ include::config/man.txt[]
 
 include::config/merge.txt[]
 
-mergetool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
-
-mergetool.<tool>.cmd::
-	Specify the command to invoke the specified merge tool.  The
-	specified command is evaluated in shell with the following
-	variables available: 'BASE' is the name of a temporary file
-	containing the common base of the files to be merged, if available;
-	'LOCAL' is the name of a temporary file containing the contents of
-	the file on the current branch; 'REMOTE' is the name of a temporary
-	file containing the contents of the file from the branch being
-	merged; 'MERGED' contains the name of the file to which the merge
-	tool should write the results of a successful merge.
-
-mergetool.<tool>.trustExitCode::
-	For a custom merge command, specify whether the exit code of
-	the merge command can be used to determine whether the merge was
-	successful.  If this is not set to true then the merge target file
-	timestamp is checked and the merge assumed to have been successful
-	if the file has been updated, otherwise the user is prompted to
-	indicate the success of the merge.
-
-mergetool.meld.hasOutput::
-	Older versions of `meld` do not support the `--output` option.
-	Git will attempt to detect whether `meld` supports `--output`
-	by inspecting the output of `meld --help`.  Configuring
-	`mergetool.meld.hasOutput` will make Git skip these checks and
-	use the configured value instead.  Setting `mergetool.meld.hasOutput`
-	to `true` tells Git to unconditionally use the `--output` option,
-	and `false` avoids using `--output`.
-
-mergetool.keepBackup::
-	After performing a merge, the original file with conflict markers
-	can be saved as a file with a `.orig` extension.  If this variable
-	is set to `false` then this file is not preserved.  Defaults to
-	`true` (i.e. keep the backup files).
-
-mergetool.keepTemporaries::
-	When invoking a custom merge tool, Git uses a set of temporary
-	files to pass to the tool. If the tool returns an error and this
-	variable is set to `true`, then these temporary files will be
-	preserved, otherwise they will be removed after the tool has
-	exited. Defaults to `false`.
-
-mergetool.writeToTemp::
-	Git writes temporary 'BASE', 'LOCAL', and 'REMOTE' versions of
-	conflicting files in the worktree by default.  Git will attempt
-	to use a temporary directory for these files when set `true`.
-	Defaults to `false`.
-
-mergetool.prompt::
-	Prompt before each invocation of the merge resolution program.
+include::config/mergetool.txt[]
 
 notes.mergeStrategy::
 	Which merge strategy to choose by default when resolving notes
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
new file mode 100644
index 0000000000..09ed31dbfa
--- /dev/null
+++ b/Documentation/config/mergetool.txt
@@ -0,0 +1,53 @@
+mergetool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
+mergetool.<tool>.cmd::
+	Specify the command to invoke the specified merge tool.  The
+	specified command is evaluated in shell with the following
+	variables available: 'BASE' is the name of a temporary file
+	containing the common base of the files to be merged, if available;
+	'LOCAL' is the name of a temporary file containing the contents of
+	the file on the current branch; 'REMOTE' is the name of a temporary
+	file containing the contents of the file from the branch being
+	merged; 'MERGED' contains the name of the file to which the merge
+	tool should write the results of a successful merge.
+
+mergetool.<tool>.trustExitCode::
+	For a custom merge command, specify whether the exit code of
+	the merge command can be used to determine whether the merge was
+	successful.  If this is not set to true then the merge target file
+	timestamp is checked and the merge assumed to have been successful
+	if the file has been updated, otherwise the user is prompted to
+	indicate the success of the merge.
+
+mergetool.meld.hasOutput::
+	Older versions of `meld` do not support the `--output` option.
+	Git will attempt to detect whether `meld` supports `--output`
+	by inspecting the output of `meld --help`.  Configuring
+	`mergetool.meld.hasOutput` will make Git skip these checks and
+	use the configured value instead.  Setting `mergetool.meld.hasOutput`
+	to `true` tells Git to unconditionally use the `--output` option,
+	and `false` avoids using `--output`.
+
+mergetool.keepBackup::
+	After performing a merge, the original file with conflict markers
+	can be saved as a file with a `.orig` extension.  If this variable
+	is set to `false` then this file is not preserved.  Defaults to
+	`true` (i.e. keep the backup files).
+
+mergetool.keepTemporaries::
+	When invoking a custom merge tool, Git uses a set of temporary
+	files to pass to the tool. If the tool returns an error and this
+	variable is set to `true`, then these temporary files will be
+	preserved, otherwise they will be removed after the tool has
+	exited. Defaults to `false`.
+
+mergetool.writeToTemp::
+	Git writes temporary 'BASE', 'LOCAL', and 'REMOTE' versions of
+	conflicting files in the worktree by default.  Git will attempt
+	to use a temporary directory for these files when set `true`.
+	Defaults to `false`.
+
+mergetool.prompt::
+	Prompt before each invocation of the merge resolution program.
-- 
2.19.1.647.g708186aaf9

