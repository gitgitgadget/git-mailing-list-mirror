From: jidanni@jidanni.org
Subject: [PATCH] Documentation/gitcli.txt: dashed forms not allowed anymore
Date: Thu, 01 Jan 2009 12:39:39 +0800
Message-ID: <87ljtvmygk.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 01 05:41:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIFMm-00025Q-SP
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 05:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbZAAEjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 23:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbZAAEjn
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 23:39:43 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:45833 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754919AbZAAEjm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Dec 2008 23:39:42 -0500
Received: from jidanni.org (122-127-33-78.dynamic.hinet.net [122.127.33.78])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 21BA9D26CC;
	Wed, 31 Dec 2008 20:39:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104290>

Non dashed command forms now mandatory.

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/gitcli.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 29e5929..9f582f6 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -45,8 +45,8 @@ disambiguating `\--` at appropriate places.
 Here are the rules regarding the "flags" that you should follow when you are
 scripting git:
 
- * it's preferred to use the non dashed form of git commands, which means that
-   you should prefer `"git foo"` to `"git-foo"`.
+ * it's required to use the non dashed form of git commands, which means that
+   you must use `"git foo"` and not `"git-foo"`. The latter no longer works.
 
  * splitting short options to separate words (prefer `"git foo -a -b"`
    to `"git foo -ab"`, the latter may not even work).
-- 
1.6.0.6
