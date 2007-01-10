From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: a few remaining issues...
Date: Wed, 10 Jan 2007 02:23:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701100220370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701051453520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070105193306.GB8753@spearce.org> <Pine.LNX.4.63.0701091218080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vtzz0j6hf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701100051350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070110001619.GF30023@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:23:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4SBX-0006Gb-94
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbXAJBXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbXAJBXO
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:23:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:50459 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932624AbXAJBXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:23:13 -0500
Received: (qmail invoked by alias); 10 Jan 2007 01:23:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 10 Jan 2007 02:23:12 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070110001619.GF30023@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36462>

Hi,

On Tue, 9 Jan 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > However, once the reflog traversal hits the oldest reflog entry, it 
> > reverts to commit parent traversal.
> 
> That doesn't make sense...
> 
> > On Tue, 9 Jan 2007, Junio C Hamano wrote:
> > 
> > > I couldn't make heads or tails out of the patch and did not understand 
> > > what it was trying to do.  It looked as if you were making the log 
> > > traversal machinery to walk _both_ reflog (probably from the latest to 
> > > older) and the usual ancestry.
> > 
> > Yes, first reflog, then usual ancestry.
> > 
> > Would you want that changed to _only_ reflog traversal?
> 
> Yes.  The old ancestry has nothing to do with my local reflog.  I
> want to know where my reflog ends, as there's no record of that
> branch's lifespan before that point.
> 
> Right now I have a reflog on `pu` which I've had since reflogs were
> first introduced last summer.  Yet it only goes back to Dec 23, 2006.
> Looking at the old ancestry of pu back into last Oct isn't really
> interesting when I'm studying what changes happened to locally.

Fair enough. It actually simplifies the patch. And if you want to dig on, 
you can just "git log pu@{whatever}", right?

So, is this wanted? (If not, I'd rather spend my time on my day job...)

Ciao,
Dscho
