Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87A2220A26
	for <e@80x24.org>; Sun, 17 Sep 2017 05:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750811AbdIQF2u (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 01:28:50 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:48668
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750743AbdIQF2u (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 01:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1505626128;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=G/3nikPcCL84ejBTpj3xBhVuJOyT+bhJgUTQbbwW1FA=;
        b=GJtkQWI+iJXUCsHgAX+OPDjLEdKKMsfuwwyQOIFPr4I/cf0087gPRo2Q1wyEEtqx
        bm/l1WVtKlvmKlGRzsbUx2bBTRI5QH0J+mP61hfcgKJ1fT2aQecZOTjxsM4ZcwKDaTq
        BN6fUi++Euh/p/0l/s4qW0c7ApDR6wAHyURcYnRs=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015e8e4f7e75-dfec22a3-bb1a-4208-a069-450275d52b6d-000000@eu-west-1.amazonses.com>
Subject: [PATCH] doc: update information about windows build
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Sep 2017 05:28:48 +0000
X-SES-Outgoing: 2017.09.17-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

029aeeed5 (travis-ci: build and test Git on Windows, 2017-03-24) added
support for testing the git build for Windows.

So, update the documentation and the example used in it.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/SubmittingPatches | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b656a0..43c9b9ae49298 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -395,8 +395,9 @@ GitHub-Travis CI hints
 
 With an account at GitHub (you can get one for free to work on open
 source projects), you can use Travis CI to test your changes on Linux,
-Mac (and hopefully soon Windows).  You can find a successful example
-test build here: https://travis-ci.org/git/git/builds/120473209
+Mac.  Though Travis CI doesn't support Windows we have worked around
+that temporarily!  You can find a successful example test build
+here: https://travis-ci.org/git/git/builds/264560175
 
 Follow these steps for the initial setup:
 

--
https://github.com/git/git/pull/402
