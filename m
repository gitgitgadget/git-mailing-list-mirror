From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon server
Date: Sat, 04 Jun 2005 21:47:36 -0700
Message-ID: <7vk6l9flzr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506031450190.1876@ppc970.osdl.org> <Pine.LNX.4.21.0506031927000.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 06:45:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Demzh-00043t-2c
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 06:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVFEErj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 00:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVFEErj
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 00:47:39 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63635 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261452AbVFEEri (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 00:47:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605044737.YGZI26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 00:47:37 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506031927000.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Fri, 3 Jun 2005 20:06:51 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> With patches I have (but have to rebase and such), you could do:

DB> git-rpush -a -w heads/master heads/master //master.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

I'd like to see your "-w" extention merged into mainline soon
(both push and pull).

BTW, don't we want to have them renamed to git-ssh-pull (and
git-ssh-push) for consistency with other transports, before 1.0
happens?



