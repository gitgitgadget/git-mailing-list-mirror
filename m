From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: wishlist: git info
Date: Mon, 12 Nov 2007 23:21:06 +0100
Message-ID: <20071112222106.GE2918@steel.home>
References: <fhad5q$iia$1@ger.gmane.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Neumann <tneumann@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irheo-0006AT-Oe
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505AbXKLWVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbXKLWVK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:21:10 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:16566 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbXKLWVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:21:09 -0500
Received: from tigra.home (Faf31.f.strato-dslnet.de [195.4.175.49])
	by post.webmailer.de (mrclete mo45) (RZmta 14.0)
	with ESMTP id 602715jACJOuVl ; Mon, 12 Nov 2007 23:21:07 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E1E7F277AE;
	Mon, 12 Nov 2007 23:21:06 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id C35C756D22; Mon, 12 Nov 2007 23:21:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fhad5q$iia$1@ger.gmane.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOR49Q==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64722>

Thomas Neumann, Mon, Nov 12, 2007 21:30:56 +0100:
> while git is pleasant to use in everyday work, there is one svn feature
> which is miss dearly, namely "svn info". svn info can give information
> about specific file objects, but I think its main feature is to use it
> without any path and thus just describe the current project.
> I use this a lot to quickly find out to which remote repository the
> current directory belongs (yes, some work projects tend to look very
> similar...) and what is the current state of the directory.
> 
> As a crude approximation, "git info" should print something like:
> cat .git/config | grep url
> git show | head -3

you're better of just running "gitk --all" at this point. It'll show
remote branches (with the names of remote repos prepended) and their
relations to the local repo.

> Probably not the most intelligent way to compute it, but you get the
> idea. git info should give a brief overview over the current working
> directory.

Like what? None of the commands you suggested even touch it.
Would

    git remote -r -v && git log --max-count=1 --pretty=format:'%h %s'

do what you think is what you need?

May I suggest you to consider just running "git fetch -v"?
