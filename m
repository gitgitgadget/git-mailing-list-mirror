From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git diff woes
Date: Mon, 12 Nov 2007 10:50:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121047590.4362@racer.site>
References: <4738208D.1080003@op5.se> <Pine.LNX.4.64.0711120958500.4362@racer.site>
 <47382C84.50408@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 12 11:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrWsj-0001QA-OM
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbXKLKuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757525AbXKLKuu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:50:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:49601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756258AbXKLKut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 05:50:49 -0500
Received: (qmail invoked by alias); 12 Nov 2007 10:50:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 12 Nov 2007 11:50:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rcP97h/3ruFeOF1q9XMzDiP0sMkmREdSyZvOYDE
	9hpxWHYU/1rwZ3
X-X-Sender: gene099@racer.site
In-Reply-To: <47382C84.50408@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64597>

Hi,

On Mon, 12 Nov 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> >  And sure you can trust the hunk header.  Like most of the things, the 
> > relate to the _original_ version, since the diff is meant to be 
> > applied as a forward patch.
> > 
> > So for all practical matters, the diff shows the correct thing: "in 
> > this hunk, which (still) belongs to that function, change this and 
> > this."
> > 
> > Of course, that is only the case if you accept that the diff should be 
> > applied _in total_, not piecewise.  IOW if you are a fan of GNU patch 
> > which happily clobbers your file until it fails with the last hunk, 
> > you will not be happy.
> > 
> 
> You're right. GNU patch will apply one hunk and then happily churn on 
> even if it fails. git-apply will apply all hunks or none, so all hunks 
> can assume that all previous hunks were successfully applied. So what 
> was your point again?

My point was that this diff is not to be read as if the previous hunks had 
been applied.  Just look at the context: it is also the original file.

It seems I am singularly unable to explain plain concepts as this: a diff 
assumes that the file is yet unchanged.

So I'll stop.

Ciao,
Dscho
