From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add NO_CURL option to the Makefile
Date: Sat, 30 Jul 2005 18:09:16 -0700
Message-ID: <7vk6j7ye6b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507310213110.13590@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 03:09:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz2KU-0004Sh-Be
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 03:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVGaBJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 21:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVGaBJU
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 21:09:20 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1223 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261571AbVGaBJS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 21:09:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731010916.KGUU3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Jul 2005 21:09:16 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0507310213110.13590@wgmdd8.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Sun, 31 Jul 2005 02:14:23 +0200 (CEST)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This patch implements Linus' idea that if you are not interested in
> pulling by HTTP, you can now say
>
> 	NO_CURL=1 make
>
> to compile everything except git-http-pull (thus not needing curl at all).

Thanks.  Obviously this does not take care of the use of curl
executable to handle http:// URL in clone and fetch, but I do
not think that is worth the trouble (we should document it
though).

I love it I can just slow down and let others submit obviously
correct patches, which I can just slurp in.
