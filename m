From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Silent File Mods Being Committed
Date: Fri, 24 Mar 2006 02:12:17 +0100
Message-ID: <20060324011217.GP19263@pasky.or.cz>
References: <E1FMH3o-0001B5-Dw@jdl.com> <7vek0t68we.fsf@assigned-by-dhcp.cox.net> <20060323214710.GV18185@pasky.or.cz> <7vk6ak4tzp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@jdl.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 02:12:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMaqm-0003Gq-07
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 02:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422946AbWCXBMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 20:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422948AbWCXBMT
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 20:12:19 -0500
Received: from w241.dkm.cz ([62.24.88.241]:197 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422946AbWCXBMS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 20:12:18 -0500
Received: (qmail 24511 invoked by uid 2001); 24 Mar 2006 02:12:17 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6ak4tzp.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17894>

Dear diary, on Fri, Mar 24, 2006 at 12:32:58AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Thu, Mar 23, 2006 at 06:13:21AM CET, I got a letter
> > where Junio C Hamano <junkio@cox.net> said that...
> >>  (2) audit all the scripts to make sure they do not get upset if
> >>      we add trailing +/- to the status letter, and do that
> >>      unconditionally, like the attached patch does.
> >
> > Cogito will get upset since we assume the mode field is one-char in our
> > regexps, and when we don't, we compare the mode field with strings and
> > that would obviously fail if you add random stuff to it.
> >
> > Otherwise, I like this idea, though.
> 
> Likewise.  If it was not obvious, I am not going to commit that
> myself.  If jdl or somebody cares enough, he or she can prepare
> a a set of patches to git-core, Cogito and StGIT (at least these
> three should be covered) to teach them the trailing +/- letter,
> _and_ parrot my patch back at me.  Hint, hint...

Well, or it can just add the option to Core Git. Just unconditional
implementation of (2) is no-go because it would break backwards
compatibility, which is baaad.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
