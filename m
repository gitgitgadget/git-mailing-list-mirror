From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Include Makefile.localdef in Makefile, if it exists.
Date: Sat, 03 Dec 2005 11:14:43 -0800
Message-ID: <7vmzjixaak.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512030322410.19086@wbgn013.biozentrum.uni-wuerzburg.de>
	<3061.1133591717@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 20:15:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EicqO-0003st-Ch
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 20:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVLCTOp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 14:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVLCTOp
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 14:14:45 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:10174 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750725AbVLCTOp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 14:14:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203191447.OMEB25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Dec 2005 14:14:47 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13159>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> ...  I might
> send along such a patch, along with a note about config.mak in
> INSTALL...

Please don't, unless you are confident your change can satisfy
_everybody_.

People with makefile needs that are more "advanced" (that is,
something a simple "-include config.mak" cannot easily satisfy)
can do any number of things without touching Makefile I ship.
Examples include:

 - have own makefile, include Makefile.

 - have onw Make script, run "make -f Makefile" with preset
   "bindir=HERE NO_XXX=NoThanks" to reduce typing.

 - have own makefile, whose build target depends on Make.file
   and runs "make -f Make.file", with a build rule for Make.file
   to munge Makefile using custom perl/sed into it.
