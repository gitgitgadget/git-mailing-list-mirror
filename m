From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] blameview: Support browsable functionality to blameview.
Date: Tue, 30 Jan 2007 02:33:56 -0800
Message-ID: <7vfy9s248b.fsf@assigned-by-dhcp.cox.net>
References: <11701438112263-git-send-email-> <11701438241247-git-send-email->
	<45befa66.29cc817d.6c37.ffffa9bc@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 11:34:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBqJQ-0005gS-1Z
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 11:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148AbXA3Kd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 05:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933151AbXA3Kd7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 05:33:59 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:40936 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933149AbXA3Kd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 05:33:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070130103356.SFD4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jan 2007 05:33:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HNaG1W00a1kojtg0000000; Tue, 30 Jan 2007 05:34:17 -0500
In-Reply-To: <45befa66.29cc817d.6c37.ffffa9bc@mx.google.com> (Aneesh Kumar
	K. V.'s message of "Tue, 30 Jan 2007 13:26:50 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38150>

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

> From: Aneesh Kumar K.V <aneesh.kumar@gmail.com> - unquoted

Sorry, my fault.

-- >8 --
[PATCH] git-send-email: remove debugging output.

rfc2047 unquoter spitted out an annoying "- unquoted" which was
added during debugging but I forgot to remove.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8dc2ee0..6a285bf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -408,7 +408,7 @@ sub unquote_rfc2047 {
 		s/_/ /g;
 		s/=([0-9A-F]{2})/chr(hex($1))/eg;
 	}
-	return "$_ - unquoted";
+	return "$_";
 }
 
 sub send_message
-- 
1.5.0.rc2.77.g1732a
