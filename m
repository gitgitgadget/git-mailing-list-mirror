From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] Colorized git log
Date: Thu, 21 Apr 2005 19:04:18 -0600
Message-ID: <200504211904.18283.elenstev@mesatop.com>
References: <3536.10.10.10.24.1114117965.squirrel@linux1> <f0796bb7050421174647943f0c@mail.gmail.com> <20050422005452.GZ7443@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Daniel Serpell <daniel.serpell@gmail.com>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 03:04:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOmaU-0005b7-6Y
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 03:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVDVBIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 21:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVDVBIc
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 21:08:32 -0400
Received: from nacho.zianet.com ([216.234.192.105]:63502 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S261899AbVDVBI1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 21:08:27 -0400
Received: (qmail 5627 invoked from network); 22 Apr 2005 01:08:22 -0000
Received: from 216-31-65-209.zianet.com (216.31.65.209)
  by 0 with SMTP; 22 Apr 2005 01:08:22 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
In-Reply-To: <20050422005452.GZ7443@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 21 April 2005 06:54 pm, Petr Baudis wrote:

> Duh. And they say "Where possible terminfo is consulted to find the
> string to use." in their manual page. :/
> 
> > gitlog.sh: 6d24d857fb6c2f7e810954adaca1990599906f07
> > --- a/gitlog.sh
> > +++ b/gitlog.sh
> > @@ -11,11 +11,11 @@
> >  
> >  if [ "$1" = "-c" ]; then
> >  	shift
> > -	colheader=$(setterm -foreground green)
> > -	colauthor=$(setterm -foreground cyan)
> > -	colcommitter=$(setterm -foreground magenta)
> > -	colsignoff=$(setterm -foreground yellow)
> > -	coldefault=$(setterm -foreground default)
> > +	colheader="$(tput setaf 2)"
> > +	colauthor="$(tput setaf 6)"
> > +	colcommitter="$(tput setaf 5)"
> > +	colsignoff="$(tput setaf 3)"
> > +	coldefault="$(tput op)"
> >  else
> >  	colheader=
> >  	colauthor=
> 
> Please at least stick the colors in comments after the assignment.
> Not everyone knows ANSI color codes off-hand (the last thing I've
> memorized were BIOS color codes in the distant DOS days).
> 

I like the color idea, but since many people have their own idea
of what colors are appropriate, etc (I use a dark background, and
the magenta is painful), perhaps we could have a LOG_COLORS
file, similar in concept (but more readable) to the /etc/DIR_COLORS
file.  Great work !

Steven
