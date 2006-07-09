From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [RFC+PATCH 1/1] Move SCM interoperability tools into scm/
Date: Sun, 9 Jul 2006 15:23:09 -0700
Message-ID: <20060709222308.GA4153@h4x0r5.com>
References: <11524258261798-git-send-email-ryan@michonline.com> <46a038f90607091426u5a6ea328h2090a876e51725ce@mail.gmail.com> <20060709221326.GU29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 00:24:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzhhM-0004nH-6t
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 00:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbWGIWYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 18:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWGIWYR
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 18:24:17 -0400
Received: from h4x0r5.com ([70.85.31.202]:25616 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1161195AbWGIWYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 18:24:16 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FzhgD-0006OJ-BY; Sun, 09 Jul 2006 15:23:09 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060709221326.GU29115@pasky.or.cz>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23573>

On Mon, Jul 10, 2006 at 12:13:26AM +0200, Petr Baudis wrote:
> Dear diary, on Sun, Jul 09, 2006 at 11:26:59PM CEST, I got a letter
> where Martin Langhoff <martin.langhoff@gmail.com> said that...
> > So I have to ask... what are the expected benefits of the move?
> 
> I've been meaning to do something like this for some time already; my
> itch have been the builtins. The tree size _is_ getting out of hand and
> a little more categorization of the sources would certainly help.

That's what I was thinking, as well, basically.  I started with the "scm
interop" tools because they should be the least controversial to move
around.

> Although I'd take a different approach:
> 
> 	libgit/
> 	builtin/
> 	standalone/
> 	scripts/
> 
> > In any case, use /interop instead. /scm in the tree of an SCM could be
> > anything ;-)
> 
> I agree on this point.

Very good point.

So these seem obvious to me:
	libgit/ (maybe just lib/?)
	builtin/
	interop/

I'm less sure of the rest, but I'll poke at doing the above for the
moment, and worry about the rest later.

Comments on a way to make the Makefile less repetitive would be
appreciated, though.



-- 

Ryan Anderson
  sometimes Pug Majere
