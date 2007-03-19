From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] user-manual: Use def_ instead of ref_ for glossary references.
Date: Sun, 18 Mar 2007 23:17:58 -0400
Message-ID: <39327.3101807155$1174274338@news.gmane.org>
References: <117427428145-git-send-email-> <1174274281887-git-send-email-> <11742742813855-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:18:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8Oa-0000J6-U1
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933815AbXCSDSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933788AbXCSDSI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:18:08 -0400
Received: from mail.fieldses.org ([66.93.2.214]:45760 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933796AbXCSDSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:18:04 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HT8Nl-0003JZ-Md; Sun, 18 Mar 2007 23:18:01 -0400
X-Mailer: git-send-email 1.5.0.3.g6c05
In-Reply-To: <11742742813855-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42568>

From: J. Bruce Fields <bfields@citi.umich.edu>

I'd like to start using references to the glossary in the user manual.
The "ref_" prefix for these references seems a little generic; so
replace with "def_".

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/sort_glossary.pl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sort_glossary.pl b/Documentation/sort_glossary.pl
index 05dc7b2..4ae6290 100644
--- a/Documentation/sort_glossary.pl
+++ b/Documentation/sort_glossary.pl
@@ -50,8 +50,8 @@ This list is sorted alphabetically:
 @keys=sort {uc($a) cmp uc($b)} keys %terms;
 $pattern='(\b(?<!link:git-)'.join('\b|\b(?<!-)',reverse @keys).'\b)';
 foreach $key (@keys) {
-	$terms{$key}=~s/$pattern/sprintf "<<ref_".no_spaces($1).",$1>>";/eg;
-	print '[[ref_'.no_spaces($key).']]'.$key."::\n"
+	$terms{$key}=~s/$pattern/sprintf "<<def_".no_spaces($1).",$1>>";/eg;
+	print '[[def_'.no_spaces($key).']]'.$key."::\n"
 		.format_tab_80($terms{$key})."\n";
 }
 
-- 
1.5.0.3.31.ge47c
