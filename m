From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] HTTP partial transfer support for object, pack, and index transfers
Date: Fri, 30 Sep 2005 00:47:30 -0700
Message-ID: <7vk6gz6lpp.fsf@assigned-by-dhcp.cox.net>
References: <20050928171404.GA15593@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 09:49:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELFcF-0007fk-5A
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 09:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVI3Hrc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 03:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVI3Hrc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 03:47:32 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13446 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932567AbVI3Hrc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 03:47:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930074726.JNFI29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Sep 2005 03:47:26 -0400
To: Nick Hengeveld <nickh@reactrix.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9545>

I took a look at this patch.  It did not cleanly apply anymore,
but I merged it anyway, and then took the liberty of updating it
further, according to your response to my earlier comments.

They will appear near the tip of the proposed updates branch.
I'd appreciate it if you could check it out and see I did not
break things by mistake.
