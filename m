From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Invert numbers and names in the git-shortlog summary
	mode.
Date: Tue, 11 Dec 2007 22:13:41 +0100
Message-ID: <20071211211341.GB6902@elte.hu>
References: <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201> <20071211115914.GJ30948@artemis.madism.org> <20071211122539.GA13945@sigill.intra.peff.net> <20071211140508.GA12204@elte.hu> <20071211144351.GA15448@artemis.madism.org> <20071211145709.GB19427@elte.hu> <20071211152412.GB15448@artemis.madism.org> <20071211154841.GA29805@elte.hu> <20071211160744.GE15448@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <g
X-From: git-owner@vger.kernel.org Tue Dec 11 22:14:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CRF-0000Ah-VX
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXLKVO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbXLKVO2
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:14:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36730 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbXLKVO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:14:27 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1J2CQE-0002Vb-F9
	from <mingo@elte.hu>; Tue, 11 Dec 2007 22:13:52 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E05233E219F; Tue, 11 Dec 2007 22:13:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071211160744.GE15448@artemis.madism.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67941>


* Pierre Habouzit <madcoder@debian.org> wrote:

> > for example, if i type "git-checkout" in a Linux kernel tree, it 
> > just sits there for up to a minute, and "does nothing". That is 
> > totally wrong, human-interaction wise. Then after a minute it just 
> > returns. What happened? Why? Where? A newbie would then try 
> > "git-checkout -v", using the well-established "verbose" flag, but 
> > that gives:
> > 
> >  Usage: /usr/bin/git-checkout [-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]
> 
> not anymore:
> 
>     $ git checkout -v
>     error: unknown switch `v'
>     usage: git-branch [options] [<branch>] [<paths>...]
> 
> 	-b ...                create a new branch started at <branch>
> 	-l                    create the new branchs reflog
> 	--track               tells if the new branch should track the remote branch
> 	-f                    proceed even if the index or working tree is not HEAD
> 	-m                    performa  three-way merge on local modifications if needed
> 	-q, --quiet           be quiet
> 
> Not all commands are migrated to this new scheme though.
> 
> The next git has a _lot_ of things done better wrt UI and such issues. 
> Though some backward incompatible changes must be introduced with the 
> proper deprecation warnings, so that people can adapt.

hey, cool! Just when i decide to complain about it, after 2 years of 
suffering, it's already fixed in the devel branch =;-) I'll post 
suggestions once i have tried out the next version. I'm happy that the 
git "first impression" that new users are getting (and the many pitfalls 
that they can fall into) is being actively reviewed and improved. It's i 
think the main barrier for git world dominance :-)

	Ingo
