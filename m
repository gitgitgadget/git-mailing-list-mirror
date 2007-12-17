From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: add -i not able to find get_colorbool
Date: Mon, 17 Dec 2007 14:04:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171400250.9446@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 15:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4GaZ-0000wo-Tc
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 15:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbXLQOEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 09:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898AbXLQOEh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 09:04:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:35384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753599AbXLQOEg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 09:04:36 -0500
Received: (qmail invoked by alias); 17 Dec 2007 14:04:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 17 Dec 2007 15:04:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18V2ZhW+b8V3X7XV7AVaUhi45rpi467Z0XGZbVJPx
	cRWlc29k+sTuFI
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68566>

Hi,

I did not use "git add -i" in something like two weeks, and now it stopped 
working:

	$ git add -i
	Can't locate object method "get_colorbool" via package "Git" at 
		/home/gitte/bin/git-add--interactive line 15.

The second line of git-add--interactive reads thusly:

	use lib (split(/:/, $ENV{GITPERLLIB} || 
		"/home/gitte/lib/perl5/site_perl/5.8.8"));

and this puzzles me:

	$ grep -n get_colorbool /home/gitte/lib/perl5/site_perl/5.8.8/Git.pm
	584:=item get_colorbool ( NAME )
	591:sub get_colorbool {

So it has it, but cannot locate get_colorbool?

Help,
Dscho
