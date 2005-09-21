From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Core GIT] Long-term cherrypicking
Date: Wed, 21 Sep 2005 16:26:51 -0700
Message-ID: <7voe6mngsk.fsf@assigned-by-dhcp.cox.net>
References: <20050921164015.GC21971@pasky.or.cz>
	<7vzmq6p2an.fsf@assigned-by-dhcp.cox.net>
	<20050921221931.GC10575@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 01:28:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIDzN-0007k5-DF
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 01:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVIUX0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 19:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVIUX0x
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 19:26:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:9621 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965179AbVIUX0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 19:26:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050921232652.KXRU21449.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Sep 2005 19:26:52 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050921221931.GC10575@pasky.or.cz> (Petr Baudis's message of
	"Thu, 22 Sep 2005 00:19:31 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9086>

Petr Baudis <pasky@suse.cz> writes:

> Well, I guess that if you are going to do this all, it really gets
> visible that this rebasing stuff is really quite an ugly hack and that
> you are probably much better off with something like StGIT. ;-)

Yes.

> *1* I find the fast-forward restriction more and more annoying in this
> context, actually, and I'm seriously considering dropping it from Cogito
> altogether.

My "pu" is always floating and I have this in my
.git/remotes/ko:

    URL: master.kernel.org:/pub/scm/git/git.git/
    Push: master maint rc +pu
