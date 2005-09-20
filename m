From: Junio C Hamano <junkio@cox.net>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 18:53:55 -0700
Message-ID: <7v8xxsfqrw.fsf@assigned-by-dhcp.cox.net>
References: <20050919134838.GC2903@pasky.or.cz>
	<20050919163219.GA8862@puritan.pnetwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 03:54:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXKi-0000Pc-BF
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 03:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVITByE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 21:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVITByE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 21:54:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56304 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964826AbVITByD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 21:54:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920015358.HRZB11028.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 21:53:58 -0400
To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8948>

Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org> writes:

> If we stop using GECOS, then can we please start using $EMAIL (or
> perhaps use it regardless of whether we use GECOS or not)?  A lot of
> applications seem to look for $EMAIL and I think that it's universal
> enough for git to use it as well.  To me it seems that both
> GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME, and
> GIT_COMMITTER_EMAIL can use it,...

I am not convinced $EMAIL is used as widely as you claim above
(could you give a list of applications please?), but if it is
that sounds like a sensible idea.
