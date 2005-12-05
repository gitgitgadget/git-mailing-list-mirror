From: Petr Baudis <pasky@suse.cz>
Subject: Re: make gitfakemmap standalone to fix linking error in git.c
Date: Mon, 5 Dec 2005 15:11:41 +0100
Message-ID: <20051205141141.GF22159@pasky.or.cz>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com> <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 15:12:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjH3y-0004tO-DI
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 15:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVLEOL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 09:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVLEOL0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 09:11:26 -0500
Received: from w241.dkm.cz ([62.24.88.241]:10410 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932384AbVLEOL0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 09:11:26 -0500
Received: (qmail 31392 invoked by uid 2001); 5 Dec 2005 15:11:41 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13214>

Dear diary, on Mon, Dec 05, 2005 at 02:24:47PM CET, I got a letter
where Alex Riesen <raa.lkml@gmail.com> said that...
> The patch is to fix the error introduced by previous patch, which
> inverted condition of checking for the supported case (start must be
> NULL).
> 
> On 12/5/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> > The patch is to fix linking error because of gitfakemmap referencing
> > die living in usage.c, and git.c not linking in the file. Instead of
> > hardcoding usage.o in git.c prerequisites, I separated mmap from the
> > main sources.
> 
> Why does it always happen...

Possibly not worth yet another patch submission now, but in general I
believe it's better to send new revision of the original patch rather
than another patch on top of the previous one.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
