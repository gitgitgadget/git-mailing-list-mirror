From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv10 04/11] Minor style fixes to notes.c
Date: Mon, 07 Dec 2009 12:27:27 +0100
Message-ID: <1260185254-1523-5-git-send-email-johan@herland.net>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 12:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHbmI-0007m5-P7
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 12:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933942AbZLGL1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 06:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933799AbZLGL1v
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 06:27:51 -0500
Received: from smtp.getmail.no ([84.208.15.66]:34396 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933882AbZLGL1t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 06:27:49 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUA00L1456I4350@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Dec 2009 12:27:54 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUA002OO5616830@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Dec 2009 12:27:54 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.7.111518
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-reply-to: <1260185254-1523-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134742>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/notes.c b/notes.c
index 023adce..57d5cdc 100644
--- a/notes.c
+++ b/notes.c
@@ -93,7 +93,7 @@ static void **note_tree_search(struct int_node **tree,
 
 	i = GET_NIBBLE(*n, key_sha1);
 	p = (*tree)->a[i];
-	switch(GET_PTR_TYPE(p)) {
+	switch (GET_PTR_TYPE(p)) {
 	case PTR_TYPE_INTERNAL:
 		*tree = CLR_PTR_TYPE(p);
 		(*n)++;
@@ -195,7 +195,7 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 
 	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
 	l = (struct leaf_node *) CLR_PTR_TYPE(*p);
-	switch(GET_PTR_TYPE(*p)) {
+	switch (GET_PTR_TYPE(*p)) {
 	case PTR_TYPE_NULL:
 		assert(!*p);
 		*p = SET_PTR_TYPE(entry, type);
@@ -257,7 +257,7 @@ static void note_tree_free(struct int_node *tree)
 	unsigned int i;
 	for (i = 0; i < 16; i++) {
 		void *p = tree->a[i];
-		switch(GET_PTR_TYPE(p)) {
+		switch (GET_PTR_TYPE(p)) {
 		case PTR_TYPE_INTERNAL:
 			note_tree_free(CLR_PTR_TYPE(p));
 			/* fall through */
-- 
1.6.5.3.433.g11067
