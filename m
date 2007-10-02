From: Federico Mena Quintero <federico@novell.com>
Subject: [PATCH 1/4] Say when --track is useful in the git-checkout docs.
Date: Tue, 02 Oct 2007 18:32:32 -0500
Message-ID: <1191367952.3776.196.camel@cacharro.xalalinux.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
	 <1190077881.22387.63.camel@cacharro.xalalinux.org>
	 <7v3axbvbto.fsf@gitster.siamese.dyndns.org>
	 <1191367817.3776.192.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 01:31:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcrCf-0003TP-Td
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 01:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbXJBXay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 19:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbXJBXay
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 19:30:54 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:13743 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbXJBXax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 19:30:53 -0400
Received: from [164.99.193.181] ([164.99.193.181])
	by jericho.provo.novell.com with ESMTP; Tue, 02 Oct 2007 17:30:40 -0600
In-Reply-To: <1191367817.3776.192.camel@cacharro.xalalinux.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59752>

The documentation used to say what the option does, but it
didn't mention a use case.

Signed-off-by: Federico Mena Quintero <federico@gnu.org>
---
 Documentation/git-checkout.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 734928b..dbd1a4a 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -50,7 +50,9 @@ OPTIONS
 --track::
 	When -b is given and a branch is created off a remote branch,
 	set up configuration so that git-pull will automatically
-	retrieve data from the remote branch.  Set the
+	retrieve data from the remote branch.  Use this if you always
+	pull from the same remote branch into the new branch, or if you
+	don't want to use "git pull <repository> <refspec>" explicitly.  Set the
 	branch.autosetupmerge configuration variable to true if you
 	want git-checkout and git-branch to always behave as if
 	'--track' were given.
-- 
1.5.2.4
