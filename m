From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use sigaction and SA_RESTART in read-tree.c; add option in Makefile.
Date: Sun, 02 Apr 2006 21:20:04 -0700
Message-ID: <7v7j67i93f.fsf@assigned-by-dhcp.cox.net>
References: <17063.1144016974@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 06:20:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQGY4-0007di-8U
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 06:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWDCEUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 00:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWDCEUK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 00:20:10 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12183 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964776AbWDCEUH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 00:20:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060403042006.UYD20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Apr 2006 00:20:06 -0400
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <17063.1144016974@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Sun, 02 Apr 2006 15:29:34 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18309>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> Also add a NO_SA_RESTART option in the Makefile in case someone
> doesn't have SA_RESTART but does restart (maybe older HP/UX?).
> We want the builder to chose this specifically in case the
> system both lacks SA_RESTART and does not restart stdio calls;
> a compat #define in git-compat-utils.h would silently allow
> broken systems.

What am I missing...?
