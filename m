From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Ignore file filter
Date: Sat, 14 May 2005 16:24:22 +0200
Message-ID: <20050514142421.GG3905@pasky.ji.cz>
References: <4283CAF8.3050304@dgreaves.com> <20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com> <7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greaves <david@dgreaves.com>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 16:25:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWxZF-0007l8-6T
	for gcvg-git@gmane.org; Sat, 14 May 2005 16:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVENOYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 10:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVENOYb
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 10:24:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19353 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262765AbVENOY2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 10:24:28 -0400
Received: (qmail 3352 invoked by uid 2001); 14 May 2005 14:24:22 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 11:01:49AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "DG" == David Greaves <david@dgreaves.com> writes:
> 
> >>> if [[ $file =~ $patt ]]; then
> >> 
> >> I'm sorry but this is really nothing my bash-2.05.0(1)-release supports.
> DG> OK
> DG> I don't know how to do that.
> 
> Is that regexp or shell glob?  If regexp, expr is your friend,
> like this:
> 
>     if expr "$file" : "$patt" >/dev/null; then

Oh, this looks nice. I didn't know expr can do that. :-)

Still, I'd prefer the old-fashioned globs as primary matching mechanism.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
