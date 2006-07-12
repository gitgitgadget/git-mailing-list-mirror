From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb.css: Courer fonts for commits and tree-diff
Date: Tue, 11 Jul 2006 23:02:35 -0700
Message-ID: <7vac7f1htw.fsf@assigned-by-dhcp.cox.net>
References: <20060712034323.48414.qmail@web31806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 08:03:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0XoY-0002GW-I3
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 08:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWGLGCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 02:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWGLGCj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 02:02:39 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43401 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751354AbWGLGCi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 02:02:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712060237.FXKE8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 02:02:37 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060712034323.48414.qmail@web31806.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 11 Jul 2006 20:43:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23764>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Courer fonts for the commit header, commit message,
> and tree-diff.
>
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

I really do not want to be in the position to judge a patch like
this, whose evaluation is solely based on "prettiness" factor.

But if I really have to, I would say this makes things uglier
and less readable.  Maybe asking for monospace is less yucky but
naming Courier explicitly?

BTW what tool do you use to generate and send your patches?  I
remember another patch from you recently did not apply and it
turned out the problem was that the last hunk had line numbers
wrong.  This patch has exactly the same problem and I am
wondering why.

I count 10 lines of original and 15 lines of new material in
this hunk but the hunk header claims to have 11 lines of
original text.

---
 gitweb/gitweb.css |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 98410f5..b51282b 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
 ... 
@@ -142,11 +144,15 @@ table {
 	padding: 8px 4px;
 }
 
-table.project_list, table.diff_tree {
+table.project_list {
 	border-spacing: 0;
 }
 
+table.diff_tree {
+	border-spacing: 0;
+	font-family: courier;
+}
+
 table.blame {
 	border-collapse: collapse;
 }
-- 
1.4.1.g9ca3
