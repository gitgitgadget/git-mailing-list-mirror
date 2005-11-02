From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix segfaults caused by invalid tags
Date: Wed, 02 Nov 2005 12:28:46 -0800
Message-ID: <7vwtjqrdz5.fsf@assigned-by-dhcp.cox.net>
References: <20051102200751.26904.5780.stgit@machine.or.cz>
	<Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 21:30:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXPE3-000591-8A
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbVKBU2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbVKBU2s
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:28:48 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:57241 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965208AbVKBU2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 15:28:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102202823.NJGD9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 15:28:23 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 2 Nov 2005 21:16:13 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11037>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Shouldn't a warning be issued in every of those cases? I don't know, but 
> those tags pointing nowhere don't seem useful to me.

Yes they should warn.

It is not just "don't seem useful"; it is a corrupt repository.
