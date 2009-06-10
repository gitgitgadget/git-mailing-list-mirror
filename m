From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] doc tweak for git-send-email
Date: Wed, 10 Jun 2009 13:56:11 -0400
Message-ID: <1244656571-15560-1-git-send-email-bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 19:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MES29-00035Y-03
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 19:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbZFJR4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbZFJR4K
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 13:56:10 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:36454 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbZFJR4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 13:56:10 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MES1z-00043Z-Dy
	for git@vger.kernel.org; Wed, 10 Jun 2009 13:56:11 -0400
X-Mailer: git-send-email 1.6.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121290>

The git-send-email docs do not mention except in the usage lines
the combined patch formatting/sending ability of git-send-email.
This fills the hole.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-send-email.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index eb851b3..02bb0d3 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -33,6 +33,9 @@ script
 This format expects the first line of the file to contain the "Cc:" value
 and the "Subject:" of the message as the second line.
 
+In addition, git send-email can be asked to generate patches with git
+format-patch and send them.
+
 
 OPTIONS
 -------
-- 
1.6.0.3
