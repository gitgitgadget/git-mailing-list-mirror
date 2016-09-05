Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40ACB1FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 15:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932843AbcIEPiE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 11:38:04 -0400
Received: from mail.hs.ntnu.edu.tw ([140.131.149.3]:29924 "EHLO
        mail.hs.ntnu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbcIEPiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 11:38:03 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Sep 2016 11:38:03 EDT
Received: by mail.hs.ntnu.edu.tw (Postfix, from userid 800)
        id 1E0B41C6480; Mon,  5 Sep 2016 23:28:20 +0800 (CST)
Received: from [140.113.215.9] (IP-215-9.cs.nctu.edu.tw [140.113.215.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: iblis@hs.ntnu.edu.tw)
        by mail.hs.ntnu.edu.tw (Postfix) with ESMTPSA id 97A4C1C647B;
        Mon,  5 Sep 2016 23:28:19 +0800 (CST)
Subject: [PATCH] Avoid hard-coded perl path in sha-bang
References: <01020156faf163db-3a2e9796-3b12-43d2-90dd-2b843896a5b7-000000@eu-west-1.amazonses.com>
To:     git@vger.kernel.org
Cc:     iblis@hs.ntnu.edu.tw
From:   iblis <iblis@hs.ntnu.edu.tw>
X-Forwarded-Message-Id: <01020156faf163db-3a2e9796-3b12-43d2-90dd-2b843896a5b7-000000@eu-west-1.amazonses.com>
Message-ID: <ddf84da5-036f-6e4f-839d-cef1f7ede4be@hs.ntnu.edu.tw>
Date:   Mon, 5 Sep 2016 23:28:18 +0800
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <01020156faf163db-3a2e9796-3b12-43d2-90dd-2b843896a5b7-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.330846, version=1.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Iblis Lin <iblis@hs.ntnu.edu.tw>

---
  contrib/diff-highlight/diff-highlight | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..b57b0fd 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
  
  use 5.008;
  use warnings FATAL => 'all';


--

Iblis Lin

