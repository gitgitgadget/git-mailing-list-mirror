From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Merge *to* branch instead of merge *from* branch?
Date: Sun, 27 Apr 2008 00:42:23 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.1.00.0804270037220.1149@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 00:43:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpt78-0001Ff-BU
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 00:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271AbYDZWmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 18:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757077AbYDZWmj
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 18:42:39 -0400
Received: from smtp.getmail.no ([84.208.20.33]:56725 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756816AbYDZWmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 18:42:38 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZY0020VF2WC700@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 Apr 2008 00:42:32 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZY00LLFF2O3120@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 Apr 2008 00:42:24 +0200 (CEST)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZY006J6F2O7A1E@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 Apr 2008 00:42:24 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)	id 00A462FC0C; Sun,
 27 Apr 2008 00:42:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id F1D002FC09	for <git@vger.kernel.org>; Sun,
 27 Apr 2008 00:42:23 +0200 (CEST)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80396>

Hi!

My most common use-case of Git is currently somewhere along the lines of

   git checkout master # start from here
   git checkout -b new_branch
   ...edit...
   ...commit...
   git merge master # to make sure I have the latest changes
   ...make sure it all works...
   git checkout master
   git merge new_branch # fast-forwards master to new_branch's HEAD

Is there any way of not having to do the "git checkout master" first? 
Basically I want a flag to merge or checkout saying that I want to merge my 
branch into the branch I'm switching to. I can't seem to find any such flag.

(My problem is not that I have to write two commands, the problem is that 
checking out master and then fast-forwarding it back to where I was is slow, 
working on a network-mapped share on Win32 as I am, and it causes the 
ancient compiler I'm using to re-compile nearly everything, which is also 
slow).

-- 
\\// Peter - http://www.softwolves.pp.se/
