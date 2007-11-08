From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH] git-send-email: Change the prompt for the subject of the initial message.
Date: Thu,  8 Nov 2007 19:56:28 +0100
Message-ID: <1194548188-9865-1-git-send-email-tsuna@lrde.epita.fr>
Cc: gitster@pobox.com, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 19:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqCZD-0006fQ-Qk
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 19:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762420AbXKHS4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 13:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762677AbXKHS4g
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 13:56:36 -0500
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:63756 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1762672AbXKHS4f (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 13:56:35 -0500
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id 48395C85211; Thu,  8 Nov 2007 19:56:28 +0100 (CET)
X-Mailer: git-send-email 1.5.3.4.398.g859b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64063>

I never understood what this prompt was asking for until I read the actual
source code.  I think this wording is much more understandable.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f4b8f96..f9bd2e5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -352,7 +352,7 @@ sub expand_aliases {
 
 if (!defined $initial_subject && $compose) {
 	do {
-		$_ = $term->readline("What subject should the emails start with? ",
+		$_ = $term->readline("What subject should the initial email start with? ",
 			$initial_subject);
 	} while (!defined $_);
 	$initial_subject = $_;
-- 
1.5.3.4.398.g859b
