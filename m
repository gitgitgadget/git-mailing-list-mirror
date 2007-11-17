From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Trivial patch to git-svn
Date: Sat, 17 Nov 2007 13:54:32 -0800
Message-ID: <20071117215432.GB28755@muzzle>
References: <473A1D9F.4030103@facebook.com> <20071117211253.GB31598@mayonaise> <473F5C75.3040707@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 22:54:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItVcq-000578-7m
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 22:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbXKQVyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 16:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbXKQVyd
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 16:54:33 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33711 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbXKQVyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 16:54:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 686D87DC0FE;
	Sat, 17 Nov 2007 13:54:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <473F5C75.3040707@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65315>

Adam Roben <aroben@apple.com> wrote:
> Eric Wong wrote:
> >David Reiss <dreiss@facebook.com> wrote:
> >  
> >>From d9f93dc1c503c5f42b27485b2c35b38e8c9bca44 Mon Sep 17 00:00:00 2001
> >>From: David Reiss <dreiss@dreiss-vmware.(none)>
> >>Date: Tue, 13 Nov 2007 13:47:26 -0800
> >>Subject: [PATCH] Fix a typo and add a comma in an error message in 
> >>git-svn
> >>
> >>Signed-off-by: David Reiss <dreiss@facebook.com>
> >>---
> >> git-svn.perl |    2 +-
> >> 1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >>diff --git a/git-svn.perl b/git-svn.perl
> >>index e3e00fd..981cdd6 100755
> >>--- a/git-svn.perl
> >>+++ b/git-svn.perl
> >>@@ -391,7 +391,7 @@ sub cmd_set_tree {
> >> sub cmd_dcommit {
> >> 	my $head = shift;
> >> 	git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
> >>-		'Cannot dcommit with a dirty index.  Commit your changes 
> >>first'
> >>+		'Cannot dcommit with a dirty index.  Commit your changes 
> >>first, '
> >> 		. "or stash them with `git stash'.\n";
> >> 	$head ||= 'HEAD';
> >> 	my @refs;
> >>    
> >
> >I am not an English expert, but both seem acceptable to me.  Anybody else
> >agree/disagree?
> >  
> 
> I don't think the comma matters very much, but having a space between 
> "first" and "or" is pretty important. :-)

Good eyes, thanks Adam.

Acked-by: Eric Wong <normalperson@yhbt.net>

Pushed out to http://git.bogomips.org/git-svn.git

Along with several other changes
(http://article.gmane.org/gmane.comp.version-control.git/65314)

-- 
Eric Wong
