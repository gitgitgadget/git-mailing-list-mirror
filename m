From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Fri, 6 Jul 2007 04:16:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707060413190.4093@racer.site>
References: <20070705232210.GR3492@stusta.de> <Pine.LNX.4.64.0707060217460.9789@racer.site>
 <20070706014222.GK3492@stusta.de> <Pine.LNX.4.64.0707060243110.4093@racer.site>
 <20070706022629.GL3492@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 05:23:18 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ePd-0001S5-1O
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 05:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760812AbXGFDXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 23:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760656AbXGFDXP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 23:23:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:38195 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760544AbXGFDXO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 23:23:14 -0400
Received: (qmail invoked by alias); 06 Jul 2007 03:23:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 06 Jul 2007 05:23:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+39dkW/xG3SY2DiNBzA8J78pDEy4hcwCNpTLYX7q
	NArZtoMtitbxPt
X-X-Sender: gene099@racer.site
In-Reply-To: <20070706022629.GL3492@stusta.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51717>

Hi,

On Fri, 6 Jul 2007, Adrian Bunk wrote:

> On Fri, Jul 06, 2007 at 02:51:07AM +0100, Johannes Schindelin wrote:
> > 
> > On Fri, 6 Jul 2007, Adrian Bunk wrote:
> > 
> > > You must do something like "diff -U0" or manually editing patches 
> > > for creating such patches, and that's very unusual.
> > 
> > The point is that the _committer_ is not necessarily involved in that 
> > business.

BTW this still holds true, and you have not addressed that.  It really is 
a serious issue.  "git apply" is a committer's tool.  So it should help 
the committer.

> > And "git apply" is strict for a reason. It catches possibly unwanted 
> > things much earlier than patch. I _want_ to be warned that somebody is 
> > introducing some code at a certain position, which might, or might not 
> > be correct. apply has no way to tell, since there is no context to at 
> > least minimally verify.
> >...
> 
> That's wrong.
> 
> My use cases are replacing or deleting lines.

That is _your_ use case.

> In these cases there is context in the deleted lines that is already 
> being verified even with --unidiff-zero.

With --unidiff-zero, also _adding_ lines will be handled as if there were 
no problem.

Yes, in your case it fixes a problem.

Yet, in other cases it introduces a problem.

Okay?

Ciao,
Dscho
