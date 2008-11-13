From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: How to do equivalent of git-status using jgit?
Date: Thu, 13 Nov 2008 10:10:58 -0500
Message-ID: <491C4382.4080602@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 16:13:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0drn-0008Sr-SB
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 16:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYKMPLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 10:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbYKMPK7
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 10:10:59 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:36983 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbYKMPK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 10:10:58 -0500
Received: from [192.168.1.101] ([71.184.206.167]) by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAA00DAP269Y7R5@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 13 Nov 2008 09:10:58 -0600 (CST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100879>


I am making slow but steady progress thanks to all the help from the 
list. Thank you.

I need some guidance on how use jgit to determine what files have 
uncommitted changes in the local workspace and what is their status with 
respect to the GitIndex.

My goal is to implement a method with the following signature:

void commit(String commitMessage) {
  ...
}

I am looking at the doCommit method at:

<http://github.com/myabc/nbgit/tree/master/src/org/nbgit/util/GitCommand.java#L306>

This method takes a list of files. What I need is to somehow determine 
the list of files that need committing.

Thanks for your help.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
