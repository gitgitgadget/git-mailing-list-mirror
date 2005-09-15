From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shell quoting
Date: Thu, 15 Sep 2005 12:35:00 -0700
Message-ID: <7vpsrayviz.fsf@assigned-by-dhcp.cox.net>
References: <43290BB8.90501@zytor.com>
	<7vy85yahjk.fsf@assigned-by-dhcp.cox.net> <4329C11A.1040302@zytor.com>
	<Pine.LNX.4.58.0509151153140.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 21:35:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzVw-0006Zg-7P
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbVIOTfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965273AbVIOTfF
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:35:05 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:28130 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965229AbVIOTfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 15:35:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915193501.RFWG20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 15:35:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509151153140.26803@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 15 Sep 2005 12:01:17 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8632>

Linus Torvalds <torvalds@osdl.org> writes:

> You could expand "sq_quote" to handle '!' and '\' characters the exact
> same way it handles the single tick (end single-tick quoting, do \! or \\
> and start single-tick quoting again) and that might be good enough for
> tcsh.
>
> IOW, the string "a\b'c!d" would become 'a'\\'b'\''c'\!'d' after 
> surrounding sq_quote with single-ticks.

I vaguely recall you had a code that assumes what sq_quote()
produces and unquote it without using shell.  If somebody does
the above change for '!' and '\', that code may need to be
checked and adjusted as well.

Sorry I could not give more specifics -- I've been looking for
the code I am talking about unsuccessfully for the past 30
minutes..
