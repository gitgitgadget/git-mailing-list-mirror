From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 06:23:13 -0400
Message-ID: <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org>
	<45340713.6000707@utoronto.ca>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 12:23:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZm6R-0006sr-Q8
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 12:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWJQKXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 06:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWJQKXQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 06:23:16 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:1339 "EHLO
	BAYC1-PASMTP08.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1161169AbWJQKXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 06:23:15 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP08.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 03:31:50 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZlAH-0005K3-QH; Tue, 17 Oct 2006 05:23:13 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061017062313.cd41e031.seanlkml@sympatico.ca>
In-Reply-To: <45345AEF.6070107@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 10:31:51.0093 (UTC) FILETIME=[7510B650:01C6F1D7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 00:24:15 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

> The key thing about a checkout is that it's stored in a different
> location from its repository.  This provides a few benefits:
> 
> - - you can publish a repository without publishing its working tree,
>   possibly using standard mirroring tools like rsync.

Yeah, even in git you typically don't publish your working tree when
making it available for cloning.  In fact the native git network
protocol doesn't even have a way to transfer working trees.

> - - you can have working trees on local systems while having the
>   repository on a remote system.  This makes it easy to work on one
>   logical branch from multiple locations, without getting out of sync.

That is a very nice feature.  Git would be improved if it could
support that mode of operation as well.

> - - you can use a checkout to maintain a local mirror of a read-only
>   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).

I'm not sure what you mean here.  A bzr checkout doesn't have any history
does it?  So it's not a mirror of a branch, but just a checkout of the
branch head?

If so, Git can export a tarball of a branch (actually a snapshot as at
any given commit) which can be mirrored out.

Sean
