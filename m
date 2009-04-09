From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-svn: always initialize with core.autocrlf=false
Date: Thu, 9 Apr 2009 20:30:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904092029490.10279@pacific.mpi-cbg.de>
References: <cover.1239276588u.git.johannes.schindelin@gmx.de> <560e98ae1d5350c6ff8db56d41089900dbaab08a.1239276588u.git.johannes.schindelin@gmx.de> <20090409165920.GA6311@dcvr.yhbt.net> <49DE2E99.9060804@pelagic.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	gitster@pobox.com
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Thu Apr 09 20:30:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrz03-0007h2-Qm
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 20:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbZDIS1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 14:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754272AbZDIS1p
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 14:27:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:45287 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751824AbZDIS1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 14:27:44 -0400
Received: (qmail invoked by alias); 09 Apr 2009 18:27:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 09 Apr 2009 20:27:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qdxE8FRtqa0MrBjPTl2HXQ+KHxzCnW6xZKXdcAl
	cKw0FqxQ3ZsP0S
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49DE2E99.9060804@pelagic.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116194>

Hi,

On Thu, 9 Apr 2009, Ferry Huberts (Pelagic) wrote:

> Eric Wong wrote:
> > Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> >> It has been reported time and time again in relation to msysGit that
> >> git-svn does not work well when core.autocrlf has any value other than
> >> 'false'.  So let's make it so by default.
> >>
> >> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > Acked-by: Eric Wong <normalperson@yhbt.net>
> > 
> >> ---
> >>  git-svn.perl |    1 +
> >>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/git-svn.perl b/git-svn.perl
> >> index 8be6be0..d4e8fc8 100755
> >> --- a/git-svn.perl
> >> +++ b/git-svn.perl
> >> @@ -325,6 +325,7 @@ sub do_git_init_db {
> >>  		command_noisy(@init_db);
> >>  		$_repository = Git->repository(Repository => ".git");
> >>  	}
> >> +	command_noisy('config', 'core.autocrlf', 'false');
> >>  	my $set;
> >>  	my $pfx = "svn-remote.$Git::SVN::default_repo_id";
> >>  	foreach my $i (keys %icv) {
> >> -- 
> >> 1.6.2.1.613.g25746
> > 
> funny that this kind of seems to get through while my suggestion (and
> proff by tests) to do the same for the cvs-import stuff resulted in
> hefty discussions and no consensus on what to do, the result of which is
> to do nothing. i guess i couldn't make myself clear enough?

Actually, I was very much in favor of it.  Care to resend, for our 
pleasure, pretty please?

Thanks,
Dscho
