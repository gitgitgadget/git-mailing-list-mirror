From: Perrin Meyer <perrinmeyer@yahoo.com>
Subject: git svn dcommit seg fault
Date: Tue, 17 Jul 2007 19:51:27 -0700 (PDT)
Message-ID: <951126.88373.qm@web52807.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 04:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAzjz-0001oK-91
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 04:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbXGRC6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 22:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755425AbXGRC6K
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 22:58:10 -0400
Received: from web52807.mail.re2.yahoo.com ([206.190.48.250]:26820 "HELO
	web52807.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754725AbXGRC6J (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 22:58:09 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2007 22:58:08 EDT
Received: (qmail 88787 invoked by uid 60001); 18 Jul 2007 02:51:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=lWa97ZKj8+X9D45VGnv1bIPPeshZk21qpqFmm5Qfu3Bz8gO0zyk/kHtq59mdj4u1vcSIiKmurBU62+62TEn2HG9CLFo5bZJoYUPlSwbe2nnQWxssEci7KhprMYdbb8IPiZjJfeUX0LcqDLjC8RTezCIc0gwXbmrBnWsbkm7tOqI=;
X-YMail-OSG: jUK_ySgVM1mWUnc5wlfbL95hg4hBklFofak.UL9A16XbapZqrSiWoKYo7oTpg9G9yeOfyXfDF0ayKgz49caTvRtmT_bmhb98z4EMfhZOZFNeh1M-
Received: from [216.52.12.233] by web52807.mail.re2.yahoo.com via HTTP; Tue, 17 Jul 2007 19:51:27 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52824>


I'm able to clone svn repo's fine with

$ git svn clone https://svn.eng.msli.com/perrin/trunk/TESTGIT/ .

and I'm then able to use git commit to commit local changes, but 
when I try 

$ git svn dcommit

I get

[perrin@whisper TESTGIT]$ git svn dcommit
        M       test.c
Committed r717
Segmentation fault

As far as I can tell, the commit worked fine (verified by trying 'svn update' on another box).

I've tried git version 1.5.2.3, 1.5.3-rc2, and the latest build, and all give the seg fault. 

I'm guessing it has something to do with using the https connection to svn?

Thanks,

Perrin Meyer
