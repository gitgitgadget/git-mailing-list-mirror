Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F99E1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDRWhB (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:37:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53998 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDRWg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:36:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4EF7960A4E; Wed, 18 Apr 2018 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091019;
        bh=pSoq7d6vVnolYktUuflDtL3HRDAx3NHq+QAVR6OP2/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nX3vCwNbvvFifAWaa9l6tfFjJLC3AXhml9zUztl8+8Af9sY4mf+4gA/qCoaYcp9ed
         eB5Qj32RK+QNSuB8qpo71jbvmnQLUbwG7h0MkHRy/wwQLZqr1GW9eQJnX1oS/0kX0C
         yu4Iev+Ov5cLS2YKwZ+ukzOSg8zyGtzPdHDXhc6g=
Received: from localhost.localdomain (unknown [188.27.164.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eddy.petrisor@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCEEA60500;
        Wed, 18 Apr 2018 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091019;
        bh=pSoq7d6vVnolYktUuflDtL3HRDAx3NHq+QAVR6OP2/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nX3vCwNbvvFifAWaa9l6tfFjJLC3AXhml9zUztl8+8Af9sY4mf+4gA/qCoaYcp9ed
         eB5Qj32RK+QNSuB8qpo71jbvmnQLUbwG7h0MkHRy/wwQLZqr1GW9eQJnX1oS/0kX0C
         yu4Iev+Ov5cLS2YKwZ+ukzOSg8zyGtzPdHDXhc6g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCEEA60500
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eddy.petrisor@codeaurora.org
From:   =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
To:     sbeller@google.com, jrnieder@gmail.com
Cc:     =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        git@vger.kernel.org
Subject: [RFC PATCH v4 7/9] fixup:t7406:supr5 commit is done before submodules chaining
Date:   Thu, 19 Apr 2018 01:35:50 +0300
Message-Id: <20180418223552.18345-7-eddy.petrisor@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180418223552.18345-1-eddy.petrisor@codeaurora.org>
References: <20180418223552.18345-1-eddy.petrisor@codeaurora.org>
In-Reply-To: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
References: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eddy Petrișor <eddy.petrisor@gmail.com>

Signed-off-by: Eddy Petrișor <eddy.petrisor@gmail.com>
---
 t/t7406-submodule-update.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 32995e272..18328be73 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -279,7 +279,7 @@ test_expect_success 'submodule update --remote --recursive --init should fetch m
 	git rev-parse --verify HEAD >../expectl1 &&
 	git checkout master &&
 	cd ../super5 &&
-	test_commit super5_with_2_chained_modules_on_default_branch &&
+	test_commit super5_commit_before_2_chained_modules_on_default_branch &&
 	git submodule add ../submodl1b1 submodl1b1 &&
 	git config -f .gitmodules submodule."submodl1b1".branch b1 &&
 	git add .gitmodules &&
-- 
2.16.2

