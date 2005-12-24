From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add strcpy_user_path() and use it in init-db.c and git.c
Date: Sat, 24 Dec 2005 13:07:10 -0800
Message-ID: <7vu0cyqk5d.fsf@assigned-by-dhcp.cox.net>
References: <20051224122016.GD3963@mail.yhbt.net>
	<7virtes6zd.fsf@assigned-by-dhcp.cox.net>
	<20051224195033.GE3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 24 22:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqGbn-0000qE-Bl
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 22:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVLXVHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 16:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVLXVHN
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 16:07:13 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11695 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750721AbVLXVHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 16:07:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224210519.GRJW17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 16:05:19 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224195033.GE3963@mail.yhbt.net> (Eric Wong's message of
	"Sat, 24 Dec 2005 11:50:33 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14034>

Eric Wong <normalperson@yhbt.net> writes:

> My home directories have different names on different machines I'm
> on, and I want to avoid having to recompile git for each one.
> I don't have root access to some of them, so installing globally in /usr
> or /usr/local isn't an option, either.

Then you probably need to use GIT_EXEC_PATH environment
variable.
