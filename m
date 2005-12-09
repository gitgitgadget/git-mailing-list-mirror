From: linux@horizon.com
Subject: Re: as promised, docs: git for the confused
Date: 9 Dec 2005 16:54:14 -0500
Message-ID: <20051209215414.14072.qmail@science.horizon.com>
References: <7vzmna2ig2.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Dec 09 22:57:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkqCG-0000yz-HG
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 22:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVLIVyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 16:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVLIVyX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 16:54:23 -0500
Received: from science.horizon.com ([192.35.100.1]:59718 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964889AbVLIVyV
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 16:54:21 -0500
Received: (qmail 14073 invoked by uid 1000); 9 Dec 2005 16:54:14 -0500
To: junkio@cox.net
In-Reply-To: <7vzmna2ig2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13437>

> This primarily comes from the way git is architected.  We have
> many commands that are not so interesting from the end-user
> perspective.  If git were architected differently, many of them
> may not exist in executable command form, but would instead be
> library functions and listed in section 3git of the manual.

But you also have commands of interest or not to different classes
of users.

Some users want to track someone else's repository.
Others want to generate their repository from scratch.
Or maybe import some history from CVS.

Some users spend all day applying patches.
Some spend all day creating patches.
Some just want to retrieve the kernel and run "git bisect"
to help the kernel developers.  They will neither generate
nor apply patches.
Some want access to a developer's git repository to test
bleeding-edge drivers.

Some folks want to set up remote access to a shared repository
within a development group.
Some folks want to set up an anonymous git server.

Et cetera.  There are many different constituencies, who will
want access to a different subset of the commands.

> Exactly.  The tutorial can also use a minor split.  It starts
> out to give taste of internal workins of Porcelains, but ends up
> being a fuzzy mix of "user manual" and "hints to porcelain
> writers".  We probably should have a separate "end user
> tutorial" --- the Alice-Bob scenario by Horst might be a good
> place to start.

That much, I definitely agree with.  Mixing the two is confusing.
