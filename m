From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT - error: no such remote ref refs/heads/TestBranch
Date: Thu, 21 Dec 2006 16:52:51 -0800
Message-ID: <7vbqlw92fw.fsf@assigned-by-dhcp.cox.net>
References: <89b129c60612191233s5a7f36f2hd409c4b9a2bbbc5c@mail.gmail.com>
	<7v64c7pmlw.fsf@assigned-by-dhcp.cox.net>
	<87wt4m2o99.wl%cworth@cworth.org>
	<7vmz5i6vqb.fsf@assigned-by-dhcp.cox.net>
	<87vek62n1k.wl%cworth@cworth.org>
	<7v1wmu5ecs.fsf@assigned-by-dhcp.cox.net>
	<87tzzp3fgh.wl%cworth@cworth.org>
	<slrneokplo.nsf.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:53:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYen-0003SN-3v
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423169AbWLVAw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423170AbWLVAw4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:52:56 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56909 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423169AbWLVAwz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:52:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222005252.OIRJ29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Dec 2006 19:52:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1ct41W00Z1kojtg0000000; Thu, 21 Dec 2006 19:53:04 -0500
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35106>

Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
writes:

> I'm also not so confident about mixing "add NEW files" with "updating
> the contents of already known files".

File boundaries do not matter ;-)  You are adding contents.
Sometimes new contents are contained in a file that git already
knew about.  Other times they are contained in a file that git
did not know about.

But that is a phylosophical answer, not a practical one, since
majority of the time (unless you are talking about the first few
weeks of a new project) you will be adding contents that happen
to be in the files git knows about.

I think the operation related but different from "git add ."
Carl talks about would be useful in practice.  I do not know
what the option should be called.

	"git add --modified"?
        "git add --tracked"?
        "git add --updated"?

It would work in the same way as the pre-commit step of "git
commit -a".
