Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,UNPARSEABLE_RELAY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589FF20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbeLNVjo (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:39:44 -0500
Received: from 28dayslater.mr.itd.umich.edu ([141.211.125.104]:53856 "EHLO
        28dayslater.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730887AbeLNVjo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Dec 2018 16:39:44 -0500
X-Greylist: delayed 778 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Dec 2018 16:39:44 EST
Received: FROM maleficent.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.125.12])
        By 28dayslater.mr.itd.umich.edu ID 5C142017.1436E.9438;
        Fri, 14 Dec 2018 16:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2016-05-12; t=1544822805;
        bh=Wnb+EPmPHKG6cha/Vbt12MgGlvcO0RuPAr+VJPfnN3k=;
        h=From:To:Cc:Subject:Date;
        b=fnTPfjmVOmQmDR84pT7HuKx/2v5jG3faHqPKYmLDi1nhyQpmJtDLoWxyc2nx2sxKh
         857m1jCiwS+y9cLVymAMA4shG8mKLTTJ+WjriWs5KubGWjexIqy6Qq6WEL5/gUvpLr
         SunL800XDhcy2zWF+fDsTIpY0K/xAwvzeVedjTW28YXxQkhr7WqW+mZ0Bs6UG63wo2
         4CGEYwWu+Wuv+g2+PiWgTCYR1mCGDrzZGWHcWcldb7hTp0+ePXXzwOHaal7IAqjlMk
         DiBkL16bLDRmrPOb3rSogKKEcaw4tpclTmJAVdPRJ/FoKhLjX9g47i85Up+MNS8dg0
         /NEeAFmxZ1+zg==
Authentication-Results: maleficent.mr.itd.umich.edu;
        iprev=temperror policy.iprev=208.46.251.251 (unknown);
        auth=pass smtp.auth=asottile
Received: FROM localhost.localdomain (unknown [208.46.251.251])
        By maleficent.mr.itd.umich.edu ID 5C142014.B8BEB.4014;
        Authuser asottile;
        Fri, 14 Dec 2018 16:26:44 -0500
From:   Anthony Sottile <asottile@umich.edu>
To:     git@vger.kernel.org
Cc:     Anthony Sottile <asottile@umich.edu>
Subject: [PATCH] doc: improve grammar in git-update-index
Date:   Fri, 14 Dec 2018 13:25:04 -0800
Message-Id: <20181214212504.3164-1-asottile@umich.edu>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Anthony Sottile <asottile@umich.edu>
---
 Documentation/git-update-index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1c4d146a4..9c03ca167 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -326,7 +326,7 @@ inefficient `lstat(2)`.  If your filesystem is one of them, you
 can set "assume unchanged" bit to paths you have not changed to
 cause Git not to do this check.  Note that setting this bit on a
 path does not mean Git will check the contents of the file to
-see if it has changed -- it makes Git to omit any checking and
+see if it has changed -- it means Git will skip any checking and
 assume it has *not* changed.  When you make changes to working
 tree files, you have to explicitly tell Git about it by dropping
 "assume unchanged" bit, either before or after you modify them.
-- 
2.17.1

