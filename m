From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Sat, 03 Dec 2005 22:26:25 -0800
Message-ID: <7vk6eltm26.fsf@assigned-by-dhcp.cox.net>
References: <28409.1133564908@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 07:27:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EinKQ-0001VJ-7y
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 07:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVLDG01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 01:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLDG01
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 01:26:27 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49068 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750733AbVLDG01 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 01:26:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051204062538.XBJM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 01:25:38 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <28409.1133564908@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Fri, 02 Dec 2005 15:08:28 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13181>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> The rule for building git$(X) also needs to include compat.
> objects and compiler flags.  Those are now in makefile vars
> COMPAT_OBJS and COMPAT_CFLAGS.

Thanks for the cleanup.  Looks much saner.
