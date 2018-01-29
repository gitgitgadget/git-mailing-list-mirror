Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7201F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeA2WiN (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:13 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:53548 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeA2WiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:05 -0500
Received: by mail-oi0-f74.google.com with SMTP id 24so408100oir.20
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kljnU2YhO4SaipH+F2sVgnG70ull3DlsZ7DHsUKtBJA=;
        b=YJZ5XPTc+hp13ve/JWMuIhH4y5er/t7ZK00c4v/sJvJ+V7wqUV9zWWbdJwpkuaiqA/
         A03V4KCO1YFr3ZsuMZeOWKGP35exKb95dgAIJtxAEsA4/Uob05vPe6h1EIc4HA/gGfeu
         RPRVhapK5nmzJeLN9esk1ufRrNM+3fwnikUw0g1LeQMg7WcbWXIWDTuIvHgvD5x6THQN
         SFEUNJ5Lt1sr85f39bjjOeT5uhoICXTEi9FeLqJVE6PEVPsProzdDVXkA7vJ6bF3moeF
         O9dzXSs6D43zC0ujsF3nrHH9q72aU/7R5CyayeidShWwIts5dsT00B4ENVO4JAFg5U2h
         dxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kljnU2YhO4SaipH+F2sVgnG70ull3DlsZ7DHsUKtBJA=;
        b=Ac99Zarxv3fu7RrCAEBCmOldB5cp6EBQTfATzACXdwcJnF3/rquGtWegPaIclJEYBh
         1kuEBcSSMfFm3Utncrqfbw9Ur/2EJcxJCW9jdQPh8hWQP5SkKv/NwbNt4t4PW90gy27D
         9vm50cukOjmHZ3OrUQTMsGQzYvVY6tIimlspRF+0FkTdVCABYa0wf9GuM4s9kvYEa8yi
         Lkb38oUx3dADo0jq5MUd2MGWImWuoZYsjSnHg72rHkLVNCXaUKpl2aPMcQyQG2xgGqtA
         pbX5uoC4Vg7f+2/hbnbMD5xPcDJVtDo3KxfDMCzcnln/tjalvK8uY5sDSMbsc5mJO2Bj
         jY5g==
X-Gm-Message-State: AKwxytev3+hYWBY4ZNZ/rQQDzyQi5MFj7d858M+nGlwSyk4+MB14b095
        Xxhe3kybfao3X/vdRwEeqFS8r1TymGYe//BP9CLIEfa727DhFlNrsA93ZmA8lC0w7zSwsoHMMJM
        fexDynqHepYY1wl+yeT0b2jJ5avZBlNtL+NzSu+WgdeTUE8GO5GSZHFMh1Q==
X-Google-Smtp-Source: AH8x226sW0mMkE+lEVmKmegXTCf5XnmX1cDtT1noZdKejcginre6L2aC1WEOGd6yL/FSoPPabT6DjQBh0Gc=
MIME-Version: 1.0
X-Received: by 10.202.62.193 with SMTP id l184mr5075019oia.112.1517265484785;
 Mon, 29 Jan 2018 14:38:04 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:01 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-11-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 10/37] help: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/help.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index d3c8fc408..598867cfe 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -194,11 +194,11 @@ static void do_add_man_viewer_info(const char *name,
 				   size_t len,
 				   const char *value)
 {
-	struct man_viewer_info_list *new;
-	FLEX_ALLOC_MEM(new, name, name, len);
-	new->info = xstrdup(value);
-	new->next = man_viewer_info_list;
-	man_viewer_info_list = new;
+	struct man_viewer_info_list *new_man_viewer;
+	FLEX_ALLOC_MEM(new_man_viewer, name, name, len);
+	new_man_viewer->info = xstrdup(value);
+	new_man_viewer->next = man_viewer_info_list;
+	man_viewer_info_list = new_man_viewer;
 }
 
 static int add_man_viewer_path(const char *name,
-- 
2.16.0.rc1.238.g530d649a79-goog

