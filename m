From: dave rientjes <rientjes@google.com>
Subject: [PATCH] combine-diff.c remove unused return variable
Date: Sun, 13 Aug 2006 17:31:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608131730470.24283@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 02:32:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCQNN-0007KP-1K
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 02:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWHNAb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 20:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWHNAb5
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 20:31:57 -0400
Received: from smtp-out.google.com ([216.239.45.12]:13729 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751518AbWHNAb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 20:31:57 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id k7E0VuxY018409
	for <git@vger.kernel.org>; Sun, 13 Aug 2006 17:31:56 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=bbfiHsLNordb+XuDIx3smOwKo2leQQbJHA5Qxh5DltaDWxYPmtCIxoNfZrDkbh4Is
	QK1Iibrhw6IeP62hAV+cQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps35.corp.google.com with ESMTP id k7E0VsGc015970
	for <git@vger.kernel.org>; Sun, 13 Aug 2006 17:31:54 -0700
Received: by localhost (Postfix, from userid 24081)
	id 81A8C87D71; Sun, 13 Aug 2006 17:31:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 3592487D70
	for <git@vger.kernel.org>; Sun, 13 Aug 2006 17:31:53 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25303>

Removes unused return variable.

		David

Signed-off-by: David Rientjes <rientjes@google.com>

---
 combine-diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index ba8baca..ed85b0e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -617,7 +617,7 @@ static int show_patch_diff(struct combin
 	char *result, *cp;
 	struct sline *sline; /* survived lines */
 	int mode_differs = 0;
-	int i, show_hunks, shown_header = 0;
+	int i, show_hunks;
 	int working_tree_file = !memcmp(elem->sha1, null_sha1, 20);
 	int abbrev = opt->full_index ? 40 : DEFAULT_ABBREV;
 	mmfile_t result_file;
@@ -769,7 +769,7 @@ static int show_patch_diff(struct combin
 	}
 	free(sline[0].p_lno);
 	free(sline);
-	return shown_header;
+	return 0;
 }
 
 #define COLONS "::::::::::::::::::::::::::::::::"
-- 
1.4.2.g182a
