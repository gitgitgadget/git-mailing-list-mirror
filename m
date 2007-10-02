From: Federico Mena Quintero <federico@novell.com>
Subject: [PATCH 3/4] Note that git-branch will not automatically checkout
	the new branch
Date: Tue, 02 Oct 2007 18:34:32 -0500
Message-ID: <1191368072.3776.201.camel@cacharro.xalalinux.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
	 <1190077881.22387.63.camel@cacharro.xalalinux.org>
	 <7v3axbvbto.fsf@gitster.siamese.dyndns.org>
	 <1191367817.3776.192.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 01:33:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcrEb-000463-PV
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 01:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568AbXJBXcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 19:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbXJBXcz
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 19:32:55 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:13827 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbXJBXcy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 19:32:54 -0400
Received: from [164.99.193.181] ([164.99.193.181])
	by jericho.provo.novell.com with ESMTP; Tue, 02 Oct 2007 17:32:40 -0600
In-Reply-To: <1191367817.3776.192.camel@cacharro.xalalinux.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59755>


Signed-off-by: Federico Mena Quintero <federico@gnu.org>
---
 Documentation/git-branch.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index e9c12f9..53c1158 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -26,6 +26,10 @@ It will start out with a head equal to the one given as <start-point>.
 If no <start-point> is given, the branch will be created with a head
 equal to that of the currently checked out branch.
 
+Note that this will create the new branch, but it will not switch the
+working tree to it; use "git checkout <newbranch>" to switch to the
+new branch.
+
 When a local branch is started off a remote branch, git can setup the
 branch so that gitlink:git-pull[1] will appropriately merge from that
 remote branch.  If this behavior is desired, it is possible to make it
-- 
1.5.2.4
