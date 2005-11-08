From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on http-push
Date: Tue, 08 Nov 2005 00:59:45 -0800
Message-ID: <7vy83zjz0e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511071926240.14149@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051108084620.GA5830@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 10:00:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZPKx-0006sS-SH
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 10:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVKHI7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 03:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVKHI7u
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 03:59:50 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54219 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932501AbVKHI7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 03:59:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108085849.TYYV2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 03:58:49 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051108084620.GA5830@reactrix.com> (Nick Hengeveld's message of
	"Tue, 8 Nov 2005 00:46:21 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11318>

Nick Hengeveld <nickh@reactrix.com> writes:

> In the interest of testing push against another DAV server
> implementation, I tried using Subversion's Apache DAV/DeltaV module.
> It works if you enable autoversioning and authentication, which makes
> for a slightly different minimal Apache setup:
>...
> While it's kind of useless to place immutable objects under version
> control, it is sort of an interesting side effect that all the meta
> files will have a history.

Pushing git commit history into SVN server --- this must be a
sick joke ;-).  Can you pull over http from there?

But seriously, it is good that you are trying out talking with
different servers.  Thanks.

I'm planning to push out the final bit to make git-push aware of
http-push tonight or tomorrow.
