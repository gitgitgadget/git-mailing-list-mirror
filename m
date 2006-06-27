From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Mon, 26 Jun 2006 22:54:12 -0700
Message-ID: <7vpsgvf8jf.fsf@assigned-by-dhcp.cox.net>
References: <7v7j35wp84.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606251033030.3747@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 27 07:54:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv6Wh-0003Mt-Cr
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 07:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWF0FyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 01:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWF0FyP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 01:54:15 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61613 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932100AbWF0FyO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 01:54:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627055414.UHOO12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 01:54:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606251033030.3747@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 25 Jun 2006 10:47:10 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22706>

Linus Torvalds <torvalds@osdl.org> writes:

> I suspect that both could have been made to use NULL instead to indicate 
> that no pointer exists.

As long as none of the following does not dereference the NULL
pointer that should work fine:

	- memchr(NULL, ch, 0);

        - memcmp(NULL, ptr, 0);

        - stream.next_in = NULL;
          stream.avail_in = 0;
          deflate(&stream, Z_FINISH);
