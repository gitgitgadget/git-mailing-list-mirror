From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 12:02:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711061159240.4362@racer.site>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> 
 <fgo5dt$avh$1@ger.gmane.org>  <Pine.LNX.4.64.0711060007010.4362@racer.site>
 <3abd05a90711052022j590f1faesb85f4646afd9acec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 13:03:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpN9b-0000AO-Gd
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 13:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbXKFMDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 07:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755711AbXKFMDV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 07:03:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:55526 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755458AbXKFMDU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 07:03:20 -0500
Received: (qmail invoked by alias); 06 Nov 2007 12:03:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 06 Nov 2007 13:03:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Ev71QHczEd1Rs79zAV1S0zAcG8auMd/Yo8t5e1Y
	2382fk5EqRSQ6j
X-X-Sender: gene099@racer.site
In-Reply-To: <3abd05a90711052022j590f1faesb85f4646afd9acec@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63664>

Hi,

On Mon, 5 Nov 2007, Aghiles wrote:

> > The consense was that you are much better off committing first, then 
> > pulling.  And if the work you are doing really is not committable, but 
> > you _have_ to pull _now_, you use stash.  Although you are quite 
> > likely to revert the pull when it succeeds, and _then_ unstash.
> 
> Sorry but I don't really understand why one should "revert the pull" ? 
> Could elaborate for a newbie ? :)

Yes, no problem.

A pull is just a fetch and a merge.  And a merge is a commit with more 
than one parent.  So you can use the command "git reset --hard HEAD^" to 
undo a merge, just as you can undo any other commit.

NOTE: if you pushed that commit (merge or not), do _not_ use reset.  This 
effectively rewrites history, and _will_ upset people pulling from you.  
If you really have to undo a commit you already published, use "git revert 
<commit>".

Hth,
Dscho
