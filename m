Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200621F51C
	for <e@80x24.org>; Thu, 10 May 2018 08:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756913AbeEJIrV (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38680 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756880AbeEJIrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id z142-v6so1829247lff.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdncJNw2Q+4jhqOnAX19boiVNPEQg7/xgWMjvavP8nI=;
        b=EHdcu0pcsKX1AQachF7ldXMA/7OtzBnWE33nMwEE+3djP9+wJ/iyUD8aomVXNHQJ0Q
         549n9sdTYsaalUD+LWd1GNCa5jRyrJhu7Uq2N18ia/+oG+x8JlUvhKOZ4YPKPfj4l8+Q
         zf2wBeLRTR1jlXj3XFgqae3SfRzG96xY5zF+75JHuRsSW3QkE7zH8nD/qo4SMtV9cl44
         wbHHOF1pbVYWY9YdA0zXfAzc0yiHCl6uuY3E29/FGSb0IQ2p86nxaElD5yuZ31ugEohN
         LoSFMhh2p3lOMfCnXQZSFgVNPLmWVkxhiYiKMxRaYp1va5iIwy3D3OR41WdsW4MAoUAB
         nyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdncJNw2Q+4jhqOnAX19boiVNPEQg7/xgWMjvavP8nI=;
        b=f8RKzIIiT58Two0w6PKz6l3jhrhdldmKlxfWjZzMOdQCboPy+f1CKPsecZ596LOa0a
         OJyx56/BB5E3fS9paLxYR3eF6w7zW/aCYMXxnIWvdir3TVj6cAT6uKnOEV0fnVZNLcX4
         vgGmJNqoNfIQm8z/BJsleVgpwVCGLszue/erK4JTpzo/zya7V9Pznpprpuu3DJ1CyW7q
         1UlD64iirEPiFugrCFZgfxsi0SuqUO2ikWBYR8f94zISLANUzHWKOfB4421ya096Ql7o
         QbGl4Coq/ctTyb6hrOVJSxqoNA/qmsu1W9xX97A3rNTCzXkh7bHXIzedePcLerd6chtX
         0LeA==
X-Gm-Message-State: ALKqPwck7r4jsiU55pdayAoTvB1PhjIjBkaij945uC9VcXESnGCeG/gq
        IHcd/3RbH4FYvC5CHl1Tiu1voA==
X-Google-Smtp-Source: AB8JxZr8bKLlCRob1rwhkgyIajBJ59vjxeItX3VxxV+Nx0YlYnggKPB8fc1hylUaLXnIk0Iq0yAOfw==
X-Received: by 2002:a2e:9706:: with SMTP id r6-v6mr475577lji.5.1525942031024;
        Thu, 10 May 2018 01:47:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 11/13] command-list.txt: documentation and guide line
Date:   Thu, 10 May 2018 10:46:50 +0200
Message-Id: <20180510084652.25880-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510084652.25880-1-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com>
 <20180510084652.25880-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is intended to help anybody who needs to update command-list.txt.
It gives a brief introduction of all attributes a command can take.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 command-list.txt | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/command-list.txt b/command-list.txt
index 99ddc231c1..9c70c69193 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,3 +1,47 @@
+# Command classification list
+# ---------------------------
+# All supported commands, builtin or external, must be described in
+# here. This info is used to list commands in various places. Each
+# command is on one line followed by one or more attributes.
+#
+# The first attribute group is mandatory and indicates the command
+# type. This group includes:
+#
+#   mainporcelain
+#   ancillarymanipulators
+#   ancillaryinterrogators
+#   foreignscminterface
+#   plumbingmanipulators
+#   plumbinginterrogators
+#   synchingrepositories
+#   synchelpers
+#   purehelpers
+#
+# The type names are self explanatory. But if you want to see what
+# command belongs to what group to get a better picture, have a look
+# at "git" man page, "GIT COMMANDS" section.
+#
+# Commands of type mainporcelain can also optionally have one of these
+# attributes:
+#
+#   init
+#   worktree
+#   info
+#   history
+#   remote
+#
+# These commands are considered "common" and will show up in "git
+# help" output in groups. Uncommon porcelain commands must not
+# specify any of these attributes.
+#
+# "complete" attribute is used to mark that the command should be
+# completable by git-completion.bash. Note that by default,
+# mainporcelain commands are completable so you don't need this
+# attribute.
+#
+# While not true commands, guides are also specified here, which can
+# only have "guide" attribute and nothing else.
+#
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
-- 
2.17.0.705.g3525833791

