Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5340E1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 14:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbeKGXbU (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 18:31:20 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:37617 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeKGXbU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 18:31:20 -0500
Received: by mail-pg1-f172.google.com with SMTP id c10-v6so7362632pgq.4
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 06:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pPe3QFXLwiUATG9i5FlPZ06i+iTzhOwOq/j+QoXFZ3c=;
        b=PJsdiFZCFW27VLXHXWP7zO2QZxqbx62oG4S9OPf+9DW03qPKq9XMvqlK7NfIWAAYZf
         7qdMC1xB/dTKWbhHxwFUGUZ2hMWbWP6nKePEPEEMAa5rfyhd1c4YJmJQlJdE6521TvqG
         2l/YoeA6EBTyRFR79fPLLo4nujJRG5cq7zojPHIej9Cl/1E3UkvkuPM/IIDMoaWW7sDj
         BOu3kvIwjUEFi6s2e2FDWrFxnbmWqrvB2Jizji0b1LB6O4NEL2nE4LxkuGrP23I0+uGI
         eooRCeD/+sNwT5uguqle2PM4oqACqQdDeAqt/i8VwWg8K2QuqA6Ln/NchbP4uoz1jtyd
         iXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pPe3QFXLwiUATG9i5FlPZ06i+iTzhOwOq/j+QoXFZ3c=;
        b=dSGk7CKyDflq7NqxCB05iKiyRU+P85Kr+xAtcieUf/WgZ+HQb0CYxHrTqUe4AcYP7T
         T4tUhB13SBS/Umy15cOV2vDZD3qWCMk4EYrVMQcNatM+Akpkgmdt6CUeYpDmHnOAHpK3
         AEGpBv9nuuiA98BxmWbsnQOZhivhDkieBs3LtQ9E/dc2iPynr8XwUswTfQUu8fFyZsAv
         BQfxCYmgF4RJrXyRoOql5VwkOUzgq3l/vEZqrh1r6/Tn3TRkiwou7kXX93UIn80/RwCr
         SxkIfGQ1mhtgn/GbRislKvmQJ7E9CVKAC53bQf2h9KV68MewotBef1vv4sAV6oMY2bGN
         kR9w==
X-Gm-Message-State: AGRZ1gLyrrKwjnQhbd6P1yZu4mAzTIYYS0kWBCmHmHyfPE1SVKMLt/PJ
        dqQhC1uphmpEBmIKxJmW8J1U2YP1gDQ=
X-Google-Smtp-Source: AJdET5fy1snoegzINBZ2E03Q6sEKwkzaB+R+cMQ9J065U2Oc+n/rCQsCbxd7EW3QDq5RJ8BWOFUc5w==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr263737pgc.165.1541599249430;
        Wed, 07 Nov 2018 06:00:49 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id b69-v6sm778369pfc.150.2018.11.07.06.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:00:48 -0800 (PST)
Date:   Wed, 07 Nov 2018 06:00:48 -0800 (PST)
X-Google-Original-Date: Wed, 07 Nov 2018 14:00:44 GMT
Message-Id: <9a5237b13bb22e192cbe5777e6338d78e0773bad.1541599246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.70.git.gitgitgadget@gmail.com>
References: <pull.70.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] built-in rebase: demonstrate regression with --autostash
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     AEvar <avarab@gmail.com>, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

An unnamed colleague of Ævar Arnfjörð Bjarmason reported a breakage
where a `pull --rebase` (which did not really need to do anything but
stash, see that nothing was changed, and apply the stash again) also
detached the HEAD.

This patch adds a minimal reproducer for this regression.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3420-rebase-autostash.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index f355c6825a..d4e2520bcb 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -361,4 +361,12 @@ test_expect_success 'autostash with dirty submodules' '
 	git rebase -i --autostash HEAD
 '
 
+test_expect_failure 'branch is left alone when possible' '
+	git checkout -b unchanged-branch &&
+	echo changed >file0 &&
+	git rebase --autostash unchanged-branch &&
+	test changed = "$(cat file0)" &&
+	test unchanged-branch = "$(git rev-parse --abbrev-ref HEAD)"
+'
+
 test_done
-- 
gitgitgadget

