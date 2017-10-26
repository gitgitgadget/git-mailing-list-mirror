Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575F31FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 11:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdJZLxk (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 07:53:40 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:49030
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751173AbdJZLxj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2017 07:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1509018818;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=wJ+H4z8sxZdOO8ic5TfHgtrhgmIkeSQl7Ciz5lJjFoI=;
        b=eo85kUg4VQZgJfFmcjktMG8QhmbcgfpCvR2+sFJJcuydhcfU4+A5p/I3wohenVyc
        Wbcp18EaLMEcPyc+482fnPPeuImP1BkjU0Pzq6MilEyydR2nSpVKPkCZLmq5XK/2Oy7
        cgTbZoxt0WCzqgwjS+UXwMDyHSiP2Dek2fhAfzxM=
From:   Sebastian Schuberth <sschuberth@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015f5887d349-1fd2949b-700b-4f16-81a5-4e6aad6bd695-000000@eu-west-1.amazonses.com>
Subject: [PATCH] docs: fix formatting of rev-parse's
 --show-superproject-working-tree
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Oct 2017 11:53:37 +0000
X-SES-Outgoing: 2017.10.26-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-rev-parse.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 0917b8207b9d6..95326b85ff68e 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -264,7 +264,7 @@ print a message to stderr and exit with nonzero status.
 --show-toplevel::
 	Show the absolute path of the top-level directory.
 
---show-superproject-working-tree
+--show-superproject-working-tree::
 	Show the absolute path of the root of the superproject's
 	working tree (if exists) that uses the current repository as
 	its submodule.  Outputs nothing if the current repository is

--
https://github.com/git/git/pull/418
