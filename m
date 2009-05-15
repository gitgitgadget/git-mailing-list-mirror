From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Rebase a whole tree from one commit to another?
Date: Fri, 15 May 2009 21:38:53 +0200
Message-ID: <4A0DC4CD.1030401@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 15 21:39:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M53FJ-0000EP-LM
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbZEOTi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbZEOTi4
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:38:56 -0400
Received: from smtprelay09.ispgateway.de ([80.67.31.43]:41165 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbZEOTiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 15:38:55 -0400
Received: from [84.176.112.206] (helo=[192.168.2.100])
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1M53FA-0005u1-DX
	for git@vger.kernel.org; Fri, 15 May 2009 21:38:56 +0200
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119287>

Hi alltogether.

Let's say I have the following history:

     | | | | branch-c
     | | | |
     | | |/  branch-b
     | | |
     | |/    branch-a
     | |
     |/
     | master

Now I checkout master, do some changes, and commit them to the master 
branch. Let's call that new-master:

    | new-master
    | | | | | branch-c
    | | | | |
    | | | |/  branch-b
    | | | |
    | | |/    branch-a
    | | |
    | |/
     \| master

I want to rebase my branches a, b, c to the new master. The clumsy way 
would be:

     git rebase new-master branch-a
     git rebase branch-a   branch-b
     git rebase branch-b   branch-c

The question is: Is there a way to rebase the whole tree (master -> 
branch-a -> branch-b -> branch-c) from master to new-master with a 
single command?


Cheers
   -- Dirk
