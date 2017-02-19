Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE29D201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 22:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdBSWch (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 17:32:37 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35167 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdBSWcg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 17:32:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so11434931wmu.2
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 14:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=tnzlBLGizlyc+1Y1yWQLGUlavfUddiJKaZjtSLZtR6o=;
        b=mjQKd/lqOfCKkh5ZTbLC86IgELXsZ2GGjpbbE48NLpdIbNee09unedmar3nK2YYREv
         Kr4OYu2bXKrpJ0kysaad2oFp89NSPRQUUJQ7Gs/MxlNbY19L9HjVtvdDCuTtqKdpmNTk
         tMzmdVFod40GOD7Bn3HLsWe0Vf+A23gJPAYiGJHn2NYu6ioARz3aWyI7nAGJB1WB8TeJ
         9GdGy3lxIcpftsIdQn6FaXLNi3oCmZ1avZsO7DlvFKuifKyuqIKxYvH/4D9gEci81s3K
         e/N/c7id97TmaCdMPfPRm3UnTeLogGG1ad4E0JCxtEPi38Ro0xVGhjYFhFZVSdsYuH3D
         3Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=tnzlBLGizlyc+1Y1yWQLGUlavfUddiJKaZjtSLZtR6o=;
        b=eEf91e0uegNLnCnrwEskcfuJOeQumhAFAn4G6FOFPrtbJkNtbjijL09yzV952y4eUH
         DdZwSSeP6u2M+JS37I9LUK6Epq4xcCXJ4dpJ8Yal3KhKw1vZahuAh2GmAKfL+MPxGQ0M
         9yX8AM1MuGMkkOOofXevv2Xgo0VOCC4ZbS16zaaPwqd4i3HNM3sqXFVfXdCcbVOlQ4cB
         AYJW9Rwm2OqC+hUxDM5T8OIbNymVjv3q8HQ5XRW5gLc3hfbIqTMs7YKPPBi8YOIakdvy
         F1c2CjOuw2aYogqFUWvKJSKisRDLyyUQXa5wlExatE5axSF5kchH63wwDXOR8x56d7EF
         Mj2Q==
X-Gm-Message-State: AMke39lHH1c9cTHgynEQQHnHfX0QlbD5ciaLq6UA2aPZ7aXSN2yjKKN/sKZFJjSgvYJ7nA==
X-Received: by 10.28.146.207 with SMTP id u198mr15276728wmd.36.1487543554466;
        Sun, 19 Feb 2017 14:32:34 -0800 (PST)
Received: from ?IPv6:2a02:120b:2c05:6900:5e26:aff:fe78:1daa? ([2a02:120b:2c05:6900:5e26:aff:fe78:1daa])
        by smtp.gmail.com with ESMTPSA id o42sm22330780wrb.18.2017.02.19.14.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Feb 2017 14:32:33 -0800 (PST)
X-Mozilla-News-Host: news://news.gmane.org:119
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
From:   Damien Regad <dregad@mantisbt.org>
Subject: [PATCH v2] git-check-ref-format: clarify man for --normalize
Message-ID: <44113ef6-5669-5e02-f848-27c17fac55e5@gmail.com>
Date:   Sun, 19 Feb 2017 23:32:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use of 'iff' may be confusing to people not familiar with this term.

Improving the --normalize option's documentation to remove the use of
'iff', and clearly describe what happens when the condition is not met.
---
 Documentation/git-check-ref-format.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt
b/Documentation/git-check-ref-format.txt
index 8611a99..92777ce 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -100,10 +100,10 @@ OPTIONS
 --normalize::
 	Normalize 'refname' by removing any leading slash (`/`)
 	characters and collapsing runs of adjacent slashes between
-	name components into a single slash.  Iff the normalized
+	name components into a single slash.  If the normalized
 	refname is valid then print it to standard output and exit
-	with a status of 0.  (`--print` is a deprecated way to spell
-	`--normalize`.)
+	with a status of 0, otherwise exit with a non-zero status.
+	(`--print` is a deprecated way to spell `--normalize`.)


 EXAMPLES
-- 
2.7.4

