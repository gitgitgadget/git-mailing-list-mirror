From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make .git directory validation code test HEAD
Date: Sat, 27 Aug 2005 21:56:47 -0700
Message-ID: <7v7je6slps.fsf@assigned-by-dhcp.cox.net>
References: <874q9bcu6d.fsf@litku.valo.iki.fi>
	<46a038f905082708371719121c@mail.gmail.com>
	<87zmr39svy.fsf@litku.valo.iki.fi>
	<Pine.LNX.4.58.0508271334320.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kalle Valo <Kalle.Valo@iki.fi>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 28 06:57:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9FEG-0005RV-03
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 06:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVH1E4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 00:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVH1E4t
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 00:56:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63361 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751109AbVH1E4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 00:56:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828045647.EDCR8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 00:56:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508271334320.3317@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 27 Aug 2005 13:54:42 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7860>

Linus Torvalds <torvalds@osdl.org> writes:

> This also removes the tests for "$GIT_DIR" and "$GIT_OBJECT_DIRECTORY" 
> being directories, since the other tests will implicitly test for that 
> anyway (ie the tests for HEAD, refs and 00 would fail).

I've thought about it when you brought up the Andrew's naked git
repository detection issue, but one thing I was undecided was
that if we would want to forbid either of these "directories"
being a symlink to another directory.  I think it would be OK;
admittedly "test -d" says OK for a symlink to a directory.

I accept the patch, but will not apply and push it out right
now; I am not in a shape to be operating heavy equipment ;-).
Please wait until tomorrow morning.
