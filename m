From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: accept --no-signed-off-by-cc as the documentation states
Date: Fri, 3 Mar 2006 01:28:48 -0800
Message-ID: <11413781281157-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 03 10:28:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6ai-0005vz-LX
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWCCJ2u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWCCJ2t
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:28:49 -0500
Received: from hand.yhbt.net ([66.150.188.102]:14467 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751044AbWCCJ2t (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:28:49 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C232F2DC08D;
	Fri,  3 Mar 2006 01:28:48 -0800 (PST)
In-Reply-To: 
X-Mailer: git-send-email
To: junkio@cox.net, ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17150>

--no-signed-off-cc is still supported, for backwards compatibility

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

374f3e5c7fd49c4949df9b29ed03287e6ceb2e2c
diff --git a/git-send-email.perl b/git-send-email.perl
index b0d095b..7c8d512 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -54,7 +54,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "suppress-from" => \$suppress_from,
-		    "no-signed-off-cc" => \$no_signed_off_cc,
+		    "no-signed-off-cc|no-signed-off-by-cc" => \$no_signed_off_cc,
 	 );
 
 # Now, let's fill any that aren't set in with defaults:
-- 
1.2.3.g4676
