From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv9 04/11] Minor style fixes to notes.c
Date: Wed, 02 Dec 2009 03:09:36 +0100
Message-ID: <1259719783-4674-5-git-send-email-johan@herland.net>
References: <1259719783-4674-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 03:11:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFegN-0005pp-RI
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbZLBCKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 21:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbZLBCKQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:10:16 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61703 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754468AbZLBCKM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 21:10:12 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU0004GH614PL70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:16 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU000JVB60NVI30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:16 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.2.15716
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-reply-to: <1259719783-4674-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134292>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/notes.c b/notes.c
index 50a4672..812aeb9 100644
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
