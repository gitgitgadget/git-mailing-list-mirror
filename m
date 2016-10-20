Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB6B1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 13:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935962AbcJTNXP (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 09:23:15 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34733 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934025AbcJTNXP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 09:23:15 -0400
Received: by mail-qk0-f194.google.com with SMTP id n189so4537502qke.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ong5QN9BSnthFB9fndZ7utoixutJmy66Qu+CJXWPKA4=;
        b=JUZt5uBNTqjCigFrou01ffhpQ5u0Bkt5dOgvaDoH3JzqLB0o0cR4bibOYqL8rphpc9
         ZHRk3nbmxWd56zJAugOyEBibwi8Dawyx0SUSq2kfHz+TY5hN4b0vD+U2g24OUnFpmYIL
         ZMjRZYL9STxL/pPAoW4ajMj++u0/h5jy8aJEw36hQ0sKf9Z9e49We1yvopy3uMcCyOqG
         O9MgWCC2oYW/AJ9vIVFN344GBubpZjtZtSS1eu2BGPPpJNaqyD4J9Yipqr25PfVm4HEI
         0V6HjO2ffNtJ3PtRj2Jqam+lIl3rqOa/UpIwrnXR7/xh/99ADumgFBovE493AdDl/mmT
         /kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ong5QN9BSnthFB9fndZ7utoixutJmy66Qu+CJXWPKA4=;
        b=mYOYYx9F8RpIA9pmJutRfuDCNclQQJmdaSTdzQhscT7w9BFkID73CQ7imspo2lqxyf
         Ej7ZpR6/KkHlhPv3/HuLvDmbcr3GjjhhR50w2d+N+llJNwqopNBXWkaAsyq5IkZ/I1lB
         5nvQqiJys7jTL0OuEu5uPocaw6USiUITjCqFc51wwzFI2+z2QhhrT8G48MW1IJsGavBF
         +vWuMu0Qkl9vzMCD+hr8yBdwriGUBIUP2h6UFYuiPJH/bM3vox02pSUGg9/uz/hcA40c
         y/LuqU7BCb5qhXLa+2hUVoNujkk8KD6Ls00suv8K2sgVkH5d09MlbO6HtMiy1tSyd/81
         QSUg==
X-Gm-Message-State: ABUngvc/5JQ7qrUXe9uFgd9ubdo3XCm7B0rJUj2JBvRHnW9/0hNG/uk6eKJTdEfp+K/1Kw==
X-Received: by 10.194.57.195 with SMTP id k3mr436388wjq.168.1476969793988;
        Thu, 20 Oct 2016 06:23:13 -0700 (PDT)
Received: from odin.lrde.epita.fr ([163.5.55.13])
        by smtp.gmail.com with ESMTPSA id af4sm69279325wjc.17.2016.10.20.06.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2016 06:23:13 -0700 (PDT)
From:   Younes Khoudli <younes.khoudli@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <junkio@cox.net>,
        Younes Khoudli <younes.khoudli@gmail.com>
Subject: [PATCH] doc: remove reference to the traditional layout in git-tag.txt
Date:   Thu, 20 Oct 2016 15:21:44 +0200
Message-Id: <20161020132144.6018-1-younes.khoudli@gmail.com>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the only place in the documentation that the traditional layout
is mentioned, and it is confusing. Remove it.

* Documentation/git-tag.txt: Here.

Signed-off-by: Younes Khoudli <younes.khoudli@gmail.com>
---
 Documentation/git-tag.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 7ecca8e..80019c5 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -253,9 +253,8 @@ On Automatic following
 ~~~~~~~~~~~~~~~~~~~~~~
 
 If you are following somebody else's tree, you are most likely
-using remote-tracking branches (`refs/heads/origin` in traditional
-layout, or `refs/remotes/origin/master` in the separate-remote
-layout).  You usually want the tags from the other end.
+using remote-tracking branches (eg. `refs/remotes/origin/master`).
+You usually want the tags from the other end.
 
 On the other hand, if you are fetching because you would want a
 one-shot merge from somebody else, you typically do not want to
-- 
2.10.0

