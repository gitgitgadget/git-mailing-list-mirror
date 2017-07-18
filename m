Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8812029F
	for <e@80x24.org>; Tue, 18 Jul 2017 14:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbdGROeW (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 10:34:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35317 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdGROeV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 10:34:21 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so3100851pgc.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ogbh0o54RwQLv+SIjTaHqIrOCFth772BHtY3jfI9QeI=;
        b=Z1/tZnHj8B3uR1wH/2V87nB7ki07+/0nQhLGNBB1hjYFjOzh6BSedDvacKybCYt2DY
         SSFS/jXL+kIjuI7j7gMEA/K5bHJSFbRDY+bVRpyz7zSRBl3AYK6CmLtgf5WS0E043odR
         B9oD37l48iN++uBSpUMGX4heBcGWuJyKvIW9fkZhCwjGB0LPzfZ0IKWwFuAtKZe6gWb5
         TGBaTUwf5Z0HfWPHv/mekkPtenwAaOX6w1O5qEMLEbjPOs4PeK2j+hqb5YKNUZaaE1M2
         ljX8sqbzOmrcmVbVFKWwD5jc/1gVpoiUe75nUrdcsTHFFUAnGkcadRkvadjeneNLa4kq
         ErtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ogbh0o54RwQLv+SIjTaHqIrOCFth772BHtY3jfI9QeI=;
        b=ncwU3o9kWx7qP4fkpJv0VP47ZTVMschVprPdaYZR0JLmk9k/hUHecnFs0vVVImjuBj
         7NmL/5dc/VisEa3qMFRzWSnlmk8ClnYvUa0kokLlsYID5qypJCJlx/COoDLMkDI8PJd9
         iuodLkOm70k2sU1vS/3nXVOnIS93QINbtACUFJMZvjqEr+/wUgmc6UmqGDgjGMJjDsi/
         F0xZ7qKtxxpx6cv4b3ZCUB7LCiOYJ1C4bo4ka77/Wb4V5VbxABfx/m7EJgCu9aA6vLTN
         aRNJiSokpthCyqUlWnBEDCxaf5dgSJAuzef/qsj0WdIcxbj804rb39oWtzq3nIh+C7yn
         /e+g==
X-Gm-Message-State: AIVw111e8KYJQ/4wlZP6RP+NUeb9T1zxU3kLHAi6C72Z7MoW8Rh1rnua
        60bNe/II8S1kTg==
X-Received: by 10.101.85.14 with SMTP id f14mr2106578pgr.45.1500388460916;
        Tue, 18 Jul 2017 07:34:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7243:633f:4c37:513c:babb:cc17])
        by smtp.gmail.com with ESMTPSA id s87sm5847929pfa.86.2017.07.18.07.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 07:34:20 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] doc: reformat the paragraph containing the 'cut-line'
Date:   Tue, 18 Jul 2017 20:04:27 +0530
Message-Id: <20170718143427.3780-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.3.973.gaaf39e6bd.dirty
In-Reply-To: <1500388168.2065.2.camel@gmail.com>
References: <1500388168.2065.2.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The paragraph that describes the 'scissors' cleanup mode of
'commit' had the 'cut-line' in the middle of a sentence. This
made it possible for the line to get wrapped on smaler windows.
This shouldn't be the case as it makes it hard for the user to
understand the structure of the cut-line.

Reformat the pragraph to make the 'cut-line' stand on a line of
it's own thus distinguishing it from the rest of the paragraph.
This further prevents it from getting wrapped to some extent.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/git-commit.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index afb06adba..8c74a2ca0 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -196,11 +196,12 @@ whitespace::
 verbatim::
 	Do not change the message at all.
 scissors::
-	Same as `whitespace`, except that everything from (and
-	including) the line
-	"`# ------------------------ >8 ------------------------`"
-	is truncated if the message is to be edited. "`#`" can be
-	customized with core.commentChar.
+	Same as `whitespace` except that everything from (and including)
+	the line found below is truncated, if the message is to be edited.
+	"`#`" can be customized with core.commentChar.
+
+		# ------------------------ >8 ------------------------
+
 default::
 	Same as `strip` if the message is to be edited.
 	Otherwise `whitespace`.
-- 
2.13.3.973.gaaf39e6bd.dirty

