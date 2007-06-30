From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-remote: document -n
Date: Sat, 30 Jun 2007 20:56:16 +1200
Message-ID: <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:56:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4Yku-00065T-Gs
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbXF3I43 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbXF3I42
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:28 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56657 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbXF3I4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:25 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykg-0008U1-DB; Sat, 30 Jun 2007 20:56:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 5A82B5CE00; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51201>

From: Sam Vilain <sam@vilain.net>

The 'show' and 'prune' commands accept an option '-n'; document what
it does.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/git-remote.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index ab232c2..61a6022 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -49,6 +49,9 @@ branch the `HEAD` at the remote repository actually points at.
 'show'::
 
 Gives some information about the remote <name>.
++
+With `-n` option, the remote heads are not queried first with
+`git ls-remote <name>`; cached information is used instead.
 
 'prune'::
 
@@ -56,6 +59,10 @@ Deletes all stale tracking branches under <name>.
 These stale branches have already been removed from the remote repository
 referenced by <name>, but are still locally available in
 "remotes/<name>".
++
+With `-n` option, the remote heads are not confirmed first with `git
+ls-remote <name>`; cached information is used instead.  Use with
+caution.
 
 'update'::
 
-- 
1.5.2.1.1131.g3b90
