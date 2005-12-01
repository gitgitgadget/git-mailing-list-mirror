From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Thu, 01 Dec 2005 01:45:53 -0800
Message-ID: <7viru9jgku.fsf@assigned-by-dhcp.cox.net>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
	<Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051201033201.02b47071.tihirvon@gmail.com>
	<7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512010906400.22709@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjlkx2f.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512010140m1b96db84x70c7d92f8f644a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 10:47:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehl0n-0005Uo-NH
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 10:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVLAJpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 04:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVLAJpz
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 04:45:55 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39297 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932109AbVLAJpy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 04:45:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201094438.KBST26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 04:44:38 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512010140m1b96db84x70c7d92f8f644a2a@mail.gmail.com>
	(Alex Riesen's message of "Thu, 1 Dec 2005 10:40:30 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13046>

Alex Riesen <raa.lkml@gmail.com> writes:

> I have even my specific targets in the config.mak (and would actually
> like to have the default target put before including config.mak, so
> default call to make is always the same).

Surely you can do that by having your own "makefile" and include
"Makefile" I ship, and run "make", which prefers makefile over
Makefile ;-).
