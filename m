From: Junio C Hamano <junkio@cox.net>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 12:21:02 -0800
Message-ID: <7vr79jx9ox.fsf@assigned-by-dhcp.cox.net>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se>
	<20051114132956.GT30496@pasky.or.cz>
	<20051114181958.GD20749@ca-server1.us.oracle.com>
	<Pine.LNX.4.64.0511141027380.3263@g5.osdl.org>
	<4378DF71.3060103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 14 21:24:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebkpp-0001IF-Dd
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 21:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVKNUVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 15:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVKNUVa
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 15:21:30 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:13786 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932100AbVKNUVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 15:21:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114202031.SOEY6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 15:20:31 -0500
To: git@vger.kernel.org
In-Reply-To: <4378DF71.3060103@op5.se> (Andreas Ericsson's message of "Mon, 14
	Nov 2005 20:03:13 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11844>

Andreas Ericsson <ae@op5.se> writes:

> Linus Torvalds wrote:
>
>> If you want to do a "configure" script (and I'm not sure it's worth
>> it),
>
> Perhaps not. I was under the impression that Junio was for it to 
> simplify the possible move of binaries to GIT_EXEC_PATH.

I do not see how that is related to it.

Offtopic, but if you really want to do ${var##} and friends
portably, expr(1) is the tool traditionalists prefer; not echo
piped to sed, please.
