From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: git-svn and distributed git
Date: Tue, 31 Jul 2007 12:42:06 +0300
Message-ID: <65B05BC3-2BC2-4451-87C2-940113C55287@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 12:22:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IForc-0005zX-Q0
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 12:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbXGaKWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 06:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbXGaKWA
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 06:22:00 -0400
Received: from hyatt.suomi.net ([82.128.152.22]:38098 "EHLO hyatt.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920AbXGaKV7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 06:21:59 -0400
X-Greylist: delayed 1813 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2007 06:21:58 EDT
Received: from tiku.suomi.net ([82.128.154.67])
 by hyatt.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JM100I6IFB2S700@hyatt.suomi.net> for
 git@vger.kernel.org; Tue, 31 Jul 2007 12:49:50 +0300 (EEST)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JM100E5CFDZXZ40@mailstore.suomi.net> for git@vger.kernel.org;
 Tue, 31 Jul 2007 12:51:36 +0300 (EEST)
Received: from [192.168.0.138]
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam2.suomi.net (Postfix) with ESMTP id 0CCBA19D10E	for
 <git@vger.kernel.org>; Tue, 31 Jul 2007 12:42:42 +0300 (EEST)
X-Mailer: Apple Mail (2.752.3)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,	score=-0.793,
 required 5, autolearn=not spam, AWL 0.21,	BAYES_00 -1.00)
X-OPOY-MailScanner-From: v@pp.inet.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54330>

Hello,


I have just started using git, so I don't have a lot of experience on =20
it, and I also haven't used it in a distributed environment, just as =20
a single developer on one of my personal projects.

Now I'm trying to use git at work through git-svn. git-svn cloned the =20
Subversion repository okay, and using git and dcommitting to =20
Subversion also works fine. The problems started when i tried to use =20
the git-svn repository in a distributed fashion.


Here's the thing: I'm developing a server software, locally and on a =20
pre-production server. The pre-production test server (just called =20
the server for now on) is on a DMZ network, which cannot access our =20
Subversion server. So I thought I could push the git repository to =20
the server to update the code, which works fine too. But sometimes =20
when there is a problem, I'll just develop the fix on the server =20
itself, instead of on my laptop (local development). I would like to =20
be able to pull the changes made on the server, back to my laptop, =20
and dcommit it to the Subversion server from there.

The problem is, that git-svn changes all the commits, and pushing to =20
the server repository won't work anymore. I can force a push, but =20
then there will be two commits per every commit pulled from the server.

I have thought about using two branches on the server, master, which =20
will only include commits already processed through git-svn, and dev, =20
which is used to pull the "local" changes to be committed to =20
Subversion. But my inexperience with git got me here, and I can't =20
seem to be able to get any updates from the other branch. And I'm not =20
even sure if this is the right approach to this problem.


What kind of approach/workflow would you use in a similar situation?


Regards,
V=E4in=F6 J=E4rvel=E4