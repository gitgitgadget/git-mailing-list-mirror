Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755001F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeJWTPo (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 15:15:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45065 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWTPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 15:15:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so450877pfn.12
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J7BH/QTwkI9bmnE2nubon2dQyP2VBA1SynJTWbqdaoY=;
        b=Wh5tPL1rTefxtittrqta5jAqw/IosK2F8T3id+C6y7HHTqbd+EmWD8NerrPgHJF8jl
         VqKcbZ5OWc3rS83Imfj6RtBRdsFnZnA0NimJZH9NkASADSEtWWdY38rvU666kgk+kElc
         +aVEk4jBkK0x5OUmZ9U487ckGF6yXZsoCueqKNBYxMmO+Pa2AYCcTuiupf3bZly10cC/
         W8jJXkwggHktRWZ1GGSOZnryYCa8DFW3i9R9W+/OO5QvSG0PFD04pGlzYMuc2PQ6SfRN
         PBdVl4bw3T4OdX4B2FGNl6ITCRr4ZC04V5l+PmqjEKP3ZEcpab+BvE4aPyiNl1EH9fma
         +4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J7BH/QTwkI9bmnE2nubon2dQyP2VBA1SynJTWbqdaoY=;
        b=dBiG24EJskH3iJtqSt5RcUP3jdZCBLcWCJKTrIh1dymPMyBfQpx549CXAT4EqfgUhD
         RiRpi5Sg8EwZEPZdzbSO6UzaIQFNERrvdRIxcmPbbwpuWwRqp0Xy3/A/fRZFAdO09Jy9
         GVhYWIu5WyOpnzxtLEHwOrAwWtFqcMjsGMsN2hPfpxupLLNx3VPaolE2Pj0EArGQ95zo
         s7iQQHyV+JDFKfzZgQkq5EL4jREnnhNfF1uFjWW8Ev9KxQEfAzKotB0YPfCP+tvjmpgq
         lRBxSyybGaQpeQNrGUXHuVu9w8+p7Fy+Yh8C4Rrnb+lDGIrROv/F7s5tYxRyVv+BKEAz
         rIZQ==
X-Gm-Message-State: ABuFfohTxdRG30P2x95qhU5gK9z8IoACfWqi2/O84VOk6A53cca27Jhw
        oOVMfFY982Aztch6N6utnyEDNBae
X-Google-Smtp-Source: ACcGV61C9t9srdx/vgZFjU0U73ThlVvj4lI8aJKml3Xv71W5cLi5RaX9kWdxbUkaeH53tJfN8E91XQ==
X-Received: by 2002:a63:1411:: with SMTP id u17-v6mr45384711pgl.247.1540291969134;
        Tue, 23 Oct 2018 03:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id w63-v6sm1534537pgw.60.2018.10.23.03.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:52:48 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:52:48 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 10:52:44 GMT
Message-Id: <e13ae233822c8e4a4504e3294adf3e0de38a1990.1540291965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.54.git.gitgitgadget@gmail.com>
References: <pull.54.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] mingw: ensure `getcwd()` reports the correct case
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

When switching the current working directory, say, in PowerShell, it is
quite possible to use a different capitalization than the one that is
recorded on disk. While doing the same in `cmd.exe` adjusts the
capitalization magically, that does not happen in PowerShell so that
`getcwd()` returns the current directory in a different way than is
recorded on disk.

Typically this creates no problems except when you call

	git log .

in a subdirectory called, say, "GIT/" but you switched to "Git/" and
your `getcwd()` reports the latter, then Git won't understand that you
wanted to see the history as per the `GIT/` subdirectory but it thinks you
wanted to see the history of some directory that may have existed in the
past (but actually never did).

So let's be extra careful to adjust the capitalization of the current
directory before working with it.

Reported by a few PowerShell power users ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 18caf2196..2c3e27ce9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -917,8 +917,15 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
 
 char *mingw_getcwd(char *pointer, int len)
 {
-	wchar_t wpointer[MAX_PATH];
-	if (!_wgetcwd(wpointer, ARRAY_SIZE(wpointer)))
+	wchar_t cwd[MAX_PATH], wpointer[MAX_PATH];
+	DWORD ret = GetCurrentDirectoryW(ARRAY_SIZE(cwd), cwd);
+
+	if (!ret || ret >= ARRAY_SIZE(cwd)) {
+		errno = ret ? ENAMETOOLONG : err_win_to_posix(GetLastError());
+		return NULL;
+	}
+	ret = GetLongPathNameW(cwd, wpointer, ARRAY_SIZE(wpointer));
+	if (!ret || ret >= ARRAY_SIZE(wpointer))
 		return NULL;
 	if (xwcstoutf(pointer, wpointer, len) < 0)
 		return NULL;
-- 
gitgitgadget

