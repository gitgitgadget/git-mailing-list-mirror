From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] Actually use retval
Date: Tue, 22 Mar 2011 13:50:46 +0100 (CET)
Message-ID: <91afab0d46939238dd7c90ea2902b02cae083316.1300798069.git.johannes.schindelin@gmx.de>
References: <cover.1300798069.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 13:50:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2134-0007tO-Sq
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 13:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab1CVMuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 08:50:54 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:38217 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754802Ab1CVMux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 08:50:53 -0400
Received: (qmail invoked by alias); 22 Mar 2011 12:50:48 -0000
Received: from pD9EB235B.dip0.t-ipconnect.de (EHLO noname) [217.235.35.91]
  by mail.gmx.net (mp069) with SMTP; 22 Mar 2011 13:50:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TJQY2JzsTjZNwUq8e4DeHIX1gzYcemC4aLimcUm
	YoQRarS3Bq5FcO
X-X-Sender: gene099@bonsai2
In-Reply-To: <cover.1300798069.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169730>

This is most likely a bug. Nocited by gcc 4.6.0.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Alternatively, retval's declaration and assignment can go.

 tree-diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 3954281..9e2dc70 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -58,7 +58,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2,
 		opt->change(opt, mode1, mode2, sha1, sha2, base->buf, 0, 0);
 	}
 	strbuf_setlen(base, old_baselen);
-	return 0;
+	return retval;
 }
 
 /* A whole sub-tree went away or appeared */
-- 
1.7.4.msysgit.0.167.ge91fd
