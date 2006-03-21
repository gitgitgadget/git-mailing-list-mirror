From: Petr Baudis <pasky@suse.cz>
Subject: Re: Bad merging with stgit or git
Date: Tue, 21 Mar 2006 21:08:47 +0100
Message-ID: <20060321200847.GS18185@pasky.or.cz>
References: <1142969653.4749.109.camel@praia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Mar 21 21:09:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLnAA-0001pV-TC
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 21:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWCUUI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 15:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWCUUI1
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 15:08:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:15074 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751719AbWCUUI0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Mar 2006 15:08:26 -0500
Received: (qmail 19154 invoked by uid 2001); 21 Mar 2006 21:08:47 +0100
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Content-Disposition: inline
In-Reply-To: <1142969653.4749.109.camel@praia>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17785>

Dear diary, on Tue, Mar 21, 2006 at 08:34:13PM CET, I got a letter
where Mauro Carvalho Chehab <mchehab@infradead.org> said that...
> With git-cat-file, it shows:
> 
> $ git-cat-file commit e338b736f1aee59b757130ffdc778538b7db18d6
> tree b233a18f740a2883e4863506175f671d821f1e5e
> parent cb31c70cdf1ac7034bed5f83d543f4888c39888a
> author Mauro Carvalho Chehab <mchehab@infradead.org> 1141965004 -0300
> committer Mauro Carvalho Chehab <mchehab@infradead.org> 1141965004 -0300
> 
> Merging Linus tree

Our IRC hypothesis:

gitweb shows two commits in sequence there,

	11 days ago Mauro Carvalho ...     Merge branch 'origin'
	11 days ago Mauro Carvalho ...     Merging Linus tree

where the "Merge branch 'origin'" commit is a true merge commit, but a
rather boring one. There were conflicts during the merge, and according
to mchebab they were "resolved" by (incorrectly) doing:

	...edit <files>...
	git-commit <files>

With the old Git version (probably v1.1.4, but I'm not so sure when
looking at 1.1.4's git-commit.sh), git-commit would happily do the
commit, but wouldn't record the commit as a merge.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
