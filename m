From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Do I misunderstand cg-merge --squash option
Date: Thu, 10 Nov 2005 00:25:05 +0000
Message-ID: <200511100025.05993.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 10 01:26:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea0Fa-0005N3-3k
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 01:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVKJAZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 19:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVKJAZG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 19:25:06 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:53378
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751108AbVKJAZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 19:25:05 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1Ea0FU-0002E7-LC
	for git@vger.kernel.org; Thu, 10 Nov 2005 00:25:04 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11454>

I am trying to take my current development repository which has several 
hundred commits in it as I was developing my application and make a 
simplified branch for pushing to my public repository.

I basically created a new branch (public) from the tag at the point where I 
started the repository.

git-checkout -b public initial_commit

I then did a merge

cg-merge --squash v1.0

This seemed to work fine (although it had trouble prompting me with an open 
editor to edit the commit message)

But I don't know how to move forward and merge in changes after my v1.0 tag.  
Any attempt to merge anything else into this "public" branch seems to throw 
up what appears to be merge conflict, but I can't see why - when I look at 
the results one side has extra lines, but there is no other overlap.






-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
