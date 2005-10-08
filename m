From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Sat, 08 Oct 2005 11:30:21 -0700
Message-ID: <7v64s7svya.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 20:30:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOJSm-00070N-12
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 20:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVJHSaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 14:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVJHSaX
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 14:30:23 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24253 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750815AbVJHSaX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 14:30:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051008183012.HSCQ4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Oct 2005 14:30:12 -0400
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <20051008133032.GA32079@localhost> (Robert Fitzsimons's message
	of "Sat, 8 Oct 2005 13:30:32 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9847>

Robert Fitzsimons <robfitz@273k.net> writes:

> Instead of using //{LF}// and //{TAG}// to quote embedded tab and
> linefeed characters in pathnames use URI quoting.
>
> '\t' becomes %09
> '\n' becomes %10
> '%' becomes %25
>
> Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

This would break existing setup where people *has* per-cent
letter in their pathname -- which I think is worse than the
backslash proposal.
