From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Terms to add to glossary
Date: Mon, 01 May 2006 23:56:43 -0700
Message-ID: <7v8xpkq5hw.fsf@assigned-by-dhcp.cox.net>
References: <e332g6$hpl$1@sea.gmane.org> <e35sin$c1l$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 08:56:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaooU-0003Xq-H6
	for gcvg-git@gmane.org; Tue, 02 May 2006 08:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWEBG4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 02:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWEBG4q
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 02:56:46 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:15265 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932414AbWEBG4q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 02:56:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502065645.YSN17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 02:56:45 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e35sin$c1l$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	01 May 2006 22:55:43 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19398>

Jakub Narebski <jnareb@gmail.com> writes:

> cherry picking:: 
>         In SCM jargon, cherry picking is used to describe the action of 
>         selecting which commit should be ported from one branch to another. 
>         In GIT it means given one existing commit, apply the change 
>         the patch introduces, and record a new commit that records it.

I am not sure what the focus of the above description is.  I
myself got more confused after reading it than before ;-).  My
impression was that we have been using the word "cherry-pick" in
pretty standard way, but are you trying to stress that we use
the word in a different sense?

"Action of selecting" is done by the user, perhaps with or
without help from the tool.  After deciding which one to "port",
the way to perform the actual "port" would be different from SCM
to SCM, and in GIT it is often done with the "git-cherry-pick"
command.  Are you saying the command is misnamed, and we should
call a program that helps the user in "action of selecting"
cherry-pick (actually, I think "git cherry" fits that
description)?

If the focus is not to highlight the distinction but to help the
end user, something like this might be better.

cherry-picking::
	In SCM jargon, "cherry pick" means to choose a subset of
	changes out of a series of changes (typically commits)
	and record them as a separate series of changes on top
	of different codebase.  In GIT, this is performed by
	"git cherry-pick" command to extract the change
	introduced by an existing commit and to record it based
	on the tip of the current branch as a new commit.
