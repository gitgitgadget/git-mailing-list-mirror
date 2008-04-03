From: Jordan Miller <jmil@rice.edu>
Subject: using git for file management while writing a thesis...
Date: Thu, 3 Apr 2008 15:58:21 -0500
Message-ID: <56810483-5257-49CD-AA0E-303DB6C4CEFB@rice.edu>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 23:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhWxX-0003c4-EP
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 23:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbYDCV0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 17:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbYDCV0O
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 17:26:14 -0400
Received: from smtp2.mail.rice.edu ([128.42.206.129]:21441 "EHLO
	mh2.mail.rice.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755795AbYDCV0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 17:26:13 -0400
X-Greylist: delayed 1667 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Apr 2008 17:26:13 EDT
Received: from mh2.mail.rice.edu (localhost.localdomain [127.0.0.1])
	by mh2.mail.rice.edu (Postfix) with ESMTP id 4454A36D535
	for <git@vger.kernel.org>; Thu,  3 Apr 2008 15:58:24 -0500 (CDT)
X-Virus-Scanned: by amavis-2.4.4 at mh2.mail.rice.edu
Received: from mh2.mail.rice.edu ([127.0.0.1])
	by mh2.mail.rice.edu (mh2.mail.rice.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0sINz9lZLFyD for <git@vger.kernel.org>;
	Thu,  3 Apr 2008 15:58:24 -0500 (CDT)
Received: from [192.168.2.10] (c-98-195-201-177.hsd1.tx.comcast.net [98.195.201.177])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mh2.mail.rice.edu (Postfix) with ESMTP id C268136D51D
	for <git@vger.kernel.org>; Thu,  3 Apr 2008 15:58:23 -0500 (CDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78781>

Hello,

Thank you to the developers for Git!

I am using git 1.5.3.1 on OS X 10.5.2 for file versioning for LaTeX  
files while writing my thesis. I have looked at other possible ways to  
manage text files while writing a thesis, but I think git is the best  
one available.

I am a bit confused on how best to create backups of my commits on  
external hard drives and USB keys.

After I had created my git repository on my local hard drive, I  
connected an external hard drive and a USB key and peformed a "git  
clone" from local to external. Everything was very quick.

Now, every day I stage files and perform a commit on my local drive to  
my local repository. Then, I connect my external hard drives and  
perform a "git pull" from each of their repositories on the repository  
on my local drive to update these external hard drive repositories and  
also checkout the latest files to these external repositories.

The problem I am having is as follows:
Everything works beautifully and incredibly speedily on my external  
3.5" hard drive connected via Firewire.
On my USB keys, a huge number of changes are seen and git takes a very  
long time assessing ("deltifying") what are the changes needed (more  
than 10 times the number of files are deltified!). Shouldn't git just  
realize that it only needs to make the changes that were made in the  
last commit, or am I using the "pull" command incorrectly?

Why would it take so long for a "pull" command to happen on the USB2  
key while it is extremely fast on an external drive? I have also tried  
wiping the USB key and issuing a new "git clone" command, and that  
happens extremely fast. But, shouldn't it be even faster to pull only  
the latest commit onto the USB key?

Finally, I have also tried changing the disk formatting of the USB key  
to try to diagnose the problem. However, the problem is the same  
whether the format of the USB key is HFS+ Journaled or MS-DOS FAT32.

So, my question is what am I doing wrong with "git pull" and is there  
a better way to use git for the task at hand? Unfortunately, I have  
not yet been able to find a solution anywhere on the  
interwebnetblagosphere.


thanks in advance,
Jordan
