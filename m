From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 18:10:40 -0800
Message-ID: <7vy7z97rdr.fsf@assigned-by-dhcp.cox.net>
References: <20060314211022.GA12498@localhost.localdomain>
	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	<20060314224027.GB14733@localhost.localdomain>
	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
	<7vek13ieap.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
	<7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
	<20060316075324.GA19650@pfit.vm.bytemark.co.uk>
	<7v64mebxsu.fsf@assigned-by-dhcp.cox.net>
	<slrne1inu0.fr9.mdw@metalzone.distorted.org.uk>
	<44196DE7.8010205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 17 03:11:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK4Qa-0006xQ-18
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 03:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbWCQCKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 21:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbWCQCKm
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 21:10:42 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:704 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1752484AbWCQCKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 21:10:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060317020644.NCYC17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Mar 2006 21:06:44 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17649>

Andreas Ericsson <ae@op5.se> writes:

>> . ${GIT_EXEC_PATH-'@@@GIT_EXEC_PATH@@@'}/git-sh-setup
>> isn't too grim, and shows how the git_exec shell function can be made
>> somewhat terser.
>
> But it breaks the convenience when testing.

I think that's OK.  When I test things in the build directory
without installing I would usually do:

	$ GIT_EXEC_PATH=`pwd` PATH=`pwd`:/usr/bin:/bin ./git-cmd-to-test

and the above would not break things.
