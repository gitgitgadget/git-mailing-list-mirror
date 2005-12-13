From: Jon Nelson <jnelson-git@jamponi.net>
Subject: git commit improvement request
Date: Tue, 13 Dec 2005 13:49:51 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0512131347000.6812@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Dec 13 20:55:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmGE4-0003S4-D8
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 20:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVLMTyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 14:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbVLMTyK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 14:54:10 -0500
Received: from mtao02.charter.net ([209.225.8.187]:1195 "EHLO
	mtao02.charter.net") by vger.kernel.org with ESMTP id S932603AbVLMTyJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 14:54:09 -0500
Received: from mxip36-10.charter.net ([10.20.203.76]) by mtao02.charter.net
          (InterMail vM.6.01.05.04 201-2131-123-105-20051025) with ESMTP
          id <20051213195049.POOP18406.mtao02.charter.net@mxip36-10.charter.net>
          for <git@vger.kernel.org>; Tue, 13 Dec 2005 14:50:49 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip36-10.charter.net with ESMTP; 13 Dec 2005 14:49:55 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id 5FEC1F01D; Tue, 13 Dec 2005 13:49:51 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id 45D49F01C
	for <git@vger.kernel.org>; Tue, 13 Dec 2005 13:49:51 -0600 (CST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13586>


There is a small improvement I would like to see it 'git commit'.
I am using 0.99.9i at this moment.

If I perform a 'git commit' on a series of files, and then decide not to 
perform the commit, I can back out of the operation with a blank commit 
message. Additionally, it would be nice for git commit to recognize a 
non-zero exit code theoretically indicating 'aborted commit'. In any 
case, the problem is that, even though git /states/ that it has aborted 
the commit due to the empty commit message, git diff /appears/ to show 
that the commit took place. a 'git reset' takes care of things for me 
but it was rather confusing at first and it seems counter-intuitive. I'm 
hoping that the behavior here can be changed before 1.0 is released, 
which I am in eager anticipation for.  Thanks!


--
Jon Nelson <jnelson-git@jamponi.net>
