From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: s/git-merge-base/git-find-common-ancestor/g
Date: Sun, 11 Sep 2005 00:38:40 -0700
Message-ID: <7v64t8xddr.fsf@assigned-by-dhcp.cox.net>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net>
	<7virxbtder.fsf@assigned-by-dhcp.cox.net>
	<874q8s6q9w.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 09:39:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEMQP-0000tx-Nw
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 09:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVIKHip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 03:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVIKHip
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 03:38:45 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57305 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964811AbVIKHip (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 03:38:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911073841.PLUA20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 03:38:41 -0400
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <874q8s6q9w.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Sun, 11 Sep 2005 16:02:19 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8271>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> I've already got used to it. but, at first, the name gave me the
> impression that it merge the current branch with given base point.
>
> the current documentation says:
>
>    Finds as good a common ancestor as possible for a merge
>
> so would it be better to rename it to:
>
>    git-find-common-ancestor
>
> That's what the command does after all.

It does not find just any common ancestor, but tries to find a
set of common ancestors that are good to be used as merge bases.
So git-find-merge-base _might_ be an acceptable rename, but
git-find-common-ancestor certainly isn't.
