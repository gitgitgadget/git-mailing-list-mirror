From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [bug?] git-format-patch produces a 0-byte long patch for the
 first commit
Date: Tue, 24 Mar 2009 12:51:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0903241250140.4451@axis700.grange>
References: <Pine.LNX.4.64.0903231119110.4871@axis700.grange>
 <20090324075424.GC32400@coredump.intra.peff.net> <Pine.LNX.4.64.0903240901570.4451@axis700.grange>
 <alpine.DEB.1.00.0903241244380.7493@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 24 12:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm5BM-0001cM-Jy
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 12:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbZCXLvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 07:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755829AbZCXLvD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 07:51:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:60536 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755268AbZCXLvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 07:51:01 -0400
Received: (qmail invoked by alias); 24 Mar 2009 11:50:58 -0000
Received: from p57BD2955.dip0.t-ipconnect.de (EHLO axis700.grange) [87.189.41.85]
  by mail.gmx.net (mp069) with SMTP; 24 Mar 2009 12:50:58 +0100
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX19J5y4h6VRJe1hXKIDdERsC8n+h0Q7qPEKOQ4UfeX
	Kn7WT28096q3re
Received: from lyakh (helo=localhost)
	by axis700.grange with local-esmtp (Exim 4.63)
	(envelope-from <g.liakhovetski@gmx.de>)
	id 1Lm59x-0001gx-0k; Tue, 24 Mar 2009 12:51:09 +0100
In-Reply-To: <alpine.DEB.1.00.0903241244380.7493@intel-tinevez-2-302>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114454>

On Tue, 24 Mar 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 24 Mar 2009, Guennadi Liakhovetski wrote:
> 
> > On Tue, 24 Mar 2009, Jeff King wrote:
> > 
> > > On Mon, Mar 23, 2009 at 11:34:07AM +0100, Guennadi Liakhovetski wrote:
> > > 
> > > > mkdir x
> > > > cd x
> > > > git-init
> > > > echo hi > greating
> > > > git-commit -a
> > > > git-format-patch -1
> > > > 
> > > > produces a 0-byte long patch. git-format-patch HEAD^ produces an 
> > > > error, whereas with more than one commit it produces tha last patch. 
> > > > Yes, I know about "--root" and that it does allow to extract the 
> > > > very first commit.
> > > 
> > > What version of git are you using? I believe the 0-byte diff has been 
> > > fixed since git 1.6.1.1.
> > 
> > Mine is still 1.5.4, if it's already fixed in the meantime - all the 
> > better!
> 
> There is the off-chance that somewhere in those 3127 commits between 
> v1.5.4 and v1.6.1.1, not only this bug is fixed.  You might be surprised 
> ;-)
> 
> Seriously again, in a project that moves as fast as Git, you should always 
> test with a recent version, and v1.5.1 -- being over one year old -- does 
> not account for recent.

Sorry, didn't mention, I also tested with 1.6.0.6 - still was there.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
