Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4761F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeG3RS1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40371 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeG3RS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so7470895pgp.7
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9bFd3gjeCIItAqEuYT/FWKUIK7J3MNEz+NnVCjblLKA=;
        b=dewFeDl169QLwC/I77N5TcY56loGdcmpNZUbwqlLudWp+jyYEGFVmY590gZUeHzUsk
         /timZ8RWho4wNgZFvsk6UfrOwUspfh9gXk785cSWccPWug5bdA6u9ft6SCuaHB0qgRHX
         PJp3XOiWhyL8KPoBqCpOSb7RTGPGD+1HR7LEMONMpS4B3VTNyGaNuLMUEuYGFe34D8jp
         dX9DCICNGTqekVA4K/d2TcR1Hv6vYkLM7iAXJl4DB+R0JSE5wy9CPzTzcrLwuna5cZ8c
         hfJFhtfF+z2qcZwf8F500pCOxPmu147zbG8UcFSN3aeWdktps/TYvXg9aYWInPDPgglD
         5LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9bFd3gjeCIItAqEuYT/FWKUIK7J3MNEz+NnVCjblLKA=;
        b=cJrirVlcAibkOihIl4U1NyvyZi69hhC3bEdP6/J7QhAWwyZXgnMWNJB2Sy5s5xfDjm
         xUwhN/TAv7CKg/gr3enJBf8bsbd0QFn12O5Evb3//7eMDIpfDLCAIWqw5Ms/11IadobC
         SVz2L5UAX3vD9qbkGXwdAYasksgQxreDkBUVQBtbiX6BDjTQB3dCm/bbV2zAhLgy2CiX
         msrA8oeXtScD9DY79BCOxBVR2qxKRjYmA7bRWocTA1L2WPYbfAkcP2GwpEjL/3WlkWIg
         GpR05TSOHth8TsGX8ynnJxwtrEprT6w3//3V4Hl733QcI5ZCbuZnY2cwWlD6KQhN6r05
         SmOA==
X-Gm-Message-State: AOUpUlEjjmX1mmvHaSevSRHThN/XvJlT1OFESN8iYrfVu3R230XWj2KO
        tfIb607wLKqysNOPqkX8tWs4hNt/
X-Google-Smtp-Source: AAOMgpfrvFuPFuu9D6GIcpo3laBBF/75NMPLjA/PFG/695Gu32gTciS58gQvD/OYTNL0p8OWDu6c9g==
X-Received: by 2002:a62:9f1d:: with SMTP id g29-v6mr18054989pfe.207.1532965373547;
        Mon, 30 Jul 2018 08:42:53 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id t1-v6sm13353403pgp.32.2018.07.30.08.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:52 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:52 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:38 GMT
Message-Id: <3dd53c04c4e10d0ec8ce2e6b04558824ab61eb67.1532965363.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.v2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
        <pull.2.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/9] vscode: only overwrite C/C++ settings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The C/C++ settings are special, as they are the only generated VS Code
configurations that *will* change over the course of Git's development,
e.g. when a new constant is defined.

Therefore, let's only update the C/C++ settings, also to prevent user
modifications from being overwritten.

Ideally, we would keep user modifications in the C/C++ settings, but
that would require parsing JSON, a task for which a Unix shell script is
distinctly unsuited. So we write out .new files instead, and warn the
user if they may want to reconcile their changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/vscode/init.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 494a51ac5..ba9469226 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -13,7 +13,7 @@ die "Could not create .vscode/"
 
 # General settings
 
-cat >.vscode/settings.json <<\EOF ||
+cat >.vscode/settings.json.new <<\EOF ||
 {
     "C_Cpp.intelliSenseEngine": "Default",
     "C_Cpp.intelliSenseEngineFallback": "Disabled",
@@ -51,7 +51,7 @@ esac
 
 # Default build task
 
-cat >.vscode/tasks.json <<EOF ||
+cat >.vscode/tasks.json.new <<EOF ||
 {
     // See https://go.microsoft.com/fwlink/?LinkId=733558
     // for the documentation about the tasks.json format
@@ -73,7 +73,7 @@ die "Could not install default build task"
 
 # Debugger settings
 
-cat >.vscode/launch.json <<EOF ||
+cat >.vscode/launch.json.new <<EOF ||
 {
     // Use IntelliSense to learn about possible attributes.
     // Hover to view descriptions of existing attributes.
@@ -175,3 +175,20 @@ vscode-init:
 	echo '}'
 EOF
 die "Could not write settings for the C/C++ extension"
+
+for file in .vscode/settings.json .vscode/tasks.json .vscode/launch.json
+do
+	if test -f $file
+	then
+		if git diff --no-index --quiet --exit-code $file $file.new
+		then
+			rm $file.new
+		else
+			printf "The file $file.new has these changes:\n\n"
+			git --no-pager diff --no-index $file $file.new
+			printf "\n\nMaybe \`mv $file.new $file\`?\n\n"
+		fi
+	else
+		mv $file.new $file
+	fi
+done
-- 
gitgitgadget

