From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add cg-printenv command.
Date: Mon, 9 May 2005 09:24:38 +0200
Message-ID: <20050509072438.GB3599@pasky.ji.cz>
References: <200505081911.10371.elenstev@mesatop.com> <200505082125.28521.elenstev@mesatop.com> <2970.10.10.10.24.1115610025.squirrel@linux1> <200505082159.59595.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Junio C Hamano <junkio@cox.net>,
	Marcel Holtmann <marcel@holtmann.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 09:19:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV2X5-0007s0-Gv
	for gcvg-git@gmane.org; Mon, 09 May 2005 09:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbVEIHZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 03:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbVEIHZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 03:25:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20457 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S263071AbVEIHYo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 03:24:44 -0400
Received: (qmail 7999 invoked by uid 2001); 9 May 2005 07:24:38 -0000
To: Steven Cole <elenstev@mesatop.com>
Content-Disposition: inline
In-Reply-To: <200505082159.59595.elenstev@mesatop.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 05:59:59AM CEST, I got a letter
where Steven Cole <elenstev@mesatop.com> told me that...
> On Sunday 08 May 2005 09:40 pm, Sean wrote:
> > On Sun, May 8, 2005 11:25 pm, Steven Cole said:
> > 
> > > I had intended it only as a quick check by an end-user before doing
> > > a commit that the values had been set as desired.
> > 
> > Hey Steven,
> > 
> > Rather than creating a separate command, perhaps the values could
> > automatically be added to the initial commit message in a few "CG:" lines?

I was already thinking about this and I think Sean's way makes more
sense. Also, I actually believe you should add this functionality to
commit-tree instead (commit-tree -n (dry-run), perhaps?) - so that the
user can actually check the default values commit-tree is going to use
too. *That* would be useful.

> A secondary reason for adding the cg-printenv capability was that a user would
> see this command in the cg-help list, and cg-help printenv would give:

No, I think this sucks. You should just list the variables in cg-commit
documentation if anything. That's where they matter anyway and where the
user could possibly look for them anyway.

I think the command is otherwise pretty useless, and the important thing
is, the command slots are precious (well, there are free cg-admin slots
but I think this one does not qualify there neither) - have too many
useless (or barely useful) commands and you end up as GNU Arch. So I'm
willing to add commands only when I'm convinced they will really help
the user.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
