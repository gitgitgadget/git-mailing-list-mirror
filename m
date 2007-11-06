From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Git-windows and git-svn?
Date: Tue, 6 Nov 2007 09:02:19 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0711060857140.8577@ds9.cixit.se>
References: <fgg6cd$3ep$1@ger.gmane.org> <472BABFA.6030200@obry.net>
 <A35C7C2D-A829-4A16-B81B-8A6DE01FE5DB@zib.de> <472C211C.90907@obry.net>
 <EE16FE19-8C6C-4438-8E6E-EA6B87A898A7@zib.de> <72D5CB06-9067-47C4-ABDF-4E1F6F4A679D@zib.de>
 <472C2FF8.2000603@obry.net> <591E16CE-E303-4971-B57D-D84E883BB01D@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pascal Obry <pascal@obry.net>,
	Abdelrazak Younes <younes.a@free.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 09:02:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpJOR-0007SZ-Sk
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 09:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbXKFICY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 03:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754581AbXKFICY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 03:02:24 -0500
Received: from ds9.cixit.se ([193.15.169.228]:33466 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678AbXKFICX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 03:02:23 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id lA682KnQ010552
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Nov 2007 09:02:20 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id lA682JeH010547;
	Tue, 6 Nov 2007 09:02:19 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <591E16CE-E303-4971-B57D-D84E883BB01D@zib.de>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 06 Nov 2007 09:02:20 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63637>

Steffen Prohaska:

> Right. The experience should be good if you use binmode.

Shouldn't it be possible to fix this by sprinkling the appropriate
number of "b"s in the parameters to fopen()? Or is it more complicated
than that?

> But never use textmode. You'll not get an error right away. At first
> git seems to work. But later it reports weird errors. The experience
> is really bad. Don't do that.

I got errors almost right away when trying that (I need text mode to
interface with some other programs), so Cygwin-git is a no-go for me at
the moment. Of course, mixing msys-Git with Cygwin and ActiveState Perl
is also an interesting experience, to say the least :-)

-- 
\\// Peter - http://www.softwolves.pp.se/
