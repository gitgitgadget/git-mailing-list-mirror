Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D324F1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdA1CDB (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:01 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36125 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdA1CCr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:47 -0500
Received: by mail-pf0-f180.google.com with SMTP id 189so77163941pfu.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EJaybqyFs34m5cZ7YPejZb4V/WZx1/DrPEs06yrxNqs=;
        b=j26KxgmUMl9vRlSy6ki2/u2ZNC+cxl2jPMDMpEGk+TjhCXYFf4bbl5AfExo4c4NuW4
         3l4NCect/wyGTBrkJZUc/j39AnNr7OvD9408b3zk2JQCPeuoZltWCfKg9SKpA5pnlvjA
         neFL6rWHb7j6R4r9Sj12HjOHs3/+MVHarRQV/eflHCdBQYtWhRZVIxq/8hYlkP7JzdPW
         W6rJi+btf4x75T5wm3PGMlPV7z7BOug5kOCCdOkjueLW2hogCkPFegxN9u5OzwQx6qJV
         3h4iReeG86dLparldFzob0rH7F0mhlWNlpxYrpAnd446+a247QVwxwEOt4O13B3bVJsm
         7PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EJaybqyFs34m5cZ7YPejZb4V/WZx1/DrPEs06yrxNqs=;
        b=opiT/HMmN4FlKr1jeSV97vqVsNtjQMpTaQHlg0NQ9Agse4mM8hLNSAZ/k+hLSxyZyG
         rlujC8Hq18FFZJ+d93bcXdhIfkwE8Z6PuXZ+B9yh+HnrxWswcovymaOSqiAflvSzBbC/
         nqOZA40Th9UOU2Sqao9YH3Wrqt5KxuUZH1KNHRMjf4WFZT1Z2YR9CGFbvnwP1kAFr9h+
         zbKA5ryXBlgpTm+gO4AGJNfQxe/LEfxCiZUzTxELW4rYkcbEo911RjCfApotXLN4TcJj
         idDGmkco3TvPWHTc5Ra+9lDYs+F4gN+mPynbMeHiiN0/oISgvtt4Zl3m3RrNyuBdynus
         q1Lg==
X-Gm-Message-State: AIkVDXJC+nB57tSguDR6vs6vxA8wknhg0HchzVhYSORhq3gsScg4BVGRWT/wIsChGKYpfsWP
X-Received: by 10.99.251.17 with SMTP id o17mr12653813pgh.103.1485568966755;
        Fri, 27 Jan 2017 18:02:46 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:45 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 12/27] Documentation: fix a typo
Date:   Fri, 27 Jan 2017 18:01:52 -0800
Message-Id: <20170128020207.179015-13-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 3173dee7e..a53d093ca 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -88,7 +88,7 @@ is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
-Sometimes you would need to override an setting of an attribute
+Sometimes you would need to override a setting of an attribute
 for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
-- 
2.11.0.483.g087da7b7c-goog

