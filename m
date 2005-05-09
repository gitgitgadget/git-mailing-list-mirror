From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Mon, 09 May 2005 09:38:46 -0700
Message-ID: <7vll6oz755.fsf@assigned-by-dhcp.cox.net>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>
	<2637.10.10.10.24.1115425225.squirrel@linux1>
	<7vis1vc27f.fsf@assigned-by-dhcp.cox.net>
	<2721.10.10.10.24.1115425962.squirrel@linux1>
	<7vbr7nbl89.fsf@assigned-by-dhcp.cox.net>
	<7vacn6ak7r.fsf@assigned-by-dhcp.cox.net> <427F6693.2080707@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 19:18:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVBAN-0004J5-7i
	for gcvg-git@gmane.org; Mon, 09 May 2005 18:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVEIQiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 12:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVEIQiu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 12:38:50 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53709 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261445AbVEIQis (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 12:38:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050509163847.VODS7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 May 2005 12:38:47 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427F6693.2080707@zytor.com> (H. Peter Anvin's message of "Mon,
 09 May 2005 06:33:07 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "HPA" == H Peter Anvin <hpa@zytor.com> writes:

HPA> Naming the environment variables SHA1_FILE_<anything> is almost
HPA> certainly wrong; a much more logical name would be
HPA> GIT_<something>. It'd also be much less likely to cause conflicts.

Exactly my feeling from the beginning.

But you have to realize that you are suggesting to change the
SHA1_FILE_DIRECTORY that was there from almost the beginning as
well.  I know the code change required for the rename is
minimum, but there are users involved.  My feeling is that we
should contain the damage by changing the definition of
DB_ENVIRONMENT in cache.h sooner rather than later, but I do not
think this is the week to do it.


