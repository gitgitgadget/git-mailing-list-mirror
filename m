From: Junio C Hamano <junkio@cox.net>
Subject: Re: Joining cg-*-id
Date: Mon, 19 Sep 2005 22:52:27 -0700
Message-ID: <7vy85s9tgk.fsf@assigned-by-dhcp.cox.net>
References: <1127166049.26772.26.camel@dv>
	<20050919215608.GA13845@pasky.or.cz>
	<Pine.LNX.4.58.0509191505470.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Pavel Roskin <proski@gnu.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 07:53:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHb3U-00086W-3h
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 07:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVITFwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 01:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVITFwc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 01:52:32 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35580 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932499AbVITFwb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 01:52:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920055229.EHLG3875.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Sep 2005 01:52:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 19 Sep 2005 15:16:03 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8978>

Linus Torvalds <torvalds@osdl.org> writes:

> That lack of sha1 completion is a bug. 
>
> How does the date thing work? It sounds like something horribly ambiguous, 
> but hey, maybe some useful semantics could be found.

I am not even sure what I would want to see, let alone what I
could show, when I say "show logs of what happened last week",
after I just pulled from a remote or two.

I would imagine a gitk graph with nodes colored red for commits
with last week's timestamps, would be what I would want, but
probably that is useful only because I can see in the same gitk
window how those red nodes connect with each other and with
commits outside the specified time window.  Without that context
information I would probably be lost.

> The short sha1 problem is fixed thus,

Thanks.  Applied.
