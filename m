From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Fri, 28 Jul 2006 03:30:38 +0200
Message-ID: <20060728013038.GH13776@pasky.or.cz>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de> <200607262039.25155.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jul 28 03:30:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6HBd-0002w4-SF
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 03:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWG1Bam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 21:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWG1Bam
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 21:30:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31928 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751276AbWG1Bam (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 21:30:42 -0400
Received: (qmail 21316 invoked by uid 2001); 28 Jul 2006 03:30:38 +0200
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200607262039.25155.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24359>

Dear diary, on Wed, Jul 26, 2006 at 08:39:24PM CEST, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> On Wednesday 26 July 2006 19:41, Johannes Schindelin wrote:
> > 
> > If dir2 already exists, git-mv should move dir1 _into_dir2/.
> > Noticed by Jon Smirl.
> 
> Thanks for adding this test.
> BTW, the original PERL script passes it quite fine.
> 
> I just looked at Jon's problem. Doesn't seem to be related to
> git-mv or git at all, but more a cogito problem.
> I have some cogito-0.18pre installed, and cg-patch is patching
> the stuff all itself, not using git for this. Pasky?

Unfortunately, git-apply is still quite unusable for Cogito. It can do
fuzzy merging now, but here's some random list of more issues I still
have with it (I'm leaving for some two weeks or so of holiday soon so I
won't have to fix them soon personally; it'd be nice if someone did,
though ;) :

  (i) No git-apply -R - well, it seems to me that I revert patches all
the time, don't you?

  (ii) I'd like git-apply to be as verbose as patch is, that is list
the files it touches as it goes

  (iii) There's no reject handling besides "panic" right now - it should
be able to create .rej files so that the user can fix things up

  (iv) I need git-apply to add/remove to/from index new/gone files,
while at the same time...

  (v) I want to allow applying of patches to working copy that is not
completely clean, even on top of modified files

But yes, I'd like cg-patch to move to use git-apply. It's currently
_way_ too scary.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
