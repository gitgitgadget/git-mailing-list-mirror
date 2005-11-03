From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: little conundrum
Date: Thu, 3 Nov 2005 17:41:20 +0000
Message-ID: <200511031741.20496.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 03 18:43:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXj5Y-0007Ut-VA
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 18:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVKCRlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 12:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbVKCRlW
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 12:41:22 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:63688
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1030367AbVKCRlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 12:41:21 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EXj5U-00066K-Ld
	for git@vger.kernel.org; Thu, 03 Nov 2005 17:41:20 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11079>

I have a little problem I am trying to solve.  Tried a few things and got 
nowhere, so I thought I would ask here.

I have two directories one of which contains a tree of source code that was an 
original software package that I downloaded.  The other contains the result 
of some unfinished - but quite substancial changes that I had made to that 
source code.  Since this was some time ago, I don't have any records, but it 
is quite possible that I added and removed quite a few files.

I would like to make myself a git repository that contains at the start, an 
initial commit of the original downloaded source code, and a second commit on 
the top of that that contains the the current state of play after the changes 
I have made.

Since I don't actually have a list of the files, I thought I would establish 
these automatically by going into each directory and doing a cg-init.  So I 
now have two disjoint repositories each with their source tree in it.

My next thought was to add a branch to one of them and then pull the resultant 
code over and merge it using cg-branch-add followed by a cg-update.  But when 
I do that it complains that there is no common base.  

I tried creating an empty directory and separately merging the two versions 
with it, so that I have a common parent, but whatever I do, I can't get one 
of those nice little gitk diagrams that has any linkage between the two 
versions of the source code.

Is there an approach I could take to achieve what I want?
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
