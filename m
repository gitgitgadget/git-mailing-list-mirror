From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Do not print "log" and "shortlog" redundantly in commit view
Date: Sat, 7 Oct 2006 16:17:21 +0200
Message-ID: <20061007141721.GC20017@pasky.or.cz>
References: <eg51fi$7rs$2@sea.gmane.org> <20061006221603.50873.qmail@web31815.mail.mud.yahoo.com> <20061007132457.GB20017@pasky.or.cz> <200610071605.23277.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 16:17:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWCzl-0005Bj-Dv
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 16:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWJGOR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 10:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWJGOR0
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 10:17:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18115 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932090AbWJGORX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 10:17:23 -0400
Received: (qmail 29500 invoked by uid 2001); 7 Oct 2006 16:17:21 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610071605.23277.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28487>

Dear diary, on Sat, Oct 07, 2006 at 04:05:22PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> > Then it will be impossible to get snapshot of any subtree (apart of
> > manually constructing the URL). Hmm, and it's a bug that we don't show
> > the snapshot link when listing tree entry in tree listing, I thought
> > we did in the past...?
> > 
> > I think we should make it more clear what each of the bars concerns,
> > perhaps doing some more significant redesign:
> > 
> > [summary] is redundant, you have this big project name link in the top
> > left corner. All the other navbar options concern commit, so why not
> > merge it with the awkward commit box below the navbars?
> > 
> > All the "views bar" options concern the currently selected object, so
> > why not merge it with the object "descriptor", that is the path?

To make the idea more graphic:

Commit title master             shortlog | log | commit | commitdiff | tree

[project.git] / subdir / filename              blame | history | raw | HEAD


Or perhaps first the navigation, then the title.

> > Patches will follow up.

I have decided to reprioritize and do other stuff now. I will get back
to it sometime later if noone does it first.

> I think that "summary" has it's place rather in the bottom navigation 
> bar, in the "views bar", because it is related to current object not 
> current commit (the "tree" entry in top navigation bar, "actions bar", 
> is somewhat misleading because it actually is the tree of the commit, 
> not any tree).

It's not related to current object any more than to the current commit
and is really out-of-place in both bars. It's related only to the
current project.

We _do_ have a project-global bar at each page. It's the footer,
containing the description and RSS link. What about stashing it there?
;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
