From: Junio C Hamano <junkio@cox.net>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Thu, 17 Nov 2005 14:54:40 -0800
Message-ID: <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 23:56:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcseT-0000Ky-CI
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 23:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVKQWym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 17:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVKQWym
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 17:54:42 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10932 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964881AbVKQWyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 17:54:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117225325.IEAW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 17:53:25 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 17 Nov 2005 12:36:30 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12166>

Linus Torvalds <torvalds@osdl.org> writes:

> ..., you'd have to write it the other way around:
>
> 	"last thursday and one day before"
>
> which is insane (it's usually the same as "last wednesday" _except_ if 
> today is Thursday, in which case "last wednesday" is yesterday, and "last 
> thursday and one day before" is eight days ago).
> ...
> I doubt anybody would ever use insane dates like that, but I thought I'd 
> point out that the approxidate parsing is not exactly "standard English".

It is not English but Gittish, which is fine, but it somehow
reminds me of the funny way users make themselves understood by
IF parsers ;-).  I am afraid you started small but now are going
towards the same insanity of gnudate (it has insane yacc grammar
to grok these things), and I suspect we'd better draw a line
somewhere.

> Side note 2: if you want to avoid spaces (because of quoting issues), you 
> can use any non-alphanumberic character instead. So
>
> 	git log --since=2.days.ago
>
> works without any quotes.

I think this is a useful change.  Thanks.
