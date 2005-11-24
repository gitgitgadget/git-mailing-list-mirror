From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rename git-config-set to git-repo-config
Date: Thu, 24 Nov 2005 14:28:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de>
 <200511221831.03954.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
 <438371E8.2030701@op5.se> <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
 <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
 <43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 14:30:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfH9R-00012N-Ez
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 14:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVKXN2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 08:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbVKXN2d
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 08:28:33 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22435 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750774AbVKXN2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 08:28:32 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B3A7413FEE1; Thu, 24 Nov 2005 14:28:31 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 971479F410; Thu, 24 Nov 2005 14:28:31 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6D3DE9F409; Thu, 24 Nov 2005 14:28:31 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 49DA713FEE1; Thu, 24 Nov 2005 14:28:31 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12708>

Hi,

On Thu, 24 Nov 2005, Junio C Hamano wrote:

> Thanks for the patch.  I unfortunately was doing the same,
> because I wanted to get the repo-format-validation stuff into a
> presentable shape, and I thought this would interfere with it
> and wanted to do it first (fortunately it didn't).  They are
> both in the proposed updates branch.  At a quick glance, I think
> your patch is identical to what I did (there aren't that many
> different ways to rename a command after all).

Well, there are differences:

- I did not adjust the length of the "=====" line in the dox,

- I adjusted the punch line to "Get and set options in .git/config."
  (both in git-repo-config and git, but you have it in git, exchanged...), 
  and

- I did not rename the usage string in repo-config.c.

> At least we should work on 5.6, if not 5.5.

Agree. I don't find too many bad things about

	open F, 'git-ls-files -z |' or die 'blabla';

> I do not use git-mv myself.  It does not work in subdirectories,
> and typing Documentation/ twice to move just one file is a
> chore, so I tend to just 'R' (rename) the file, move to the
> renamed file, and '!' (run shell command on the specified path)
> with 'git-add', all within a single Emacs dired buffer.

Well, I don't use Emacs any longer, since it was such a hassle to install 
it on every machine. I still like it, though.

As for git-mv: looks like we need a "git-perl-setup.perl", right?

> An option to git-format-patch _might_ make sense someday.  Maybe
> after the world domination ;-).
> 
> Oh, wait.  It already can produce renaming patches, just does
> not do it by default.
> 
> 		Junio "again I forgot what I implemented before;
> 		sheesh I even used it myself to feed some patches
>                 to Linus" Hamano

*grin* Thanks for pointing that out, Oh Merciful Maintainer (OMM)!

Ciao,
Dscho "trying to find a place to put his flagellations which is hard in 
the absence of a last name in his typical signature"
