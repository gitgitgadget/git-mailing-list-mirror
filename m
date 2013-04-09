From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH v2] t/README: --immediate skips cleanup commands for failed
 tests
Date: Tue, 9 Apr 2013 23:48:36 +0200
Message-ID: <20130409214836.GA29630@ruderich.org>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
 <1365356784-24872-6-git-send-email-felipe.contreras@gmail.com>
 <20130407193415.GB13708@ruderich.org>
 <20130407223200.GF19857@elie.Belkin>
 <20130409131802.GA25673@ruderich.org>
 <7vli8rqztj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 23:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPgPU-0008AV-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 23:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936065Ab3DIVso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 17:48:44 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:57415 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935227Ab3DIVso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 17:48:44 -0400
Received: from localhost (pD9F5402D.dip.t-dialin.net [::ffff:217.245.64.45])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Tue, 09 Apr 2013 23:48:36 +0200
  id 000000000000002E.0000000051648CB4.00004F23
Content-Disposition: inline
In-Reply-To: <7vli8rqztj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220640>

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
On Tue, Apr 09, 2013 at 12:16:56PM -0700, Junio C Hamano wrote:
> Sign-off?

Sorry, forgot it.

> Perhaps adding "... to keep the state for inspection by the tester
> to diagnose the bug" or something is in order?

Good idea.

Revised patch is attached.

Regards
Simon

 t/README | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 9b41fe7..e6c060e 100644
--- a/t/README
+++ b/t/README
@@ -86,7 +86,10 @@ appropriately before running "make".
 
 --immediate::
 	This causes the test to immediately exit upon the first
-	failed test.
+	failed test. Cleanup commands requested with
+	test_when_finished are not executed if the test failed to
+	keep the state for inspection by the tester to diagnose
+	the bug.
 
 --long-tests::
 	This causes additional long-running tests to be run (where
-- 
1.8.2.481.g0d034d4

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
