From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Support for configurable git command aliases
Date: Mon, 29 May 2006 10:02:46 +0200
Message-ID: <20060529080246.GT11941@pasky.or.cz>
References: <torvalds@osdl.org> <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org> <200605271252.k4RCqZhR003192@laptop11.inf.utfsm.cl> <20060528215945.GD10488@pasky.or.cz> <7v7j45d1wz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 10:03:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkciM-00029e-Hd
	for gcvg-git@gmane.org; Mon, 29 May 2006 10:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWE2ICs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 04:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWE2ICs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 04:02:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64446 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750757AbWE2ICr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 04:02:47 -0400
Received: (qmail 20308 invoked by uid 2001); 29 May 2006 10:02:46 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7j45d1wz.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20933>

Dear diary, on Mon, May 29, 2006 at 04:01:48AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@ucw.cz> writes:
> 
> >> I don't like this syntax. What other stuff (beside "cmd") would be under
> >> "[alias "co"]? Why not simply:
> >> 
> >>         [alias]
> >> 		co = commit -a
> >> 		publish = push public.site.com:/pub/scm/my-public-repo
> >
> > Nice, I like this.
> 
> Sorry, I don't.  The left hand side of '=' does not allow
> anything but alnum and squashes the case.

Does that really matter that much? Perhaps we might support something
like

	"!ooOk" = commit -a

(and it will probably not do what the user expects if he sticks
whitespaces in).

> Please stick to [alias "co"] syntax.

That sucks, e.g. because it's alias-specific, and it's inconsistent.
I can't have anything like "cgalias" then.

Let's make some effort to keep the syntax clean...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
