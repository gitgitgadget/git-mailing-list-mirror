From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: How to do equivalent of "git-reset --hard" and "git revert HEAD" using
 jgit?
Date: Thu, 13 Nov 2008 12:43:16 -0500
Message-ID: <491C6734.2060607@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 18:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0gF6-0000Ia-H1
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 18:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYKMRnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 12:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbYKMRnR
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 12:43:17 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:53005 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbYKMRnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 12:43:16 -0500
Received: from [192.168.1.101] ([71.184.206.167]) by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAA00DB3983S5Q2@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 13 Nov 2008 11:43:16 -0600 (CST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100891>


I need some guidance on how use jgit to implement the following methods:


     /**
      * Rolls back all uncommitted changes so Index and worspace are 
rolled to committed state in HEAD version.
      * Functionally equivalent to "git reset --hard HEAD"
      *
      */
     public void rollback() {
     }

     /**
      * Undoes the last commit.
      * Functionally equivalent to "git revert HEAD"
      *
      * @param versionNameToRevertTo Version of Commit to revert to
      */
     public void revert(String versionNameToRevertTo) {
     }

It seems that I will have to walk the Tree and check status of each file 
to decide what to do with it. The TreeWalk api is not obvious from the 
javadoc.


TIA for any guidance you can provide.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
