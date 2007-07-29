From: Matthew L Foster <mfoster167@yahoo.com>
Subject: merge time
Date: Sun, 29 Jul 2007 10:33:56 -0700 (PDT)
Message-ID: <630183.45851.qm@web51001.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: mfoster167@yahoo.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 19:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFCl3-0007Wn-7g
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 19:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764476AbXG2Rkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 13:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764505AbXG2Rkk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 13:40:40 -0400
Received: from web51001.mail.re2.yahoo.com ([206.190.38.132]:34113 "HELO
	web51001.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1763929AbXG2Rki (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 13:40:38 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jul 2007 13:40:38 EDT
Received: (qmail 45875 invoked by uid 60001); 29 Jul 2007 17:33:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ZfafXLQ7VZXHMPLgS/SmIk0Fk8JiPgMIjzkj4/smMR5bvYtjWBdbey3UA9btDIcuT1lC2t0xeuDBvnx3gTUWm1J0I7IonWEUhwHA6gjLnoW96VFaB8dM/AIIpNG0KFN26XzmHoX0I42MWXy6fW5vBZUZdXTAgGkbQ2LBq1nuK4o=;
X-YMail-OSG: o0qRHOcVM1ltXmQfOv7fxjibMw8GgtKwUnldYmVON4evqM1U8dm9t4Xe_Eb..JHrUQdJIsI.hqqh0vO9d04Z6Lfx2b9XF_1ZIwJ94lNOmOwosPX6V2mAvIo_ET8HF.rzkrtyAa6Bu7mbIOPw_2hLtA--
Received: from [208.58.8.179] by web51001.mail.re2.yahoo.com via HTTP; Sun, 29 Jul 2007 10:33:56 PDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54128>


Sorry to bring up the time issue again [that I am perhaps still confused about] but I have been
playing around with git more and I think I can phrase my question/observation better.

>From viewing gitweb.cgi I have observed a situation where Linus creates a tag, say rc1, and then
he later merges changes but some subset of those changes/commits show up in the list in time order
as taking place _before_ the rc1 tag was made even though they were merged after. Do I describe a
real or possible phenomenon? And does this happen because the developer that made the subset of
changes in question commit them to his/her local repository in time order before the rc1 tag was
made? So an external repository had the change before the rc1 tag was made but Linus' repository
didn't? But internally git on Linus' machine knows that the gitweb.cgi displayed time order is
wrong as far as the state is concerned because each repository's index file keeps local track of
the true local state [just time isn't reconcilable], or am I missing something(s)?

Is it possible for gitweb.cgi to have a new view mode that sorts/displays the list based on merge
time for commits (the time merged into Linus' or whatever repository) so the above situation
doesn't happen? The actual time of a local commit should be the time it was merged locally not the
time it was created externally/originally, right? Where can I find the gitweb.cgi source/package?
I could maybe hack gitweb.cgi myself.

Please CC me on any replies since I am not subscribed to the list.

-Matt



       
____________________________________________________________________________________
Get the Yahoo! toolbar and be alerted to new email wherever you're surfing.
http://new.toolbar.yahoo.com/toolbar/features/mail/index.php
