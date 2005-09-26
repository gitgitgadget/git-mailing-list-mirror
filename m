From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add "git-update-ref" to update the HEAD (or other) ref
Date: Sun, 25 Sep 2005 21:25:32 -0700
Message-ID: <7vd5mwlakj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
	<7vhdc8n2xb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509251747290.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 06:26:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJkYi-00038a-LR
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 06:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVIZEZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 00:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVIZEZh
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 00:25:37 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7862 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932371AbVIZEZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 00:25:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926042534.HLSV776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 00:25:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509251747290.3308@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 25 Sep 2005 17:50:33 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9299>

Linus Torvalds <torvalds@osdl.org> writes:

> I was actually thinking of maybe entirely replacing "read_ref()" with the
> more powerful "resolve_ref()" - moving resolve_ref() into refs.c.
>
> That way there's only one place that knows about the "ref:" thing.

That would make sense.  But I am feeling a bit too weak tonight
and am going to crash now.
