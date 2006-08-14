From: David Rientjes <rientjes@google.com>
Subject: [PATCH 03/28] makes checkout_all void
Date: Mon, 14 Aug 2006 13:20:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141319180.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:20:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCivc-0006LO-Pp
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbWHNUUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWHNUUc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:20:32 -0400
Received: from smtp-out.google.com ([216.239.45.12]:48526 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932712AbWHNUUb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:20:31 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id k7EKKDZr031475
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:20:15 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=hlI8pboFeaAQ165OrJj2J67KVNJRYjY8xTLcZ30+gkIjIX8/Luu1iSV0krHdAraEh
	+Nd4L2Q1E7HyUvpVn5mRQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps35.corp.google.com with ESMTP id k7EKKCLb000385
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:20:12 -0700
Received: by localhost (Postfix, from userid 24081)
	id DE56F87D71; Mon, 14 Aug 2006 13:20:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id DA38387D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:20:12 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25383>

Makes checkout_all void.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-checkout-index.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 8d0dbad..6b55f93 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -122,7 +122,7 @@ static int checkout_file(const char *nam
 	return -1;
 }
 
-static int checkout_all(const char *prefix, int prefix_length)
+static void checkout_all(const char *prefix, int prefix_length)
 {
 	int i, errs = 0;
 	struct cache_entry* last_ce = NULL;
@@ -153,7 +153,6 @@ static int checkout_all(const char *pref
 		 * exit with the same code as die().
 		 */
 		exit(128);
-	return 0;
 }
 
 static const char checkout_cache_usage[] =
-- 
1.4.2.g89bb-dirty
