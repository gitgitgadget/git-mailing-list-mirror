Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2738F20357
	for <e@80x24.org>; Mon, 10 Jul 2017 14:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932447AbdGJOSf (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 10:18:35 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34449 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbdGJOSd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 10:18:33 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so12912564pge.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AsvVqZkH0AQhOGNi5s4v2eeOHNMgxCqKKi/NrRjfXUU=;
        b=sv3fsrjOoigQQHkRJ6OSjKQTt3V228fwIJkWqKnhinaKuK7LwZz7DJ3m4xRf/83ntH
         5A+/gI9N5E+uxlb1Hobt6LgvOIcghFCqH5MZA9hNFTEwzpmG1kstC6HxTuShh8KcfpsG
         3KyuUfrsYqoti7lJmKMhN+dnf0LlupIwH77XbiT6/age1l7J7h4H5Or47AtKmY+mo+gF
         rypBkBt/cnfqnmvM9UPFOtzLN+IXdIOTZv9C4dgPR0P5xzFpa6XS/ha/Q7L4lKW4/FtN
         GqyHOfR17FD2CEjhSAJvvhmrz+A4CqcIzlYWWjEfDGgrBQuQElLxtccp+8OcB1fO/wf1
         h+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AsvVqZkH0AQhOGNi5s4v2eeOHNMgxCqKKi/NrRjfXUU=;
        b=EdDbJ1NaiDZFKW0M+7X9aMRpRGGrmcGPiW/Wg98xH/N5wqodxULoOPNlaHA6bLAqDA
         RHLUuKR3rLvZtYJIbHx8o6cpoO/40cYIt9IjHnvfGIqPcjsgLk7Bs6/9XByHhGdYgEFn
         r7QE0bnjr86t52Zv8H6e9ZDQ83y198yYv6UwQHaqUDSnCOpTEjI9HjieCMLsFF6qZpdX
         FrfGYtj3cBbvnNWYA95zxx09RxBGOqfkW4XQYPMCHwnMHmksFBJHM5WLvOznJYENv1fj
         H58Ecr1/ZCiR30N/Agkz/OobNkbYRYfGwtUcAhYoetj6VsWhIkg1rUr0FhEOmozQ2JU6
         wwrA==
X-Gm-Message-State: AIVw113lnWQBWYn7FKYJc1uR1JGpg7oERvyegqWvpKtOJv4Xc1q9H+9J
        dUciiO4xXEipQQ==
X-Received: by 10.98.53.134 with SMTP id c128mr45104060pfa.36.1499696308190;
        Mon, 10 Jul 2017 07:18:28 -0700 (PDT)
Received: from localhost.localdomain ([117.209.142.50])
        by smtp.gmail.com with ESMTPSA id y2sm19149249pgy.60.2017.07.10.07.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 07:18:27 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] doc: correct a mistake in an illustration
Date:   Mon, 10 Jul 2017 19:48:30 +0530
Message-Id: <20170710141830.8655-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first illustration of the "RECOVERING FROM UPSTREAM REBASE"
section in the 'git-rebase' documentation wasn't in line with the
rest of the illustrations of that section.

Correct it.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 53f4e1444..652a99062 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -675,7 +675,7 @@ on this 'subsystem'.  You might end up with a history like the
 following:
 
 ------------
-    o---o---o---o---o---o---o---o---o  master
+    o---o---o---o---o---o---o---o  master
 	 \
 	  o---o---o---o---o  subsystem
 			   \
-- 
2.13.2.957.g457671ade

