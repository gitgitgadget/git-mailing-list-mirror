From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] contrib/hooks/post-receive-email: add a From: line to the email header
Date: Thu, 8 Nov 2007 09:48:09 +0000
Message-ID: <20071108094809.22151.qmail@97f06c2e73713e.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:48:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3zX-0007k5-Nq
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758721AbXKHJrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758702AbXKHJrs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:47:48 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:47712 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758577AbXKHJrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:47:48 -0500
Received: (qmail 22152 invoked by uid 1000); 8 Nov 2007 09:48:09 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63984>

$committer is already extracted from the latest existing rev, so add the
corresponding From: line to the email header.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 contrib/hooks/post-receive-email |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 3904c18..c73f2d5 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -189,6 +189,7 @@ generate_email_header()
 	# --- Email (all stdout will be the email)
 	# Generate header
 	cat <<-EOF
+	From: $committer
 	To: $recipients
 	Subject: ${emailprefix}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
 	X-Git-Refname: $refname
-- 
1.5.3.5
