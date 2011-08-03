From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] gitattributes: Reword "attribute macro" to "macro attribute"
Date: Wed,  3 Aug 2011 15:41:30 +0200
Message-ID: <1312378890-31703-3-git-send-email-mhagger@alum.mit.edu>
References: <1312378890-31703-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 15:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qobhw-00034p-62
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab1HCNlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 09:41:51 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:53305 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab1HCNlp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 09:41:45 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QobfI-0000wA-Vd; Wed, 03 Aug 2011 15:39:16 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312378890-31703-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178578>

The new wording makes it clearer that such a beast is an attribute in
addition to being a macro (as opposed to being only a macro that is
used for attributes).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/gitattributes.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index ccb3f3f..2bbe76b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -79,7 +79,7 @@ Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
 Sometimes you would need to override an setting of an attribute
-for a path to `unspecified` state.  This can be done by listing
+for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
 
@@ -868,7 +868,7 @@ If this attribute is not set or has an invalid value, the value of the
 (See linkgit:git-config[1]).
 
 
-USING ATTRIBUTE MACROS
+USING MACRO ATTRIBUTES
 ----------------------
 
 You do not want any end-of-line conversions applied to, nor textual diffs
@@ -879,27 +879,27 @@ produced for, any binary file you track.  You would need to specify e.g.
 ------------
 
 but that may become cumbersome, when you have many attributes.  Using
-attribute macros, you can define an attribute that, when set, also
+macro attributes, you can define an attribute that, when set, also
 sets or unsets a number of other attributes at the same time.  The
-system knows a built-in attribute macro, `binary`:
+system knows a built-in macro attribute, `binary`:
 
 ------------
 *.jpg binary
 ------------
 
 Setting the "binary" attribute also unsets the "text" and "diff"
-attributes as above.  Note that attribute macros can only be "Set",
+attributes as above.  Note that macro attributes can only be "Set",
 though setting one might have the effect of setting or unsetting other
 attributes or even returning other attributes to the "Unspecified"
 state.
 
 
-DEFINING ATTRIBUTE MACROS
+DEFINING MACRO ATTRIBUTES
 -------------------------
 
-Custom attribute macros can be defined only in the `.gitattributes` file
-at the toplevel (i.e. not in any subdirectory).  The built-in attribute
-macro "binary" is equivalent to:
+Custom macro attributes can be defined only in the `.gitattributes`
+file at the toplevel (i.e. not in any subdirectory).  The built-in
+macro attribute "binary" is equivalent to:
 
 ------------
 [attr]binary -diff -text
-- 
1.7.6.8.gd2879
