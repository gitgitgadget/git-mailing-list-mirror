From: Junio C Hamano <junkio@cox.net>
Subject: Re: -p diff output and the 'Index:' line
Date: Mon, 30 May 2005 00:42:26 -0700
Message-ID: <7v7jhh6ty5.fsf@assigned-by-dhcp.cox.net>
References: <20050529071520.GC1036@pasky.ji.cz>
	<7vd5raqy28.fsf@assigned-by-dhcp.cox.net>
	<20050529120248.GD1036@pasky.ji.cz>
	<7vekbpq56r.fsf@assigned-by-dhcp.cox.net>
	<20050529190305.GP1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 09:41:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcesd-0004Pp-8F
	for gcvg-git@gmane.org; Mon, 30 May 2005 09:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVE3Hma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 03:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVE3Hma
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 03:42:30 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62146 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261541AbVE3Hm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 03:42:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530074225.DUYR12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 03:42:25 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050529190305.GP1036@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 29 May 2005 21:03:05 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> It's just something along the lines of "Me Og. Og sees /^+/. Og makes
PB> the line green." written in gawk (actually I'm not sure if pure awk
PB> wouldn't do, but I actually don't know the language), so I don't think
PB> the external diff thing would've helped me with that in any way.

Ah, I see.  I thought you were talking about the Index: and
separator lines.  Colorizing diff/patch part, you need to parse
the diff output with sed/awk/perl and annotate it anyway, and it
does not matter if you annotate within GIT_EXTERNAL_DIFF or
outside.  I agree with you that using GIT_EXTERNAL_DIFF
mechanism would not help you here.




