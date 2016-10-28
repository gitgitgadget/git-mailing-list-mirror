Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55EC42035F
	for <e@80x24.org>; Fri, 28 Oct 2016 15:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936343AbcJ1PIK (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 11:08:10 -0400
Received: from stcim.de ([78.46.73.102]:54054 "EHLO stcim"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933523AbcJ1PIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 11:08:09 -0400
Received: from 55d41b26.access.ecotel.net ([85.212.27.38] helo=localhost.localdomain)
        by stcim with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <contact@stefanchrist.eu>)
        id 1c08lJ-0002jC-Ro; Fri, 28 Oct 2016 17:08:05 +0200
From:   Stefan Christ <contact@stefanchrist.eu>
To:     git@vger.kernel.org
Cc:     rpjday@crashcourse.ca, peff@peff.net
Subject: [PATCH v2] Documentation: fmt-merge-msg: fix markup in example
Date:   Fri, 28 Oct 2016 17:07:24 +0200
Message-Id: <1477667244-17887-1-git-send-email-contact@stefanchrist.eu>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <alpine.LFD.2.20.1610280623400.524@localhost.localdomain>
References: <alpine.LFD.2.20.1610280623400.524@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The example was not rendered as verbatim text. Fix it.

Signed-off-by: Stefan Christ <contact@stefanchrist.eu>
---
v2: fix misspelling in subject

Hi,

thanks to rday for spotting the typo in the subject line (I missed to
autoenable the spell checking in vim) and thanks to Peff for the asciidoc
explanation.

Kind regards,
	Stefan Christ
---
 Documentation/git-fmt-merge-msg.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 6526b17..44892c4 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -60,10 +60,10 @@ merge.summary::
 EXAMPLE
 -------
 
---
+---------
 $ git fetch origin master
 $ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
---
+---------
 
 Print a log message describing a merge of the "master" branch from
 the "origin" remote.
-- 
2.7.3

