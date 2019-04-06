Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0CE20248
	for <e@80x24.org>; Sat,  6 Apr 2019 13:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDFN1z (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 09:27:55 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:32092 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDFN1z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 09:27:55 -0400
Received: from localhost.localdomain ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id ClMPhui0snuQZClMPhhS4S; Sat, 06 Apr 2019 14:27:54 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=xtxXYLxNAAAA:8 a=B3RH6Lifwnz01wBJw0cA:9 a=-KTYnT8EMnQPRz2f:21
 a=Al4F8JyZJqYHe3Gq:21 a=xts0dhWdiJbonKbuqhAr:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Subject: [PATCH 2/2] describe doc: remove '7-char' abbreviation reference
Date:   Sat,  6 Apr 2019 14:27:47 +0100
Message-Id: <20190406132747.16376-3-philipoakley@iee.org>
X-Mailer: git-send-email 2.21.0.windows.1.80.gdc2ae9a382
In-Reply-To: <20190406132747.16376-1-philipoakley@iee.org>
References: <20190406132747.16376-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCPPHvF92TMdMvb2c5bNXaQnNLeH/FS2/GFZ3J0ouiR8WetOi3qU3KjiNOEYHjj5Gwamiy8XBpl3sjgWs5U4yiic5B+E11KwtyDfWXQ9BEdUh7XsV/iV
 lw8ElPZP0Dk9LN2QXpEZCLCPFfL3qKdqNqyyjHpVN4kpismYJEbXVQaRtvZl/VHYrEzxBzrrELo/Ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the minimum is 7-char, the unambiguous length can be longer.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
noticed while looking int the Git-for-Windows patch thicket -
was looking for the ~n^m style!
---
 Documentation/git-describe.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index ccdc5f83d6..a88f6ae2c6 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -139,7 +139,7 @@ at the end.
 
 The number of additional commits is the number
 of commits which would be displayed by "git log v1.0.4..parent".
-The hash suffix is "-g" + 7-char abbreviation for the tip commit
+The hash suffix is "-g" + unambiguous abbreviation for the tip commit
 of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
 The "g" prefix stands for "git" and is used to allow describing the version of
 a software depending on the SCM the software is managed with. This is useful
-- 
2.21.0.windows.1.80.gdc2ae9a382

