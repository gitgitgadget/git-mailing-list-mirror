Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8176F1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfA2OTk (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:40 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:38517 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfA2OTk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:40 -0500
Received: by mail-ed1-f45.google.com with SMTP id h50so16086901ede.5
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Smsl1dhl4ohZgrvGoo0qeTJuxC6Y18tYIdYty2ZmJE=;
        b=Q2IEYLWLKDij1jKd85bIk/DzOsZ/NexCUmm6q547IW2d6dzBAV/lDyO/4MZbs649WT
         WX7OLFfFOD8oGVZp6YdLByXo6GtFVe7j8jemsVxfAw8KRRiMh4tEmazNuJspMgfczP9a
         Eku9F4ZPzAVn3+DMZ7Vi8vHZ3pRVBMBIpThCz1EjPDUxznWuqON0u+nRWJHD+zPIvo1t
         JHhAk76d5bVt0uJULrH+bY1W+tqZKhhKpnlkVv4YTyBM3+pedQNopi0r7HyDcOJ4VDaA
         f4rb3dZBUCEeGDnNLPMekc35p1nhUxTZ4YcADV5eO9phiGxwQaP1iO7WZ6yNcLHaYQhl
         GyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8Smsl1dhl4ohZgrvGoo0qeTJuxC6Y18tYIdYty2ZmJE=;
        b=NI8XnS4bUpZILGBVKQp6NanPW5P0jnNMPR4UWiJorYkTTUHSCYr5y7yDw54iuwWqZT
         FQMI2pReNDfCUbYGsaoJYRX2/nu4s6jww275u8ytczZ1k0bW+G+7Gr/E8TnMhaL/RCsZ
         lvwmFwDnUxvd+aYWzwMmPoRJOSQVLkCu8gcPECaH8ulEYy4gZ9gqWWg3Sf009gbYRYkz
         LJzMq7varpGK99WyJ1xbS6Y2IoYAJhtYeFIHg8/KEXqkanv0JRQ0B2U0DU3lNVNBhIpn
         N/WCWYeKowfRzZG7tqaVnIGK9+6Rvh/D+mhgcr1RPIhaWfo2VcNCSwGqFmw6jejsejui
         mU8A==
X-Gm-Message-State: AJcUukeH5WM6C6F/19GDoYR9KcjomvrpSRknHUm8/64jY7/xFa5uNspk
        fndqsh+MR7LIYMcWcXePcWQOcArA
X-Google-Smtp-Source: ALg8bN4sDT0olJaBB5erK2i7EVM6XJmUIicR37hImwIwK7ng3tdUj3yDlIHZ7+5vhwIBLI5Bt6z8oQ==
X-Received: by 2002:a17:906:7b15:: with SMTP id e21mr21748031ejo.8.1548771578402;
        Tue, 29 Jan 2019 06:19:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d56sm14761730ede.76.2019.01.29.06.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:38 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:38 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:19 GMT
Message-Id: <3532811a49e6fc6beb7aba84b851ba4999cb0be6.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 20/21] ci: speed up Windows phase
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

As Unix shell scripting comes at a hefty price on Windows, we have to
see where we can save some time to run the test suite.

Let's skip the chain linting and the bin-wrappers/ redirection on
Windows; this seems to shave of anywhere between 10-30% from the overall
runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 5505776876..c2bc6c68b9 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -127,6 +127,8 @@ then
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	export MAKEFLAGS="--jobs=10"
+	test windows_nt != "$CI_OS_NAME" ||
+	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
 	echo "Could not identify CI type" >&2
 	exit 1
-- 
gitgitgadget

