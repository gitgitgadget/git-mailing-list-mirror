From: Bill Priest <priestwilliaml@yahoo.com>
Subject: git-svn fetch hangs or gives broken pipe on a specific "branch"
Date: Tue, 5 Jun 2007 09:53:04 -0700 (PDT)
Message-ID: <689181.83891.qm@web55015.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 19:00:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvcNv-0007be-TT
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 18:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbXFEQ7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 12:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbXFEQ7q
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 12:59:46 -0400
Received: from web55015.mail.re4.yahoo.com ([206.190.58.149]:25732 "HELO
	web55015.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752040AbXFEQ7q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 12:59:46 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jun 2007 12:59:45 EDT
Received: (qmail 83902 invoked by uid 60001); 5 Jun 2007 16:53:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=yBuQnYsVTXsoG+Wlro7kIV/0zNXhpFmCi1dvUemC+LMfYzSpLMJaL1aaaebf9qfuewqb7C1m5edgjqZ8kxQtk2xf5kkWPINZwNbt18EBSEvKmxTceQraqYo87EyFccvM9drKV9FOp2xWwRtonr5Motyu2cFjqNDMQDpirr5pmVg=;
X-YMail-OSG: NtD83yoVM1moFzTZv4ofdatKR0U7syOw3UKWf.BrLVbk5pEA6v0R_GV_NYlwaaoo1D4u2pxs4B9s0EQTcCQ1agta24twUHU0w.4bxD.M89euvyDNDPWoIwNAgz27
Received: from [64.243.207.55] by web55015.mail.re4.yahoo.com via HTTP; Tue, 05 Jun 2007 09:53:04 PDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49207>

All,
  I'm trying to use git to try out its merging
capabilities as I'm not "happy" w/ what svn provides. 
From Linus discussion at google (from YouTube) he
indicated that many people use it to manage merges
between branches and then push back into the
subversion repository.  I'd like to do this as
converting to git from svn (less than 6 months after
converting from cvs to svn isn't an easy sell to
management).
  We have a small team (~5 developers) and a fairly
small project (a few hundred files).  From a web
site/wiki I found the following instructions (tweaked
for my setup).
I downloaded the latest release of git 1.5.2 and built
it on RHEL box.  Subversion version is 1.4.2.  The
repository and the git working directory are on the
same machine (taking networking out of the picture).
mkdir git_test
cd git_test
git-svn init -t tags -b branches -T trunk "my URL"
Initialized empty Git repository in .git/
git-svn fetch
all tags were processed w/o error AFAICT; the first
branch it tries to work on causes either a hang or a
"Broken Pipe".  I changed from an http:// to svn:// on
the git-svn init and everything worked correctly.
This would seem to indicate some type of problem w/
apache/httpd problem.  I looked in the httpd logs and
didn't see any errors.
   Is this a known problem?

TIA,

Bill



       
____________________________________________________________________________________
Get the Yahoo! toolbar and be alerted to new email wherever you're surfing.
http://new.toolbar.yahoo.com/toolbar/features/mail/index.php
