From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use setenv(), fix warnings
Date: Sun, 26 Feb 2006 12:29:59 -0800
Message-ID: <7vd5h96eyg.fsf@assigned-by-dhcp.cox.net>
References: <20060226171346.33ad3e47.tihirvon@gmail.com>
	<7vmzge570u.fsf@assigned-by-dhcp.cox.net>
	<20060226203756.05dcfb26.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 21:30:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDSWt-0003vc-9u
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 21:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWBZUaD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 15:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWBZUaD
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 15:30:03 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:26788 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751162AbWBZUaC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 15:30:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060226202648.IBVY17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 15:26:48 -0500
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060226203756.05dcfb26.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Sun, 26 Feb 2006 20:37:56 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16795>

Timo Hirvonen <tihirvon@gmail.com> writes:

> putenv(3):
>     "If the argument `string` is of the form `name`, and does not
>     contain an `=' character, then the variable `name` is removed from
>     the environment."
>
> So the variable is emptied, not removed.  But usually empty environment
> variables are treated as if they didn't exist...

Yes we were aware of that when we did it.
