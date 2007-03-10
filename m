From: Anton Tropashko <atropashko@yahoo.com>
Subject: Re: Errors cloning large repo
Date: Fri, 9 Mar 2007 18:37:55 -0800 (PST)
Message-ID: <645002.46177.qm@web52608.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 03:38:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPrTA-0008OR-OO
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 03:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993164AbXCJCh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 21:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993163AbXCJCh6
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 21:37:58 -0500
Received: from web52608.mail.yahoo.com ([206.190.48.211]:25937 "HELO
	web52608.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1767731AbXCJCh5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2007 21:37:57 -0500
Received: (qmail 48427 invoked by uid 60001); 10 Mar 2007 02:37:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=llfzNuziyJtNUtyuUYAuM+fHiYhdhnuExMDWYI47rVih1Bzgv1IjxNLXNE+cPrBo98Wwa2iUUnGogLh1ymwefPiKEeSS8lbDVElhJT+TZuFCjDTFPoQ5wb+aGHxOWEAuJZCYOMJX7n1mS3oUqEIZ8Ar98zxPQWdLz8Zlb+VR/qc=;
X-YMail-OSG: Om2MQ_YVM1nSaXdU3HigfkfZotRUr1mVCuNtA9a0S0fdUOq7MOi25a6O_lJwmPJ9UQDz7xm4e8l7RV7Vu6rTcfwtmnyCxtLrPRB0MfZ1Q.HKCHzZweiMJ1ZxwXrymrOef2WH1frMm3OMPGLbVR3RLzq_UA--
Received: from [144.189.5.201] by web52608.mail.yahoo.com via HTTP; Fri, 09 Mar 2007 18:37:55 PST
X-Mailer: YahooMailRC/471 YahooMailWebService/0.6.132.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41842>

> I suspect we shouldn't bother with the diffstat for the initial commit. 
> Just removing "--root" migth be sufficient.

My problem is git-clone though since for commit it's no big deal
to git commit [a-c]* , or use xargs as a workaround

For git clone I got this

Deltifying 144511 objects.
 100% (144511/144511) done
1625.375MB  (1713 kB/s)       
1729.057MB  (499 kB/s)       
/usr/bin/git-clone: line 321: 24360 File size limit exceededgit-fetch-pack --all -k $quiet "$repo"

again after git repack and don't see how to work around that aside from artifically
splitting the tree at the top or resorting to a tarball on an ftp site.
That 64 bit indexing code you previously mentioned would force me to upgrade git on both ends?
Anywhere I can pull it out from?






 
____________________________________________________________________________________
Food fight? Enjoy some healthy debate 
in the Yahoo! Answers Food & Drink Q&A.
http://answers.yahoo.com/dir/?link=list&sid=396545367
