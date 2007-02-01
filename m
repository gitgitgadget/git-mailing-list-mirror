From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tone down the detached head warning
Date: Wed, 31 Jan 2007 22:29:25 -0500
Message-ID: <20070201032925.GA2505@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <Pine.LNX.4.64.0701311907500.3021@xanadu.home> <20070201030030.GA1979@coredump.intra.peff.net> <7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 04:29:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCSdh-0005ux-2P
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 04:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbXBAD32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 22:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbXBAD31
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 22:29:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1268 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161293AbXBAD31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 22:29:27 -0500
Received: (qmail 1870 invoked from network); 31 Jan 2007 22:29:24 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 31 Jan 2007 22:29:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jan 2007 22:29:25 -0500
Content-Disposition: inline
In-Reply-To: <7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38324>

On Wed, Jan 31, 2007 at 07:23:21PM -0800, Junio C Hamano wrote:

>         M	foo.c
>         Switched to branch "master"
> 	: gitster project/master; git checkout master^
> 	M	bar.c
>         M	foo.c
> 	Detached your HEAD -- you are not on any branch.
>         If you want to create a new branch from this checkout, you may do so
>         (now or later) by using -b with the checkout command again. Example:
>           git checkout -b <new_branch_name>
> 	: gitster project; 
>
> would feel very natural and much less scary.


Much improved, IMHO. As an added bonus, I think it creates some feedback
that lets a user know when they have mistakenly used 'git checkout' to
switch heads when they meant to restore a file.

I still wish there was some other language for detaching to a commit
specified by a remote tracking branch; it just seems wrong to say "you
are not on any branch" right after the user requests to checkout a
branch (admittedly not one of their local branches, but for a user
merely poking through the repository, the difference is probably not
important).

-Peff
