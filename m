From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Thu, 18 Aug 2005 18:04:45 -0700
Message-ID: <7vfyt6enyq.fsf@assigned-by-dhcp.cox.net>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
	<7vek8t7bva.fsf@assigned-by-dhcp.cox.net>
	<7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508170830050.3553@g5.osdl.org>
	<20050818172646.GA18459@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 03:05:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5vJR-0002ft-9P
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 03:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVHSBEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVHSBEr
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 21:04:47 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59117 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964778AbVHSBEr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 21:04:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819010446.JRUF25443.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 Aug 2005 21:04:46 -0400
To: Sam Ravnborg <sam@ravnborg.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> I prefer to add it myself rather than to have it added automatically -
> but mayve thats you me being a bit mistrusting.
>
> The only git- command I use today is git-applymbox.

If you did not have that "add it myself" preference, I would
have recommended the (not counting the flags) second parameter
to git-applymbox.

While we are on the topic of applymbox, currently it takes this
form:

$ applymbox [ -k ] [ -q ] (-c .dotest/msg_num | mail_archive) [Signoff_file]"

It may make more sense to change it to:

    applymbox [-k] [-q] [-s <signoff>] ( -c .dotest/<msg_num> | <mbox>... )
