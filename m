Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB0D1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 17:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754475AbdCMRW7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:22:59 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36211 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbdCMRWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:22:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id n37so7043747qtb.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=eMwY/fe7yV1Yaba1lybyWSvc+Y7hFrb/08q7Iz78SFE=;
        b=jXD6Repmh7VUVUWvTDFnPhSkvOZJ2n0N73lPQa9y08X4QbccvKE93Gxzab/LzNQEtn
         MpLfcIQ4xUDxojuT+2LlbCLfo0ug89QhcE+KhaL8o03kukr8zZeCA1Z9ODDSKYEdzMec
         tPiCmpvlNouwn0nF2EGthRAeJ1tT9930vbcDlDob3B03FNVNm6LqFDog90jwf2dY/vMI
         bc2Et0VIKmIwFvtrVn66OlHvwFHkMeY+nzx7gOS0uLeQuTwReG1nm2mBb8NDFOipEhxP
         WYsPeph+vdHjBvlGmbkdwMZTIIie5/+qrN9cdoPaM9hlq5z1mLGtt0iFwfMmy5eioWpA
         VvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=eMwY/fe7yV1Yaba1lybyWSvc+Y7hFrb/08q7Iz78SFE=;
        b=iIv4d8a9eZNfxzLrVimFTzHZzMxZtd5O6Sk8eZ9Y7MGr31t6lS+l7TKPdfckH2dX0Y
         JgfYehSUUuek1WZzp1EH248o/nltJaeIurfyL+0lO1uaWzo5FLb47KzXs3WZv+Ry40II
         jTekpOkIdz2Xvjg+CbyyGrJUkUdDqSA+0lDGQZ1ZmYL5fb3GV+Z3xDWtVfGi0EOfpP47
         iQpmbcISVRo9ZI2tjyloPTgU821+nAA36Nf4J9oRhSa9B9f+ez/V4Nrd0RviGmxoup5u
         /V1ZJgXVwyIg2yZN9csc/NlGe33vRAoeqGwYHYpJxV3/cUUg6wpFG8PfcMMy3LirEpQh
         o2Rw==
X-Gm-Message-State: AMke39lySGGhzdVsjU7Zo5s0vjZAIIPQquK/A7FZ7QDizXYn/qXeYOHW6usrkYUxE5OfcA==
X-Received: by 10.200.55.57 with SMTP id o54mr36225250qtb.78.1489425772794;
        Mon, 13 Mar 2017 10:22:52 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-821.cit.cornell.edu. [128.84.127.53])
        by smtp.googlemail.com with ESMTPSA id n19sm12579114qtn.35.2017.03.13.10.22.52
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 10:22:52 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH 3/3] Update documentation to reflect new socket location
Date:   Mon, 13 Mar 2017 13:22:32 -0400
Message-Id: <20170313172232.96678-4-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170313172232.96678-1-lehmacdj@gmail.com>
References: <20170313172232.96678-1-lehmacdj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
---
 Documentation/git-credential-cache.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 96208f822..4b9db3856 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -34,7 +34,8 @@ OPTIONS
 
 	Use `<path>` to contact a running cache daemon (or start a new
 	cache daemon if one is not started). Defaults to
-	`~/.git-credential-cache/socket`. If your home directory is on a
+	`~/.git-credential-cache/socket` if it exists and otherwise
+    `$XDG_CACHE_HOME/git/credential/socket`. If your home directory is on a
 	network-mounted filesystem, you may need to change this to a
 	local filesystem. You must specify an absolute path.
 
-- 
2.11.0

