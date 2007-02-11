From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Sun, 11 Feb 2007 09:57:00 -0500
Message-ID: <45CF2EBC.8070107@verizon.net>
References: <20070211084030.GE2082@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 15:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGG9p-0006Hs-0I
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 15:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXBKO6W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 09:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbXBKO6W
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 09:58:22 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:22763 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbXBKO6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 09:58:21 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDB0063406XRPCA@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 11 Feb 2007 08:56:58 -0600 (CST)
In-reply-to: <20070211084030.GE2082@spearce.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39285>

Shawn O. Pearce wrote:
> One of my goals for git-gui is to get it merged into core Git, so
> there is a GUI tool available out-of-the-box for commit creation,
> (some) branch manipulation, basic merging, and pushing/fetching
> changes.
> 
> I'm wondering, should that start to occur as part of 1.5.0?
> Its one .sh script, like gitk.  :)
> 

I have recently moved a project involving multiple companies developing 
on Windows and Linux from cvs(nt) over to git. The availability of 
git-gui at the time was an important point: many folks working this 
project simply will not work at the command line. We are still spinning 
up on git, but several of the developers are relying upon git-gui now 
and I expect that most will use it. So, I am definitely for moving 
git-gui into git. It definitely fits well with the 1.5 usability theme.

Side note: with my gitk fix for Cygwin now in master, git-gui should not 
be deleting ~/.gitk on Cygwin anymore.

Whatever the decision: Shawn - thank you for developing this.

Mark Levedahl
