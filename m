From: Junio C Hamano <junkio@cox.net>
Subject: Re: "Publishing your work" questions?
Date: Sat, 20 Aug 2005 10:42:34 -0700
Message-ID: <7v4q9kpks5.fsf@assigned-by-dhcp.cox.net>
References: <200508201457.00725.alan@chandlerfamily.org.uk>
	<Pine.LNX.4.58.0508200821220.3317@g5.osdl.org>
	<Pine.LNX.4.58.0508200911250.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 19:43:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6XMf-0004AC-BQ
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 19:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVHTRmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 13:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbVHTRmi
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 13:42:38 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13962 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932624AbVHTRmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 13:42:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820174235.UALA8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 Aug 2005 13:42:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508200911250.3317@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 20 Aug 2005 09:12:11 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> 	/*
> 	 * Go look for quoted single-ticks. They are always
> 	 * quoted as '\'', we don't accept anything else
> 	 */

Oh, I am extremely glad to see that somebody else understands
exactly why I do things in the "seemingly very unoptimized" way
in sq_quote() --- it allows easy parsing for non-shell users.
