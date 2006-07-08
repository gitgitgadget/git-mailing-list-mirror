From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Sat, 08 Jul 2006 11:51:26 -0700
Message-ID: <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net>
References: <20060708183402.GA17644@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 20:51:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzHtq-0005JL-U3
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 20:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWGHSv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 14:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWGHSv2
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 14:51:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:28047 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964959AbWGHSv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 14:51:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060708185127.EYJT12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Jul 2006 14:51:27 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060708183402.GA17644@spearce.org> (Shawn Pearce's message of
	"Sat, 8 Jul 2006 14:34:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23495>

Shawn Pearce <spearce@spearce.org> writes:

> Removing these last remaining extension uses allows GIT to compile
> with the Sun C compiler rather then gcc.  This can be handy when
> you are trying to compile GIT on a Solaris system that seems to
> have a total lack of GNU utilities.

Two points.

 - Aren't the constructs you ripped out not GCC extension,
   rather proper ISO C99?

 - Our Makefile is pretty GNU already.  I think people have
   pointed out and ripped out bashisms from our shell scripts,
   but I would not be surprised if the default Sun /bin/sh does
   not understand POSIXy features some of them use.
