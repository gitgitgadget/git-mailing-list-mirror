Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A991B1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 09:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfBOJ0q (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 04:26:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39102 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbfBOJ0o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 04:26:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so4674029pld.6
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 01:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7j6iNDDugy7n7zn3WqqOh6zjeI9jZ1cvihu4a5oM+N0=;
        b=AnciH5iIQCIbf3LWSFdh1n8+ms/hm07Z9K778qCHsDri/toCFULP3TE+Ga8BtUj7M8
         3UElqZrN5nwEGQOZwzMdURIA3WcXrLYOjI6o9ZvdycfsVv91Ec8VVJnX4gQ7FQZ7C9C1
         BuxJ4dPSgiNpdWGlYch71zk1mzuU/9qCcRZIWYke3MutD/Umewo4m+0AbpKzweyPexhQ
         1BQW4KWIxJDuXjuCJb5wZTQy9b6wM+NFc2nyYmB8H1DF7dfX5fzUc+6jYYL5KYyBIRlE
         DTjzmiizr2gtdHGvbDMecORqj2r437Y39kSvyhwkRM/KjYr8TUWdWqihbiyNyr60v41T
         bScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7j6iNDDugy7n7zn3WqqOh6zjeI9jZ1cvihu4a5oM+N0=;
        b=fBtkD11tOs315EkQPpreEcaVZJYwqLntkM7VUvFd7SYuLTduBV5spHyOfhm9o/1D6F
         Yu/dAjltcwxR7ej/vlDcwG0KW/ZHJ8PiCsqF5FCHdXqP3EyCPuvMeO2MDwrm/Tl5DXL1
         Lf3BpctW6b8aEsa8vX6EKVPwaPbDKVgXKjS2AUVjpn6qpDmFRNydVykR0jZM3Hh3lruw
         veEGJ4fffTumHcjOSUTw8Sgog2gAzquaprYxGclX68MgPxAtM5I/CNo6XEi1wnvRHSvr
         JFRncpamQCSWANlpD4eS7tDNFzY0uhGQ2p3atx4pHyBvTL5dR71JyT8GjmazF+eHLP+e
         213Q==
X-Gm-Message-State: AHQUAuZWBewO11PDrTMsiTS3HHpqsHyuiOZ2krhCJQABSVZTYcR4EtEu
        0J79Cl9hCQWroRNMEUp0LOPD5H9F
X-Google-Smtp-Source: AHgI3IYKApPcGgXZLLuhEp2IzoEk3Zs8h81kq2E7XM/K/0QIrSdAQ7LN0MwIwgGxx/6exlp3ZvSZpA==
X-Received: by 2002:a17:902:2966:: with SMTP id g93mr8952359plb.11.1550222803281;
        Fri, 15 Feb 2019 01:26:43 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id z186sm6754757pfz.119.2019.02.15.01.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 01:26:42 -0800 (PST)
Date:   Fri, 15 Feb 2019 01:26:41 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 1/1] submodule: document default behavior
Message-ID: <bc9088f23c0e9d4feedf9b2cc47cf6e6c34cefb2.1550222580.git.liu.denton@gmail.com>
References: <cover.1549965172.git.liu.denton@gmail.com>
 <cover.1550222580.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550222580.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

submodule's default behavior wasn't documented in both git-submodule.txt
and in the usage text of git-submodule. Document the default behavior
similar to how git-remote does it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-submodule.txt | 4 ++++
 git-submodule.sh                | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df550..2794e29780 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,6 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
+'git submodule' [--quiet] [--cached]
 'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
@@ -28,6 +29,9 @@ For more information about submodules, see linkgit:gitsubmodules[7].
 
 COMMANDS
 --------
+With no arguments, shows the status of existing submodules.  Several
+subcommands are available to perform operations on the submodules.
+
 add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..1ccc758e79 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,8 @@
 # Copyright (c) 2007 Lars Hjemli
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] [--cached]
+   or: $dashless [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-- 
2.20.1.522.gd8785cdd01

