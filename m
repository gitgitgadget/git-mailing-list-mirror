From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Document git-log --first-parent
Date: Tue, 27 Mar 2007 12:51:38 -0700
Message-ID: <7v8xdio46t.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	<7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
	<7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
	<7vk5x54snc.fsf@assigned-by-dhcp.cox.net>
	<87zm60mrs4.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWHho-000614-8w
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 21:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbXC0Tvl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 15:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbXC0Tvl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 15:51:41 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48243 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbXC0Tvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 15:51:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327195138.RQAZ1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 15:51:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fvre1W00n1kojtg0000000; Tue, 27 Mar 2007 15:51:39 -0400
In-Reply-To: <87zm60mrs4.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
	"Mon, 26 Mar 2007 08:40:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43299>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-log.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 361eaec..030edaf 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -38,6 +38,11 @@ include::pretty-formats.txt[]
 	and <until>, see "SPECIFYING REVISIONS" section in
 	gitlink:git-rev-parse[1].
 
+--first-parent::
+	Follow only the first parent commit upon seeing a merge
+	commit.  This  option gives a better overview of the
+	evolution of a particular branch.
+
 -p::
 	Show the change the commit introduces in a patch form.
 
-- 
1.5.1.rc2.618.g98453b
