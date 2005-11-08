From: lamikr <lamikr@cc.jyu.fi>
Subject: Diff between the non-head git work dir and non-git kernel sources
Date: Tue, 08 Nov 2005 22:54:32 +0200
Message-ID: <43711088.6070701@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 08 21:57:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZaUa-000765-5e
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 21:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVKHUyk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 15:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVKHUyk
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 15:54:40 -0500
Received: from posti6.jyu.fi ([130.234.4.43]:15515 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S1030277AbVKHUyj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 15:54:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti6.jyu.fi (8.13.4/8.13.4) with ESMTP id jA8Kscqu012398
	for <git@vger.kernel.org>; Tue, 8 Nov 2005 22:54:38 +0200
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.44])
	by posti6.jyu.fi (8.13.4/8.13.4) with ESMTP id jA8KsWuZ012366
	for <git@vger.kernel.org>; Tue, 8 Nov 2005 22:54:32 +0200
Received: from [127.0.0.1] (aragorn.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id 196733F1DB
	for <git@vger.kernel.org>; Tue,  8 Nov 2005 22:54:32 +0200 (EET)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11354>

Hi

I am sorry if this a newbie question, but I have tried to read howtos 
from the web without finding clear documentation or howto to following 
kind of problem.

I have checked out the omap git tree with command

    git-clone rsync://source.mvista.com/git/linux-omap-2.6.git 
linux-omap-2.6

and now I am obviously having the omap kernel head in the linux-omap-2.6 
working directory + hidden ".git" with commit history. In addition I 
have my own "non git" development tree that is made on top of 
traditional kernel snapshots. I however know that the sources in this 
dir reflects to state in git history when following patch was committed

    
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=d24aff0bd3e788d69a45a9d1b1eecda88d847a41

I would now like to revert the sources in git working dir to state that 
was after this d24aff0bd3e788d69a45a9d1b1eecda88d847a41 commit
and then make the diff between that kernel source version and my non-git 
source version and I am now trying to find out what is the "correct" way 
of doing this.

1) If understood the documentation correctly I could move the working 
dir to contain the state after
d24aff0bd3e788d69a45a9d1b1eecda88d847a41 commit in a following way
a) open qgit and mark correct commit with "make tag mytag" command
b) change the files in working dir to be same than during the "mytag" 
commit time by using command git checkout -f mytag
   
Are there simpler method for doing this that uses commit id 
d24aff0bd3e788d69a45a9d1b1eecda88d847a41 directly without need to make 
tag or branch?

2) Does git-diff support making the diff between git's working dir and 
"my non" git kernel source dir.
Or should I just just use normal diff and order that to ignore .git dir 
and .gitignore files?

Mika
