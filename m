From: Petr Baudis <pasky-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: rethinking patch management with GIT / topgit
Date: Sun, 21 Mar 2010 21:36:26 +0100
Message-ID: <20100321203626.GE3533@machine.or.cz>
References: <201003201802.51129.thomas@koch.ro>
	<20100320174740.GC4535@machine.or.cz>
	<201003201953.34666.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Koch <thomas-5j3myg3OO4w@public.gmane.org>
X-From: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org Sun Mar 21 21:36:39 2010
Return-path: <vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>
Envelope-to: gcvp-vcs-pkg@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>)
	id 1NtRt1-00023o-0v
	for gcvp-vcs-pkg@m.gmane.org; Sun, 21 Mar 2010 21:36:39 +0100
Received: from localhost ([127.0.0.1] helo=alioth.debian.org)
	by alioth.debian.org with esmtp (Exim 4.69)
	(envelope-from <vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>)
	id 1NtRt0-0006v9-Q8
	for gcvp-vcs-pkg@m.gmane.org; Sun, 21 Mar 2010 20:36:38 +0000
Received: from w241.dkm.cz ([62.24.88.241] helo=machine.or.cz ident=postfix)
	by alioth.debian.org with esmtp (Exim 4.69)
	(envelope-from <pasky-DDGJ70k9y3lX+M3pkMnKjw@public.gmane.org>) id 1NtRsr-0006uZ-9t
	for vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org;
	Sun, 21 Mar 2010 20:36:34 +0000
Received: by machine.or.cz (Postfix, from userid 2001)
	id 44C2D86208C; Sun, 21 Mar 2010 21:36:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003201953.34666.thomas-5j3myg3OO4w@public.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-policyd-weight: using cached result; rate: -7.6
X-Spam-ASN: AS6830 62.24.80.0/20
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none shortcircuit=no
	autolearn=failed version=3.2.5
X-BeenThere: vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/options/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>
List-Help: <mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=subscribe>
Sender: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
Errors-To: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142859>

On Sat, Mar 20, 2010 at 07:53:34PM +0100, Thomas Koch wrote:
> Petr Baudis:
>   - tg recreate <patchset> <newbase> <new patchset name>
>     Creates a new patchset with root <newbase> by creating new patch branches 
> for each patch branch in <patchset>
>     This command is useful if you need to keep the old patchset to maintain an 
> older version of your Debian package.

This means wiping out history again; in TopGit, you would ideally
checkpoint all the branches within the patchset, then just tg update
your branches. It's another matter that the former is now difficult to
do easily.

> I don't see this. What do I miss? All metadata I'd need to manage is:
> - one file with the name of each branch, it's last commit and the names of its 
> dependencies (the root of the patchset, if empty)
> - one message file for each patch
> - the root of the patchset
> 
> The example commands given above would manipulate or read the patchset branch 
> in the background much like pristine-tar does it with its metadata branch.

Hmm, to a degree I misunderstood your idea. You would still need quirky
commands to update the references when you make a new commit, to go to a
certain patch (at which point git will start acting a bit annoyed since
it's not on a branch), etc. Other than that, I can offer only my gut
feeling.  ;-)

> >   Wouldn't it be better to do the collapsing/expanding instead, e.g.
> > have a convention for patchset/stage branch tying up all patchset/*
> > branches, and an alias that lists only */stage branches and another that
> > lists only patchset/* minus patchset/stage branches.
> So you propose not to delete/recreate the patch branches but to provide extra 
> commands to list only the desired subset of branches? This would still mean 
> that I'd see douzens of patch branches in gitweb and that I't need to push 
> douzens of branches to my co-packagers. - That doesn't solve it for me.

There are already some patches in the wild to make gitweb topgit-aware;
I don't see why is the latter a problem.

> I hope I managed to make it clearer this time. I believe my proposals are 
> incompatible to topgit and thus would require a new project from scratch. 

Yes, I finally understood what do you mean, sorry for being a bit dense.

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
