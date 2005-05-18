From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Wed, 18 May 2005 16:56:38 -0700
Message-ID: <7v64xgnl55.fsf@assigned-by-dhcp.cox.net>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net>
	<20050517190355.GA7136@pasky.ji.cz>
	<7vk6lxfybc.fsf@assigned-by-dhcp.cox.net>
	<20050517203500.GH7136@pasky.ji.cz>
	<7v4qd1tuud.fsf@assigned-by-dhcp.cox.net>
	<20050517213752.GO7136@pasky.ji.cz>
	<7vzmutqz5f.fsf@assigned-by-dhcp.cox.net>
	<20050518213309.GD10358@pasky.ji.cz>
	<7vekc4nom5.fsf@assigned-by-dhcp.cox.net>
	<20050518232408.GA18281@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu May 19 01:57:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYYOi-0002eB-6g
	for gcvg-git@gmane.org; Thu, 19 May 2005 01:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVERX44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 19:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVERX44
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 19:56:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27624 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262411AbVERX4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 19:56:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050518235637.MOIL7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 19:56:37 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050518232408.GA18281@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 19 May 2005 01:24:08 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Yes. My point is that sometimes the Cogito commands have
PB> directory-specific functionality even when called without any arguments.

PB> $ pwd
PB> /usr/src/linux
PB> $ date >>README
PB> $ cd fs
PB> $ date >>Makefile
PB> $ cg-commit

PB> will commit only the fs/Makefile change.

Ah, thanks.  That what I missed.



