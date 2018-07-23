Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2B71F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbeGWOyW (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:22 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44178 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388091AbeGWOyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:21 -0400
Received: by mail-pf1-f173.google.com with SMTP id k21-v6so108196pff.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KlMtgF1IH2oiPCp9ADDE1Am8iT3Etv6Hu1IZajDIE2U=;
        b=Fn2sQo8W6OUlSMff1hXRkIkA4jV0z1Jxiapg0v/eFNArhKRmWFgpmjUImQJi+S9quc
         G2RNpY8TbscQSrp0e3W97JmZxiWZaBjBivk3d+71P1QViIQ2iEXrHcc7OhnB5097pDXJ
         UsxTKCH2cXkVfWbCPnEF/Co3PVRZLktTWRgGATNzpwoXC5o5UMp9lutjUxaE/fppe+ys
         A3PdfDwpPHyz0G20NklLybRgag+UW5UIsTmVh16HACdBaZinWTI+haoFZt2B82M6321F
         kqlefBhRaQTKZd3GTIeWqXlWdpEsXnknwqy2KvLxEgVnAIUPUvB0NZedIju+i5PoOeq/
         Cz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KlMtgF1IH2oiPCp9ADDE1Am8iT3Etv6Hu1IZajDIE2U=;
        b=MrGUNh8DoTcOlrxvUTlhBTcTmJQNkLmMYd3uKIUzW/d3WfSCcH8l7iLQ3KWstcOtrN
         jcCLj57PTavzlgf8AHfz74Qy4cGA64HAKxgGYyonbIMTbidKmrd/bozwWYdh8MJR8EXb
         aanIMyQ2SP+COt8ha0QVYvaoNYSGRP8GEoUpA6+ZLGZTDvtBafA5a+ADq55g7AjBqIYD
         K8hs8twAIrQ8w6QIZEIlnGViyjFGN8bC03gjip6bgx7ouWwsC6g8Ng7gAV83KXwBq1CG
         eawkTdh+SWSS387f/n0T4eiUM4VwDbxmLv6AuFkEsUQZt+wc5FkN/69J3/VEHEiHRKmd
         /w4Q==
X-Gm-Message-State: AOUpUlHfCHDyI87HvNg0Ctz+m0p/iXFQPkVeJfutyztLU2ZUOp54Vkei
        /gHJHnKz1ETtSrpYRTbPkpFXIZ6h
X-Google-Smtp-Source: AAOMgpdcDk3bcJHfj2rywl6UzDhBK7JhTFzyn3d41VWSknVHavpf5RnU8qTRHyjd1YH14k6ZvubAjg==
X-Received: by 2002:a63:5d09:: with SMTP id r9-v6mr12250821pgb.303.1532353979527;
        Mon, 23 Jul 2018 06:52:59 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id q26-v6sm12564369pff.9.2018.07.23.06.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:52:58 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:52:58 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:44 GMT
Message-Id: <ce216cf431935a3e5fc00cd67090042578c32e65.1532353966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 8/9] vscode: add a dictionary for cSpell
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

