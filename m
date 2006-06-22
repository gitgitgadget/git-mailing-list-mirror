From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Thu, 22 Jun 2006 15:07:23 -0700
Message-ID: <7v7j38j144.fsf@assigned-by-dhcp.cox.net>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 00:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtXKt-0004RD-Ev
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 00:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWFVWH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 18:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWFVWH1
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 18:07:27 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30924 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751900AbWFVWHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 18:07:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622220724.GABV18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 18:07:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 22 Jun 2006 13:53:31 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22378>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 22 Jun 2006, Junio C Hamano wrote:
>> 
>>  - diff --color (Johannes).
>
> I like colorized diffs, but let's face it, those particular color choices 
> will make most people decide to pick out their eyes with a fondue fork.

Well, I admit I do not use colorized diffs myself.  As a matter
of fact, I use specialized terminfo to disable coloring on my
terminal session, since fontifying in GNUS otherwise gives me
unreadable screen and I am too lazy to figure out how to turn it
off.

I do however usually test colored stuff with at least white and
black backgrounds,

> This patch does:
>
>  - always reset the color _before_ printing out the newline.

Sorry, although I did notice this (interrupting a long diff, or
running it with "less -r" and quitting it would leave the
terminal in funny color), I did not bother to fix it.

>  - default to red/green for old/new lines. That's the norm, I'd think.

OK.

>  - instead of that eye-popping (and eye-ball-with-a-fondue-fork-popping) 
>    purple color for metadata, use bold-face for file headers, and cyan for 
>    the frag headers. I actually prefer the "gray background" for that, but 
>    it only works well in xterms, so COLOR_CYAN it is..

Replacing it with COLOR_GRAYBG did not work out too well with
either xterm nor kterm for me, although it did work under
gnome-terminal.

Cyan foreground color is unreadable on white background and that
was why I did magenta in my original patch, but it may be just
that I am color challenged in that spectrum.
