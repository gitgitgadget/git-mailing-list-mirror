From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: wishlist: git info
Date: Tue, 13 Nov 2007 00:41:15 +0100
Message-ID: <20071112234115.GJ2918@steel.home>
References: <fhad5q$iia$1@ger.gmane.org> <20071112222106.GE2918@steel.home> <4738D8AA.1030604@users.sourceforge.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Neumann <tneumann@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:41:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IriuV-0006o8-AC
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 00:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757043AbXKLXlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 18:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758481AbXKLXlT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 18:41:19 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:60188 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759488AbXKLXlR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 18:41:17 -0500
Received: from tigra.home (Faf31.f.strato-dslnet.de [195.4.175.49])
	by post.webmailer.de (fruni mo27) (RZmta 14.0)
	with ESMTP id k021b2jACI6iya ; Tue, 13 Nov 2007 00:41:15 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 77726277AE;
	Tue, 13 Nov 2007 00:41:15 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 58E7B56D22; Tue, 13 Nov 2007 00:41:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4738D8AA.1030604@users.sourceforge.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOR49Q==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64734>

Thomas Neumann, Mon, Nov 12, 2007 23:50:18 +0100:
> >> Probably not the most intelligent way to compute it, but you get the
> >> idea. git info should give a brief overview over the current working
> >> directory.
> >
> > Like what? None of the commands you suggested even touch it.
> probably "current working directory" was not the best way to phrase it.
> I mean state of the repository, which in my case is a clone of a central
> repository.
> My commands show (ignoring formatting): 1. the remote repositories with
> URL 2. the current head commit hash 3. the date of the head commit.

Don't you want to know where the remote repo is at?

> Which gives a pretty decent idea about the state of the repository.

...which in Git-lingo would be misunderstood as the output of
git-status :)

> > Would
> >
> >     git remote -r -v && git log --max-count=1 --pretty=format:'%h %s'
> >
> > do what you think is what you need?
> perhaps, the first command gives me an error (git 1.5.2.5). This here is
> nearly ok

Ach, make it "git remote -v". It does exactly showing of the url.

Dunno what I wanted the "-r" for. Probably left from thinking of
"git branch -r" (which shows remote branches).

> git remote && git log --max-count=1 --pretty=format:'%H %cD'
> 
> except the missing URL from git remote (but perhaps your options include
> it with a newer git version, will test).

It is there since 1.5.3-rc1
