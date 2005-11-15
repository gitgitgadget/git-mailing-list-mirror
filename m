From: Junio C Hamano <junkio@cox.net>
Subject: Re: pushing patches to an imap folder
Date: Tue, 15 Nov 2005 11:03:51 -0800
Message-ID: <7vzmo5ka20.fsf@assigned-by-dhcp.cox.net>
References: <43799A67.9030705@codeweavers.com>
	<7vd5l2qnq6.fsf@assigned-by-dhcp.cox.net>
	<4379B9F6.5020402@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Nov 15 20:14:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec66C-0008WO-Dp
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 20:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbVKOTDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 14:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVKOTDy
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 14:03:54 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25250 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964998AbVKOTDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 14:03:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115190239.PPWW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 14:02:39 -0500
To: Mike McCormack <mike@codeweavers.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11936>

Mike McCormack <mike@codeweavers.com> writes:

> We have a (semi-experimental) wine.git tree, which is updated at the 
> same time as the Wine CVS, by the project maintainer:
>
> http://source.winehq.org/git/wine.git

Wow.  How is the acceptance by wine community?  Favorable, I
hope.

It would be nice before 1.0 happens to have a list of publicly
visible projects and people who use git as part of the workflow;
the degree would vary per project, from using it as the primary
repository (the kernel, I guess) to merely accessible with git.

> It will probably be maintained in parallel with the Wine CVS for a 
> while, unless somebody writes a GIT->CVS gateway.

git-cvsexportcommit?  I haven't had a chance to use it myself,
although I have to interoperate with CVS in some projects.
Martin, do you want to do a plug (or brag) here?

> I find git-rebase to be particularly useful.

It is handy, especially for simple things like rebasing topic
branches, when the things are of managable size without using
quilt or StGIT.  Do you manage binary files?

> Pushing patches from git into a drafts folder means I don't have to 
> manually generate a diff, open a mail, type the mailing list address, 
> attach the patch and write/copy-paste a ChangeLog entry.

Yes, I saw that value there.  Maybe adding hooks to format-patch
so that it can do form-letter-ish things you had to add there
without patching might help?  I dunno.
