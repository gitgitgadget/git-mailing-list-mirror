From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Q] what to do when waitpid() returns ECHILD under signal(SIGCHLD, SIG_IGN)?
Date: Mon, 19 Jun 2006 17:36:01 -0700
Message-ID: <7vfyi07jf2.fsf@assigned-by-dhcp.cox.net>
References: <7vwtbc7ll6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606191654590.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 02:36:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsUET-0006Ab-R3
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 02:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWFTAgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 20:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWFTAgE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 20:36:04 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:12171 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964842AbWFTAgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 20:36:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620003602.HRHE12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 20:36:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606191654590.5498@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 19 Jun 2006 16:57:28 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22151>

Linus Torvalds <torvalds@osdl.org> writes:

> Whether we want to do that in the main() routine or when we actually do 
> the fork() or whatever is a different issue.

I do not offhand think of a place where we do fork() but not
waitpid(), and it is very tempting to cheat and do that in the
main(), since I do not see a downside to it.
