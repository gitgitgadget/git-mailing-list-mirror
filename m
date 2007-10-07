From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: How to pick a commit from another git tree?
Date: Sun, 7 Oct 2007 19:31:00 +0200
Message-ID: <000101c80907$d461a810$04ac10ac@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 19:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZyJ-0005nS-Lp
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 19:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbXJGRbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 13:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754208AbXJGRbH
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 13:31:07 -0400
Received: from mail.transmode.se ([83.241.175.147]:18755 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754170AbXJGRbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 13:31:06 -0400
Received: from Jocke ([84.217.95.61]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sun, 7 Oct 2007 19:31:01 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: AcgJB9QXa8UghsMNR+uXF2FXl7iqjg==
X-OriginalArrivalTime: 07 Oct 2007 17:31:01.0370 (UTC) FILETIME=[D471ADA0:01C80907]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60205>

Hi 

This is probably a somewhat stupid question but I havn't had a need until now so here goes:
There is a commit in David Millers tree:
http://git.kernel.org/?p=linux/kernel/git/davem/bak-net-2.6.24.git;a=commit;h=bbb4c0c35a4c2aed5e025b668c8dfc99c5b74cff
that hasn't made it into 2.6.23, but will go into 2.6.24. 
I need this fix on top of 2.6.23(once it is released).
Now I wonder how to best add this fix to my tree. Once this fix hits linus tree and I pull
linus tree, I don't wan't a conflict as I already have this fix in my tree.

Should I just pull Davids tree? Or should I cherry-pick this one commit?
Or something else?

 Jocke
