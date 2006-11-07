X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Tero Roponen <teanropo@jyu.fi>
Subject: [PATCH] remove an unneeded test
Date: Tue, 7 Nov 2006 12:44:33 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0611071239560.18014@jalava.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 7 Nov 2006 10:45:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at cc.jyu.fi
X-X-Sender: teanropo@jalava.cc.jyu.fi
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31061>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhORf-0002nP-1C for gcvg-git@gmane.org; Tue, 07 Nov
 2006 11:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754178AbWKGKoh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 05:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbWKGKoh
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 05:44:37 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:53942 "EHLO posti5.jyu.fi") by
 vger.kernel.org with ESMTP id S1754178AbWKGKog (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 05:44:36 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by posti5.jyu.fi
 (8.13.6/8.13.6) with ESMTP id kA7AiYor003142 for <git@vger.kernel.org>; Tue,
 7 Nov 2006 12:44:34 +0200
Received: from posti5.jyu.fi ([127.0.0.1]) by localhost (posti5.jyu.fi
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id nYeZ5bnLYCEq for
 <git@vger.kernel.org>; Tue,  7 Nov 2006 12:44:34 +0200 (EET)
Received: from jalava.cc.jyu.fi (jalava.cc.jyu.fi [130.234.4.50]) by
 posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id kA7AiXoJ003137 for
 <git@vger.kernel.org>; Tue, 7 Nov 2006 12:44:33 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


In wt-status.c there is a test which does nothing.
This patch removes it.

Signed-off-by: Tero Roponen <teanropo@jyu.fi>

diff --git a/wt-status.c b/wt-status.c
index 9692dfa..7943944 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -102,8 +102,6 @@ static void wt_status_print_updated_cb(s
 	struct wt_status *s = data;
 	int shown_header = 0;
 	int i;
-	if (q->nr) {
-	}
 	for (i = 0; i < q->nr; i++) {
 		if (q->queue[i]->status == 'U')
