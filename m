From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk: Display commit messages with word wrap
Date: Sun, 14 May 2006 16:30:50 -0700
Message-ID: <7v4pzs18wl.fsf@assigned-by-dhcp.cox.net>
References: <20060514151456.GA18012@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 01:30:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfQ35-0006dm-9h
	for gcvg-git@gmane.org; Mon, 15 May 2006 01:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWENXaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 19:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWENXaw
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 19:30:52 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:32177 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751408AbWENXav (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 19:30:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514233051.KRJD25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 19:30:51 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20060514151456.GA18012@procyon.home> (Sergey Vlasov's message of
	"Sun, 14 May 2006 19:14:56 +0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19992>

Sergey Vlasov <vsu@altlinux.ru> writes:

> Some people put very long strings into commit messages, which then
> become invisible in gitk (word wrapping in the commit details window is
> turned off, and there is no horizontal scroll bar).  Enabling word wrap
> for just the commit message looks much better.

I do not mind it myself but IIRC gitk's "no wrapping" was made
because people found wrapping annoying; maybe a runtime
configuration option?
