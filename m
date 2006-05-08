From: Junio C Hamano <junkio@cox.net>
Subject: Re: [patch] munmap-before-rename, cygwin need
Date: Mon, 08 May 2006 13:52:28 -0700
Message-ID: <7vfyjkfddf.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0605071258s7a0cb085r3f08e9981234255a@mail.gmail.com>
	<7vslnlk04v.fsf@assigned-by-dhcp.cox.net>
	<f36b08ee0605080358y3830f1aep879331df806211e0@mail.gmail.com>
	<81b0412b0605080635r40868f18ua88b33558368f82b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Yakov Lerner" <iler.ml@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 22:52:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdCiX-0000XU-Ny
	for gcvg-git@gmane.org; Mon, 08 May 2006 22:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWEHUwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 16:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWEHUwb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 16:52:31 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:33187 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750755AbWEHUwa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 16:52:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508205230.ILSN25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 16:52:30 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19777>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> You really want  "NO_MMAP = YesPlease" in your config.mak.
> Take a look into compat/mmap.c. That's why Junio has never seen
> the breakage.

I do not have custom config.mak for my Cygwin builds and NO_MMAP
is disabled in the default Makefile, so that does not explain
why it does not break for me.  Very puzzled.
