From: James <jtp@nc.rr.com>
Subject: git push refspec problem
Date: Wed, 7 Nov 2007 10:01:53 -0500
Message-ID: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 16:02:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmPz-0000wX-Ef
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbXKGPB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbXKGPB4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:01:56 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:61608 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbXKGPB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:01:56 -0500
Received: from [192.168.1.252] (really [75.182.108.180])
          by cdptpa-omta06.mail.rr.com with ESMTP
          id <20071107150154.TUPI507.cdptpa-omta06.mail.rr.com@[192.168.1.252]>
          for <git@vger.kernel.org>; Wed, 7 Nov 2007 15:01:54 +0000
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63816>

Hi,

I'm trying to set up my git configuration file in one of my projects  
so that I can do a simple "git push" to update my project on the git  
server.

Currently, I run the following command to push my updates (and it  
works just fine):

git push james@my.server.com:~/scm/git/project.git/

In my .git/config file, I've added a line for push, as follows:

[remote "origin"]
         url = git://my.server.com/project.git
         fetch = +refs/heads/*:refs/remotes/origin/*
         push = ssh://james@my.server.com/home/james/scm/git/ 
project.git/

When I run a "git push", it comes back with this error:

fatal: remote part of refspec is not a valid name in ssh://james@my.server.com/home/james/scm/git/project.git/

I've looked at this git push documentation:

http://www.kernel.org/pub/software/scm/git/docs/git-push.html

and it seems like my refspec is indeed correct.  (or so I thought ;))   
Any ideas on what I'm doing wrong?

Thanks!
.james
