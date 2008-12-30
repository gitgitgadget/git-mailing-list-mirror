From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cherry: make <upstream> parameter optional
Date: Tue, 30 Dec 2008 14:44:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812301441510.30769@pacific.mpi-cbg.de>
References: <200812291845.20500.markus.heidelberg@web.de> <alpine.DEB.1.00.0812301411480.30769@pacific.mpi-cbg.de> <200812301437.06726.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 30 14:45:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHeuP-0007GF-6a
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 14:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbYL3Nn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 08:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYL3Nn5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 08:43:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:35665 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751677AbYL3Nn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 08:43:56 -0500
Received: (qmail invoked by alias); 30 Dec 2008 13:43:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 30 Dec 2008 14:43:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Poz8fwdWPE7utOhfTcVj4Bb0gOFpQ6zbSm+TE0d
	tAV07g6q92EZ+o
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200812301437.06726.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104185>

Hi,

On Tue, 30 Dec 2008, Markus Heidelberg wrote:

> Johannes Schindelin, 30.12.2008:
> 
> > On Mon, 29 Dec 2008, Markus Heidelberg wrote:
> > 
> > > The upstream branch <upstream> now defaults to the first tracked 
> > > remote branch, which is set by the configuration variables 
> > > branch.<name>.remote and branch.<name>.merge of the current branch.
> > > 
> > > Without such a remote branch, the command "git cherry [-v]" fails 
> > > with usage output as before and an additional message.
> > > 
> > > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> > 
> > This would be a massively visible user interface change.  At the moment, 
> > it does this (which I like):
> > 
> > 	$ git cherry-pick
> > 	usage: git cherry-pick [options] <commit-ish>
> > 
> > 	    -n, --no-commit       don't automatically commit
> > 	    -e, --edit            edit the commit message
> > 	    -x                    append commit name when cherry-picking
> > 	    -r                    no-op (backward compatibility)
> > 	    -s, --signoff         add Signed-off-by:
> > 	    -m, --mainline <n>    parent number
> 
> The patch was about git-cherry, not git-cherry-pick.

Oops.

Sorry,
Dscho

P.S.: This certainly will not be the last time that I am bitten by the 
closeness of the names "cherry" (which I _never_ use) and "cherry-pick", 
which I use frequently.  Even worse: the rev-list option that could make 
that stand-alone plumbing command "cherry" obsolete is called 
_--cherry-pick_, of all things...
