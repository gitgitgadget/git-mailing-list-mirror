From: Bill Priest <priestwilliaml@yahoo.com>
Subject: How to have multiple working copy directories use the same repository?
Date: Thu, 11 Oct 2007 11:10:50 -0700 (PDT)
Message-ID: <744844.82514.qm@web55015.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 20:17:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig2bQ-0007Sy-Hc
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 20:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbXJKSRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 14:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756323AbXJKSRd
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 14:17:33 -0400
Received: from web55015.mail.re4.yahoo.com ([206.190.58.149]:38074 "HELO
	web55015.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756057AbXJKSRc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2007 14:17:32 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2007 14:17:32 EDT
Received: (qmail 83185 invoked by uid 60001); 11 Oct 2007 18:10:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=vcfZJ8XwSjsNt6hk/t9lU40qItNqllI0f+ihEIKHe4sYpTPEPPUhTFzqoNrMj/qYVFjU/VzLHspOK1hCaP5rMrwKrqc47uW8koQNtzExpFlFvv5FA5dR2eatTZBnN+kLKazqnMJSWT84Hokd9ED1Nq7alIVaFirHBd3kwg0RpC4=;
X-YMail-OSG: 2bO9BxEVM1ma8COQ66tOleiGBoGyDBxaKB1_A5aMaorjI6r57yjC1UZTkcvSMvEoChTqQw77ioMe8ipLnk6ffVkwXiJ8Tx_JKY3Ih9Aeflrz2w.mIlPXW7L3650HJ5JuapwQncSZ9sirdyXYKYk9xUajIw--
Received: from [12.44.137.148] by web55015.mail.re4.yahoo.com via HTTP; Thu, 11 Oct 2007 11:10:50 PDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60622>

All,
  My current business requirements make it
advantageous to have two concurrent working
directories (that have similar file structure; but not
exactly the same); I need to maintain two separate
builds that are always up to date.  Each working
directory would be associated with a particular
branch/line of branches (think of two different
hardware platforms that have considerable overlap).  A
complication to this is that I need to use git-svn as
the remainder of the team uses svn (I just changed
from cvs to svn last Jan so it is a hard sell to
management to change again).  I'm using git for the
merge capabilities.
  I've looked at the "git for CVS users" section in
the docs and this appears to create two repositories. 
Is there a way to have two working directories that
utilize the same repository?
  I'm betting that I'm just trying to push my workflow
style onto git instead of adapting to the git way of
doing things; but thought I would ask.

TIA,

Bill
PS.  I'm trying to avoid the push in the commit, push,
merge, dcommit cycle.



       
____________________________________________________________________________________
Yahoo! oneSearch: Finally, mobile search 
that gives answers, not web links. 
http://mobile.yahoo.com/mobileweb/onesearch?refer=1ONXIC
