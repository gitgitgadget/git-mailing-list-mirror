Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B675820966
	for <e@80x24.org>; Sat,  1 Apr 2017 06:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbdDAGlL (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 02:41:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36454 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdDAGlK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 02:41:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id k6so21859575wre.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 23:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lTRScw13kemy5k3xX56kmAP56TWurdm6sUVKbtuNsgk=;
        b=s/v/MnPMjPzB6LcyZrk/rVGeOh7DEuL5c3PQCtk4Nfj+OS3NEXzoOSdV22RbZLmq/x
         +TMU9gQngGCvdVKcalUlO7FE1b62z/rHF8BVorXbRN+NROS5GNA5PtlvsyyS8FlUSFy1
         Ed5g5+zfh4oQgb6f/CcgrFkhd4cZPH97OIHqbFCndrqOnv4Yjj9V+SasGJXDJ0xpxxn9
         FfC+DcH5KYvlvfIs4zSL348cL6Fd4RNQbjZAPUB0Wt6bCW3ly45ekk56SbjiSqohAOKD
         XDqucbAM7JybvD1G+pWu3t8/EfBqZ4yRrQA8t5tMd/FT8mXtVHLGHC13DiPlYGYego3G
         xhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lTRScw13kemy5k3xX56kmAP56TWurdm6sUVKbtuNsgk=;
        b=tIlh3eD/AqVAK995JivAkfWdMCjoxYJXnKFxPN+lJ9xE7GwTgQy7ahnFSHWy3qHl4X
         I8YywAAqZJba/z0VPrYmCy1CEz1ce7M2sDElt+GmjJmvm9pvQOZPvyn7KsqCxc5JE/jg
         o4T+ICKZodTIebzOTFZcWJRGAOvaQ+diT3ZumSGZb3+3xded3o0zDRMPTm5Ye89v2bXT
         60JtlkGdgDnKfXN4ILD8AVg8RgNafRnC14S2WYw1ruzx6O0+2MXmPUUmJinquPu9cXlq
         ybnw+Pjl4IjUJMwH6jav3GqFngsSpWKFHbXbqA9gr4mVUqhTYvILzs3SPgWaGwVkIyPq
         imYg==
X-Gm-Message-State: AFeK/H0AZLY813+GK+px238EOF0FQFWgFPuo4fPLvL27fu7Wq5IzW+uwDYHcR6p0GV2Djg==
X-Received: by 10.223.148.193 with SMTP id 59mr6063598wrr.135.1491028869055;
        Fri, 31 Mar 2017 23:41:09 -0700 (PDT)
Received: from localhost.localdomain (AStDenis-651-1-321-190.w80-8.abo.wanadoo.fr. [80.8.126.190])
        by smtp.gmail.com with ESMTPSA id l14sm5963470wre.23.2017.03.31.23.41.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 23:41:08 -0700 (PDT)
From:   Quentin Pradet <quentin.pradet@gmail.com>
To:     git@vger.kernel.org
Cc:     Quentin Pradet <quentin.pradet@gmail.com>,
        Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH] git-bisect.txt: add missing word
Date:   Sat,  1 Apr 2017 10:40:56 +0400
Message-Id: <20170401064056.56969-1-quentin.pradet@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Quentin Pradet <quentin.pradet@gmail.com>
---
 Documentation/git-bisect.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index bdd915a66..90148bb07 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -137,9 +137,9 @@ respectively, in place of "good" and "bad". (But note that you cannot
 mix "good" and "bad" with "old" and "new" in a single session.)
 
 In this more general usage, you provide `git bisect` with a "new"
-commit has some property and an "old" commit that doesn't have that
-property. Each time `git bisect` checks out a commit, you test if that
-commit has the property. If it does, mark the commit as "new";
+commit that has some property and an "old" commit that doesn't have
+that property. Each time `git bisect` checks out a commit, you test if
+that commit has the property. If it does, mark the commit as "new";
 otherwise, mark it as "old". When the bisection is done, `git bisect`
 will report which commit introduced the property.
 
-- 
2.11.0

