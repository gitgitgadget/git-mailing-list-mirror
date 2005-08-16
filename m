From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git 1.0 Synopis (Draft v4)
Date: Tue, 16 Aug 2005 11:47:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508161139410.23242@iabervon.org>
References: <20050729082941.GD32263@mythryan2.michonline.com>
 <200507312215.j6VMFeqn030963@laptop11.inf.utfsm.cl>
 <20050815045546.GA7001@mythryan2.michonline.com> <7vr7cv7p61.fsf@assigned-by-dhcp.cox.net>
 <20050815065833.GE7001@mythryan2.michonline.com> <7v7jen6545.fsf@assigned-by-dhcp.cox.net>
 <20050815080218.GG7001@mythryan2.michonline.com> <7vhddr397g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508151453100.21501@iabervon.org> <7vy872fiin.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508161730120.11105@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 17:45:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E53bU-0001it-NB
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 17:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVHPPnr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 11:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVHPPnr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 11:43:47 -0400
Received: from iabervon.org ([66.92.72.58]:5896 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030190AbVHPPnr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 11:43:47 -0400
Received: (qmail 26874 invoked by uid 1000); 16 Aug 2005 11:47:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2005 11:47:05 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508161730120.11105@wgmdd8.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 16 Aug 2005, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 16 Aug 2005, Junio C Hamano wrote:
>
> >   - Are all the files in Documentation/ reachable from git(7)
> >     or otherwise made into a standalone document using asciidoc
> >     by the Makefile?  I haven't looked into documentation
> >     generation myself (I use only the text files as they are);
> >     help to update the Makefile by somebody handy with asciidoc
> >     suite is greatly appreciated here.
> >
> >     Volunteers?
>
> The attached script reveals:
>
> git-unpack-objects.txt is not reachable from git.txt
> git-cvsimport-script.txt is not reachable from git.txt
> git-send-email-script.txt is not reachable from git.txt
> git-rename-script.txt is not reachable from git.txt
> tutorial.txt is not reachable from git.txt
> git-show-index.txt is not reachable from git.txt
> cvs-migration.txt is not reachable from git.txt
> diffcore.txt is not reachable from git.txt
> git-ls-remote-script.txt is not reachable from git.txt
> git-apply.txt is not reachable from git.txt
> git-diff-stages.txt is not reachable from git.txt
> pack-protocol.txt is not reachable from git.txt

The ones that don't start with git probably don't belong in the same set;
perhaps there should be a "technical" (or something similar but shorter)
subdirectory for developer documentation instead of user documentation?
(And tutorial and cvs-migration can move to howto)

	-Daniel
*This .sig left intentionally blank*
