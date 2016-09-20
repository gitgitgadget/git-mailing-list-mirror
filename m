Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6C61FCA9
	for <e@80x24.org>; Tue, 20 Sep 2016 07:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbcITHdU (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 03:33:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34629 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbcITHdU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 03:33:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id l132so1808300wmf.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=odtdqv2IBP5r+TKPfvwU1s/iAXpswOqDQNpOj7r4Glg=;
        b=FfYEzFAaX/shZayoFD0yeANEeaY5nCFlCGbF9COe369shQ11fxEKQBUiiSLcjS+ohn
         ZdNmSJ8ST6M4mDYSlI/do4Rz9Ga8wCwES4vL9MRiUO4dV7xTBLIJpQ3F9gufnSjg6NWo
         EsqK9DUrahC6qBfWXSIJcOrommRuqm18YwFtqB8EdwKTRkZ9pvBTAGgDUV/0a+GeDl+2
         7r/0SQRky8swcvB5vifRImvL7k214U7+Z7MbzAkJ+8RnJj55pqRa0Af3iHCo4vQIVNYS
         H3pm/86FY8hQNExatwCcHXJ59NbEaV1GSQYkzqWI7L5vFAMmanIrAr5IP0DwpPNJFIoG
         AneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=odtdqv2IBP5r+TKPfvwU1s/iAXpswOqDQNpOj7r4Glg=;
        b=ex3gdeGCz1iCFwSS6g2qZuaL2ry6xCX3QV2+uyGJjD0I1qZkpIgpi/U4myssPSRz/x
         dtsUhv3V0sD+k5N4N6XM9ztK4x2xr0yBFs97dVqxVpJo3XNDM6HVG+2q2JDJjQ+vL+DO
         jw6KKZWL8NAVYYxcIwjGFXIRovKYXMyygqKDveYBuiMyp2FxBW3aTnf/B30nxY0mwbRc
         3+zPhnalEbnReKFshmvqZYvy/1eXONaNdaCdz8hxoBoqaOw8ys2bScL3W3asU/1alxw1
         gyPW+ITe8ZMdXdW48O8fJ+WjROQsSDtxTF2vyo8YYAweAJwS7U+tXduQNjD8bkzQn34n
         rXzg==
X-Gm-Message-State: AE9vXwOlzKWkIf8WHfsTT909zikoiyGkmQ3rXmFw+XBPoN7A61DDNVc0VqPkUygwKBM9wQ==
X-Received: by 10.194.235.69 with SMTP id uk5mr26576886wjc.53.1474356798609;
        Tue, 20 Sep 2016 00:33:18 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id w207sm25866800wmd.8.2016.09.20.00.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 00:33:17 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] git-check-ref-format.txt: fixup documentation
Date:   Tue, 20 Sep 2016 07:33:14 +0000
Message-Id: <20160920073314.22485-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.10.0.645.gc4ba6eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

die is not a standard shell function. Use
a different shell code for the example.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Documentation/git-check-ref-format.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 91a3622..8611a99 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -118,8 +118,8 @@ $ git check-ref-format --branch @{-1}
 * Determine the reference name to use for a new branch:
 +
 ------------
-$ ref=$(git check-ref-format --normalize "refs/heads/$newbranch") ||
-die "we do not like '$newbranch' as a branch name."
+$ ref=$(git check-ref-format --normalize "refs/heads/$newbranch")||
+{ echo "we do not like '$newbranch' as a branch name." >&2 ; exit 1 ; }
 ------------
 
 GIT
-- 
2.10.0.645.gc4ba6eb

