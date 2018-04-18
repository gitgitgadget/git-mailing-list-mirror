Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106801F404
	for <e@80x24.org>; Wed, 18 Apr 2018 22:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeDRWhH (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 18:37:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54152 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752846AbeDRWhD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 18:37:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A9DA60863; Wed, 18 Apr 2018 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091023;
        bh=lC7ZMrRswvWLzRVOjYZpQnJAy57pnKkloKgkWWoqePE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PbQPQlhF71VamitIhWrURxu4a2uwsyxfTJEgoEWz1E1mjzkoKNXfnpPcL7hfZufFC
         9wYujb7gVpDzfqKxXNI31LXY9HpboG0qpyBvLaQTqg9PHiOU1WRARmeK/6xGFzXIHw
         CsfngwhcpHCLOYP0Sh+yOUrtp3gMLA0XTh2ZMgMg=
Received: from localhost.localdomain (unknown [188.27.164.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eddy.petrisor@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59C0560F6D;
        Wed, 18 Apr 2018 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524091022;
        bh=lC7ZMrRswvWLzRVOjYZpQnJAy57pnKkloKgkWWoqePE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dCpkcWdGQjwjINEwKkyrnro8k8qogowYCc5yYhEUDF80fvs5OnudFLuU87VyEBhnq
         u3PTUNSS13MqQ7vBvgsi+KMnztbqMXQ8hM3BQhTNAJE3MdgS7gqFQSD6joFyh+24Eg
         PSrSfywFzOAjWv0/k0t52SJbkzWnVG1c0ptomLKQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59C0560F6D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eddy.petrisor@codeaurora.org
From:   =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
To:     sbeller@google.com, jrnieder@gmail.com
Cc:     =?UTF-8?q?Eddy=20Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        git@vger.kernel.org
Subject: [RFC PATCH v4 9/9] fixup:t7406:change branches in submodules after the link is done
Date:   Thu, 19 Apr 2018 01:35:52 +0300
Message-Id: <20180418223552.18345-9-eddy.petrisor@codeaurora.org>
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
 t/t7406-submodule-update.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f44872143..68c25ce0f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -267,17 +267,16 @@ test_expect_success 'submodule update --remote --recursive --init should fetch m
 	git checkout -b b2 &&
 	test_commit "l2_on_b2" &&
 	git rev-parse --verify HEAD >../expectl2 &&
-	git checkout master &&
 	cd ../submodl1b1 &&
 	git checkout -b b1 &&
 	test_commit "l1_on_b1" &&
 	git submodule add ../submodl2b2 submodl2b2 &&
 	git config -f .gitmodules submodule."submodl2b2".branch b2 &&
 	git add .gitmodules &&
+	git -C ../submodl2b2 checkout master &&
 	test_tick &&
 	git commit -m "add l2 (on b2) in l1 (on b1)" &&
 	git rev-parse --verify HEAD >../expectl1 &&
-	git checkout master &&
 	cd ../super5 &&
 	test_commit super5_commit_before_2_chained_modules_on_default_branch &&
 	git submodule add ../submodl1b1 submodl1b1 &&
@@ -285,6 +284,7 @@ test_expect_success 'submodule update --remote --recursive --init should fetch m
 	git add .gitmodules &&
 	test_tick &&
 	git commit -m "add l1 module with branch b1 in super5" &&
+	git -C ../submodl1b1 checkout master &&
 	git submodule init submodl1b1 &&
 	cd .. &&
 	git clone super5 super_w &&
-- 
2.16.2

