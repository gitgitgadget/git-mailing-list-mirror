From: Kai Schlamp <schlamp@gmx.de>
Subject: Beginner problem with .gitignore
Date: Mon, 20 Apr 2009 19:57:11 +0200
Message-ID: <gsid27$p1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 19:59:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvxm1-0007DQ-30
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 19:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbZDTR5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 13:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbZDTR5m
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 13:57:42 -0400
Received: from main.gmane.org ([80.91.229.2]:54114 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbZDTR5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 13:57:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LvxkP-0000Yb-3u
	for git@vger.kernel.org; Mon, 20 Apr 2009 17:57:37 +0000
Received: from p54a8c166.dip.t-dialin.net ([84.168.193.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 17:57:37 +0000
Received: from schlamp by p54a8c166.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 17:57:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54a8c166.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117012>

Hello.

I have a file called TitleAreaDialog.java in the folder
my_path\org.eclipse.jface\src\org\eclipse\jface\dialogs

.git and .gitignore is in the my_path\ folder (using Git Cygwin on Windows).

Now I everything is ignored from org.eclipse.jface, but not that 
TitleAreaDialog.java

So I specified the following in .gitignore:
/org.eclipse.*
!TitleAreaDialog.java

I also tried it with:
!Title*, 
!/org.eclipse.jface/src/org/eclipse/jface/dialogs/TitleAreaDialog.java

but the TitleAreaDialog is always ignored as well.

What do I have to do to not ignore this file specifically?

Best regards,
Kai
