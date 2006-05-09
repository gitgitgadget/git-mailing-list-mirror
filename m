From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 08 May 2006 17:36:40 -0700
Message-ID: <7vu080c9uv.fsf@assigned-by-dhcp.cox.net>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	<7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	<1147131877.2694.37.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	<1147134522.2694.45.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:36:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGDW-0000e6-8o
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWEIAgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWEIAgm
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:36:42 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:957 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750959AbWEIAgm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 20:36:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509003641.KAQZ21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 20:36:41 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1147134522.2694.45.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Tue, 09 May 2006 01:28:42 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19789>

David Woodhouse <dwmw2@infradead.org> writes:

> ... I think I
> have to add the commit and the parent manually, but that's easy enough
> to do -- the commit is obviously known, and the parent is just
> $(git-rev-parse $commit^1).

If you are going to parse it anyway, this would probably be easier.

	$ git show --patch-with-stat --pretty=fuller --parents "$commit"

Why would you want -B, by the way?
