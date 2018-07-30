Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1731F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeG3RSc (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:18:32 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:33385 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeG3RSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:31 -0400
Received: by mail-pg1-f174.google.com with SMTP id r5-v6so7478979pgv.0
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KlMtgF1IH2oiPCp9ADDE1Am8iT3Etv6Hu1IZajDIE2U=;
        b=aQZkUC9JhS7nmntZnMA/EQAGlD9aWj9tNxerI92lqyGeWCIQgz/H2APbcqPy0L/411
         JtKN/RiJQJYPcaDzSlAJoWaS3pYl7nO92rW/7q7eaPrYPr9QtjpCY0oup6gPivX6I9s0
         nFclTBgOJIQM315OfDV2Q1DaMsknIOLUAp30YUZInLw2wXoBX5aZ1bBybEdjt/6DXg7I
         tfFaAShnPl8oCaUn3R0sMWvEL+rCJZzq8nxbprcaJ//Xdf8yQPYNCXDhf6bsB0T25Aog
         zVlOdJ2MI081xTNTGJdgVKrEDOHU/pBAG1VYWeWO/ASF0rOPNgnywgy4AzcIQGyHP0Hb
         UoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KlMtgF1IH2oiPCp9ADDE1Am8iT3Etv6Hu1IZajDIE2U=;
        b=uBZPC8UlS4t1cseI6cgMUhGWDzadlcTKknauMCWj+QFGFgTzGZCw7nxW/svKR6Fu6f
         9fzkpqo6ixMNZRgNDhUb4RYCru//dv8sDjLh9JSS6wDLfRO97P8kTJCZnJIiXYzGUayL
         t9yM5YMjMKnNuaaSURbv4yj/2C6MQEKYMeZ75tiWT5aRQ5BdHaO8bH3fmBSHlsYWwxpk
         vO/ANbstVHkC8v1JxT6TzE2+CIr4fnktBG+e6aYXPHxA7h6K2h/mjtuK0w3htl+v4ud7
         lPnfZ8YumPqw0hrI8DlqVXx2ytYrIez4bZTfbJZK9jTzx3AItUzemzggUcGmQHLwSLIM
         gdpA==
X-Gm-Message-State: AOUpUlGBxdTRYgOTnxvJiySdDHLoclvZxCNu5j/CoJR4ST5yb6UHYycK
        mSGw2l90ty0Dv8y+i250sdJXR1K5
X-Google-Smtp-Source: AAOMgpfubiFl0TpuDm9m+OmHuAW6XPo2Co3VwF6kJ4I95d9E+y76UbpdRn1hld2Ly76b9mnkHuaa9Q==
X-Received: by 2002:a63:1844:: with SMTP id 4-v6mr17206866pgy.313.1532965377900;
        Mon, 30 Jul 2018 08:42:57 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id r1-v6sm27352391pfi.17.2018.07.30.08.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:42:57 -0700 (PDT)
Date:   Mon, 30 Jul 2018 08:42:57 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 15:42:41 GMT
Message-Id: <358f38d3aa058bb9399f4a8fab71027e2e7a6289.1532965363.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.v2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
        <pull.2.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 8/9] vscode: add a dictionary for cSpell
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

The quite useful cSpell extension allows VS Code to have "squiggly"
lines under spelling mistakes. By default, this would add too much
clutter, though, because so much of Git's source code uses words that
would trigger cSpell.

Let's add a few words to make the spell checking more useful by reducing
the number of false positives.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/vscode/init.sh | 169 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 29f2a729d..a134cb4c5 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -32,7 +32,174 @@ cat >.vscode/settings.json.new <<\EOF ||
     "files.associations": {
         "*.h": "c",
         "*.c": "c"
-    }
+    },
+    "cSpell.words": [
+        "DATAW",
+        "DBCACHED",
+        "DFCHECK",
+        "DTYPE",
+        "Hamano",
+        "HCAST",
+        "HEXSZ",
+        "HKEY",
+        "HKLM",
+        "IFGITLINK",
+        "IFINVALID",
+        "ISBROKEN",
+        "ISGITLINK",
+        "ISSYMREF",
+        "Junio",
+        "LPDWORD",
+        "LPPROC",
+        "LPWSTR",
+        "MSVCRT",
+        "NOARG",
+        "NOCOMPLETE",
+        "NOINHERIT",
+        "RENORMALIZE",
+        "STARTF",
+        "STARTUPINFOEXW",
+        "Schindelin",
+        "UCRT",
+        "YESNO",
+        "argcp",
+        "beginthreadex",
+        "committish",
+        "contentp",
+        "cpath",
+        "cpidx",
+        "ctim",
+        "dequote",
+        "envw",
+        "ewah",
+        "fdata",
+        "fherr",
+        "fhin",
+        "fhout",
+        "fragp",
+        "fsmonitor",
+        "hnsec",
+        "idents",
+        "includeif",
+        "interpr",
+        "iprog",
+        "isexe",
+        "iskeychar",
+        "kompare",
+        "mksnpath",
+        "mktag",
+        "mktree",
+        "mmblob",
+        "mmbuffer",
+        "mmfile",
+        "noenv",
+        "nparents",
+        "ntpath",
+        "ondisk",
+        "ooid",
+        "oplen",
+        "osdl",
+        "pnew",
+        "pold",
+        "ppinfo",
+        "pushf",
+        "pushv",
+        "rawsz",
+        "rebasing",
+        "reencode",
+        "repo",
+        "rerere",
+        "scld",
+        "sharedrepo",
+        "spawnv",
+        "spawnve",
+        "spawnvpe",
+        "strdup'ing",
+        "submodule",
+        "submodules",
+        "topath",
+        "topo",
+        "tpatch",
+        "unexecutable",
+        "unhide",
+        "unkc",
+        "unkv",
+        "unmark",
+        "unmatch",
+        "unsets",
+        "unshown",
+        "untracked",
+        "untrackedcache",
+        "unuse",
+        "upos",
+        "uval",
+        "vreportf",
+        "wargs",
+        "wargv",
+        "wbuffer",
+        "wcmd",
+        "wcsnicmp",
+        "wcstoutfdup",
+        "wdeltaenv",
+        "wdir",
+        "wenv",
+        "wenvblk",
+        "wenvcmp",
+        "wenviron",
+        "wenvpos",
+        "wenvsz",
+        "wfile",
+        "wfilename",
+        "wfopen",
+        "wfreopen",
+        "wfullpath",
+        "which'll",
+        "wlink",
+        "wmain",
+        "wmkdir",
+        "wmktemp",
+        "wnewpath",
+        "wotype",
+        "wpath",
+        "wpathname",
+        "wpgmptr",
+        "wpnew",
+        "wpointer",
+        "wpold",
+        "wpos",
+        "wputenv",
+        "wrmdir",
+        "wship",
+        "wtarget",
+        "wtemplate",
+        "wunlink",
+        "xcalloc",
+        "xgetcwd",
+        "xmallocz",
+        "xmemdupz",
+        "xmmap",
+        "xopts",
+        "xrealloc",
+        "xsnprintf",
+        "xutftowcs",
+        "xutftowcsn",
+        "xwcstoutf"
+    ],
+    "cSpell.ignoreRegExpList": [
+        "\\\"(DIRC|FSMN|REUC|UNTR)\\\"",
+        "\\\\u[0-9a-fA-Fx]{4}\\b",
+        "\\b(filfre|frotz|xyzzy)\\b",
+        "\\bCMIT_FMT_DEFAULT\\b",
+        "\\bde-munge\\b",
+        "\\bGET_OID_DISAMBIGUATORS\\b",
+        "\\bHASH_RENORMALIZE\\b",
+        "\\bTREESAMEness\\b",
+        "\\bUSE_STDEV\\b",
+        "\\Wchar *\\*\\W*utfs\\W",
+        "cURL's",
+        "nedmalloc'ed",
+        "ntifs\\.h",
+    ],
 }
 EOF
 die "Could not write settings.json"
-- 
gitgitgadget

