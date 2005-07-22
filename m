From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Thu, 21 Jul 2005 19:50:20 -0700
Message-ID: <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 04:50:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dvnce-0002Id-Sa
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 04:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVGVCuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 22:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVGVCuY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 22:50:24 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39090 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262014AbVGVCuX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 22:50:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722025020.LAPA22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 21 Jul 2005 22:50:20 -0400
To: Bryan larsen <bryanlarsen@yahoo.com>
In-Reply-To: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> (Bryan larsen's message of "Thu, 21 Jul 2005 16:23:10 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I do not do Porcelain, but wouldn't it be nicer if we had a
Porcelain neutral "commit log template file" under $GIT_DIR
somewhere?  'vim: textwidth=75' is completely useless for
somebody like me (I almost always work inside Emacs).

Cogito seems to use $GIT_DIR/commit-template for that purpose.
Can't users put that "vim:" hint there, and if StGIT does not
use a commit template, patch it to use the same file as Cogito
does?
