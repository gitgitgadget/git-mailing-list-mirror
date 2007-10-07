From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] setup/rev-parse: allow HEAD to be spelled 'head'
Date: Sun, 7 Oct 2007 17:49:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710071747340.4174@racer.site>
References: <1191553750-25562-1-git-send-email-sam.vilain@catalyst.net.nz>
 <20071005065139.GA2623@steel.home> <47080AC4.3040902@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZJv-0007I9-5u
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbXJGQt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbXJGQt0
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:49:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:49780 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751656AbXJGQtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:49:25 -0400
Received: (qmail invoked by alias); 07 Oct 2007 16:49:23 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp049) with SMTP; 07 Oct 2007 18:49:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IQmxtTg8I5swM2K2QnRVP5mwKIROTcE1gKIoyCA
	cfnzV+VbVIOLfw
X-X-Sender: gene099@racer.site
In-Reply-To: <47080AC4.3040902@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60199>

Hi,

On Sun, 7 Oct 2007, Sam Vilain wrote:

> Alex Riesen wrote:
> > Sam Vilain, Fri, Oct 05, 2007 05:09:10 +0200:
> >> If the repository got mangled by FAT capitalization rules, then a ref
> >> such as "HEAD" will become "head" once it is back on a non-FAT FS.
> >> Check for this condition in resolve_refs and in the setup code.
> >>
> >> Suggested-by: Francois Marier <francois@debian.org>
> >> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> >> ---
> >>   This should probably help people putting their git repos on
> >>   FAT USB sticks.
> > 
> > Can the people just mount FAT partitions with shortname=mixed?
> 
> Of course, that is probably a solution to the problem, whereas my patch
> is a workaround.
> 
> Now, I realise that this might open a can of worms ... would we also
> want to go looking for files called "pack-ab~1.pac" ?

Hell, no.

> Almost certainly not - but this solves the most immediate problem 
> experienced by people putting their git repositories onto FAT 
> filesystems mounted with the default options, which will say "FATAL: not 
> a git repository" otherwise.

You certainly mean the issue of capitalization; yes, that is my 
experience, too.  Somehow, "HEAD" is the culprit.

Ciao,
Dscho

P.S.: seems you have quite cute coworkers.
