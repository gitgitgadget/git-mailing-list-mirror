From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 3/6] Remove return undef from ask()
Date: Wed, 29 Apr 2009 09:12:20 -0400
Message-ID: <1241010743-7020-4-git-send-email-wfp5p@virginia.edu>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-3-git-send-email-wfp5p@virginia.edu>
Cc: gitster@pobox.com, Bill Pemberton <wfp5p@virginia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 15:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9ee-0003wt-2t
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760245AbZD2NMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 09:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760121AbZD2NM3
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:12:29 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:37683 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760196AbZD2NM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 09:12:26 -0400
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id EA43757055; Wed, 29 Apr 2009 09:12:23 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1241010743-7020-3-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117885>

Returning undef is rarely the correct way to return a failure.
Replace it with bare return

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 067aaf0..1ed5869 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -633,7 +633,7 @@ sub ask {
 			return $resp;
 		}
 	}
-	return undef;
+	return;
 }
 
 my $prompting = 0;
-- 
1.6.0.6
