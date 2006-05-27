From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixed Cygwin CR-munging problem in mailsplit
Date: Sat, 27 May 2006 11:25:45 -0700
Message-ID: <7vbqtjfhp2.fsf@assigned-by-dhcp.cox.net>
References: <4477262A.5000301@Intel.com>
	<7virnsk6fe.fsf@assigned-by-dhcp.cox.net> <44789309.1030002@Intel.com>
	<7vfyivfhw4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat May 27 20:25:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk3Ty-00008U-4i
	for gcvg-git@gmane.org; Sat, 27 May 2006 20:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWE0SZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 14:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWE0SZr
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 14:25:47 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:6074 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964925AbWE0SZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 14:25:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060527182546.FXQT24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 27 May 2006 14:25:46 -0400
To: Salikh Zakirov <Salikh.Zakirov@Intel.com>
In-Reply-To: <7vfyivfhw4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 27 May 2006 11:21:31 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20867>

Junio C Hamano <junkio@cox.net> writes:

> I personally think this is a right change.  Provided if MTAs on
> the path between patch originator and you are not broken and
> your MUA saved the message with CR/LF distinction in the
> contents intact, this should do more right thing.
>
> I see broken patches every once in a while, but when they are
> mangled by the mailpath, CRLF is the least of the problem; they
> have other whitespace breakage that makes them unapplicable
> anyway.
>
> Having said that, however, that historically used to be a big IF
> with capital letters.
>
>
> I have a feeling that Linus did this on purpose.  For the

Heh, I had a trailing CR after the "with capital letters." and
one blank line between paragraphs, but I now see two blank lines
there.  So even in this modern day, preserving CRLF is not
something that happens by default -- you would need to make sure
that everybody on your mailpath to the recipient is set up the
right way.

> So I am slightly in favor of the change, but just barely.

So now I am less in favor of the change than when I wrote that
response.
