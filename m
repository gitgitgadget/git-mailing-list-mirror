Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532A11F463
	for <e@80x24.org>; Sun, 22 Sep 2019 11:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfIVL6d (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 07:58:33 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44016 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfIVL6d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 07:58:33 -0400
Received: by mail-lf1-f51.google.com with SMTP id u3so7999300lfl.10
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=htf0t/DNf3I5473khPTqUwx8uB6vnfQmbRqbq+qMmT8=;
        b=tYw90c3QLEGV+VfU2o8agVFT3xWQ/3OfqW0KAAWr9hta7772q/PnOCnCOBJDbuF/lY
         06hQ9coIgIQS7CY970k3wOBTlYgSH6eprFOE+a4ApOVj/koFd3ILtQ7h+HJaeBu/De0a
         kcFz72L7ZXzKW5EO5h9N5BkrDDf4fx2oSwLY+Yl2G5lPliv+rTg34dzhtvKelHPQ7zbK
         6PNhRP7xrT3SJ/mwLGav9RYsGj/OmwFO87MhhXcu9ynYyFYccfOjdl+gktpEd8fA+p1q
         KO0HM+VVuI1aOEuCg4T3QyipJXRMcsUw601XeWbTxsHCYsl6+3iLVDH7ju7Zkbv73ARy
         e2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htf0t/DNf3I5473khPTqUwx8uB6vnfQmbRqbq+qMmT8=;
        b=J5StIO+Ga1kuF27bh+2n3KhIfbxL6UZCZk/6EH3AdYJTjF7azn/q+bzJ0tIgTPjN6M
         1KXu2j/3P/a384t8tP52DHtDbR8RVkXIa9XNPtw/EdF8h98ddkkyfY+AXKcs4npEv89a
         a/Un5BSr8rNxoWBtNJhcCsOoSqYut7fJOXiJx2V59EJ0hubpArrCj/9yHgMnHSMJ/Cn2
         ihNXdDMeW+hiux2j2erUZAEm2Wrmwvlm2CRQ3edYZna1cmP4KW3Mb5dfsWfuOyt+WqDu
         mkfYLsuruyVzOXTyKAOmVHzkqnbHstqEjSGvx0LsBOZR9AFgpXN/5bTKHjmfKN5nKICI
         4HnQ==
X-Gm-Message-State: APjAAAW9XDaiQCsTpmgM8hDXTL9Yn4BySAGO/7lPrt3WTilrEyHNYr1e
        OjXthQuZQODFbcxYeDBB7U0LGpvC
X-Google-Smtp-Source: APXvYqzr0Uf4tKFO3NmzvMV1+L2ZBr1p+PIPZfpdTCLuleYHX6hlKyKE53dkMDl6gQP62Nua37by0Q==
X-Received: by 2002:ac2:554e:: with SMTP id l14mr15105402lfk.32.1569153510903;
        Sun, 22 Sep 2019 04:58:30 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id q24sm1622413ljj.6.2019.09.22.04.58.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 04:58:30 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] user-manual.txt: add missing section label
Date:   Sun, 22 Sep 2019 13:57:56 +0200
Message-Id: <f8ef5ba3d1ec9795dc2ad49f79472020f0622e00.1569152396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569152396.git.martin.agren@gmail.com>
References: <cover.1569152396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We provide a label for each chapter and section except for the "Pitfalls
with submodules" section. Since we're doing it everywhere else, let's do
it here, too.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/user-manual.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8bce75b2cf..2dc2ffdaab 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3698,6 +3698,7 @@ $ git push
 You have to run `git submodule update` after `git pull` if you want to update
 submodules, too.
 
+[[pitfalls-with-submodules]]
 Pitfalls with submodules
 ------------------------
 
-- 
2.23.0

