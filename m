Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FAF51F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeCZVI1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:08:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39645 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZVI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:08:26 -0400
Received: by mail-wr0-f194.google.com with SMTP id c24so20283756wrc.6
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Deu6ngA7jsM03fVJ0N4UfN/w+etulBO/iIFzDoBXQ6g=;
        b=PBnrVbG+LqBGqxF26qDTdxgGdpPMum1wWV5ZeRnRd07kgaeCkZ6gUWhs8laKcsEqab
         1bBQIUze/MKlSi7gEFIumBAPoA0yJqKQhu0pTv/Exumco7+BaefXwYnn5TiXAw6s61tR
         j1KQFX/qv1FW1TSfS8k1vHg2yr1GLWn6zirTBKr/O3jylOVoIqH1RQcnENpSImRoIxy6
         oFALxEeWcHeEGdg42KGhH/gxzCsDm1Rw8+LPKMwkhqeGliwoKqBVLVhpPbQmgcXJWlt7
         j+pxrPycG7baWI1H9J2onVCvjJqyz7H/wI6U2TIG7p4hL+Qxx/06lftKa5ACM346ie1e
         DAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Deu6ngA7jsM03fVJ0N4UfN/w+etulBO/iIFzDoBXQ6g=;
        b=DTjPoAPxrG8/YyoUM4IZ/K3ED8uDt7g1sAx72mrH80uTrFg9F8tJBRRuiVRLt0nfVS
         x5E30UV2BAhVZXO3JAG9Xi+CQfjEkrVPb2mMEkfhYcjNdEl5yljbNsQvRnHLlPlJ3A38
         vavNobolvKaUJdX0EbtGUu373mvKqHrJ25QCnQTt+nh49/vp7lY/3jN+plwAkJLvwAkL
         uofnNrQnjNDPfaOTHo89jclq0PBaw1XhOJGw4F9q6hiFPYnFKfw9FpT4ot2bodDGFrrF
         PLmnCVQP+RI958HUEoSdWeVkFDIINqS10YwApDbpTVgy7xow7YWRbJcEfeVe7ZxMhj8p
         CX9Q==
X-Gm-Message-State: AElRT7Gbjj88RnlfxhplYdnjAsI303WUlU+wZd96Piskv7T+xO67YFS6
        wr1oxtw1oCz6F9MYvnGLSDNsISex
X-Google-Smtp-Source: AG47ELuIcepwBv4ZxWGIB7MdztDS4SPqqB9nfq7cp4jJxrzNoWGi6k8H346eSLIF5bdC+sVpCORCPQ==
X-Received: by 10.223.156.210 with SMTP id h18mr9736031wre.109.1522098504951;
        Mon, 26 Mar 2018 14:08:24 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id q13sm15810197wrg.56.2018.03.26.14.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 14:08:24 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] git-stash.txt: remove extra square bracket
Date:   Mon, 26 Mar 2018 22:11:47 +0100
Message-Id: <20180326211147.25846-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.35.g90bbd502d5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1ada5020b3 ("stash: use stash_push for no verb form", 2017-02-28),
when the pathspec argument was introduced in 'git stash', that was also
documented.  However I forgot to remove an extra square bracket after
the '--message' argument, even though the square bracket should have
been after the pathspec argument (where it was also added).

Remove the extra square bracket after the '--message' argument, to show
that the pathspec argument should be used with the 'push' verb.

While the pathspec argument can be used without the push verb, that's a
special case described later in the man page, and removing the first extra
square bracket instead of the second one makes the synopis easier to
understand.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 056dfb8661..7ef8c47911 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
+	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
 	     [--] [<pathspec>...]]
 'git stash' clear
 'git stash' create [<message>]
-- 
2.17.0.rc1.35.g90bbd502d5.dirty

