From: Junio C Hamano <junkio@cox.net>
Subject: Last mile to 1.0?
Date: Sat, 16 Jul 2005 10:46:00 -0700
Message-ID: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 16 19:46:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtqjy-0007oB-Bq
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 19:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVGPRqD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 13:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVGPRqD
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 13:46:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40886 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261719AbVGPRqC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 13:46:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050716174601.VQTQ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Jul 2005 13:46:01 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I do not know what release plan Linus has in mind, and also
expect things to be quieter next week during OLS and kernel
summit, but I think we are getting really really close.

Here are the things I think we would want to see before we hit
1.0:

 - Remaining feature enhancements and fixes.

   - Anonymous pull from packed archives on remote sites via
     non-rsync, non-ssh transport.  Many people are behind
     corporate firewalls that do not pass anything but outgoing
     http(s) and some do not even pass outgoing ssh.  The recent
     addition of git-daemon by Linus would greatly alleviate the
     situation, but we may also end up wanting something HTTP
     reachable.

 - Documentation.

   - Many files under Documentation/ directory have become
     stale.  I've tried to do one pass of full sweep recently,
     but I'd like somebody else to make another pass to make
     sure that the usage strings in programs, what the programs
     do, and what Documentation says they do match.  Also, the
     spelling and grammar fixes, which I am very bad at and have
     not done any attempt, needs to be done.

     Volunteers?

   - Are all the files in Documentation/ reachable from git(7)
     or otherwise made into a standalone document using asciidoc
     by the Makefile?  I haven't looked into documentation
     generation myself (I use only the text files as they are);
     help to update the Makefile by somebody handy with asciidoc
     suite is greatly appreciated here.

     Volunteers?

   - We may want to describe more Best Current Practices, along
     the lines of "Working with Others" section in the tutorial.
     Please write on your faviorite topic and send patches in
     ;-))

 - Publicity.  I would be very happy to see somebody with good
   writing and summarizing skills to prepare an article to be
   published on LWN.NET to coincide with the 1.0 release.  An
   update to GIT traffic would also be nice.
