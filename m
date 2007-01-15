From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 12:08:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701151201100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org>
 <200701151042.12753.andyparkins@gmail.com> <20070115105616.GE12257@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVp-0000R7-JJ
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:49 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9l-0003eK-FS
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXAOLIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 06:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbXAOLIT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 06:08:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:33819 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932226AbXAOLIS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 06:08:18 -0500
Received: (qmail invoked by alias); 15 Jan 2007 11:08:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 15 Jan 2007 12:08:16 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070115105616.GE12257@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36839>

Hi,

On Mon, 15 Jan 2007, Shawn O. Pearce wrote:

> Andy Parkins <andyparkins@gmail.com> wrote:
> 
> > I don't think the argument that Matthias offered ("You just explained 
> > why no one should pull from people he does not trust.") is a good one.  
> > One might not want trust to be transitive.  Just because I trust you, 
> > doesn't not mean that I trust those who you trust.  The path of 
> > getting commits in via a trusted person, perhaps even via multiple 
> > levels of transitive trust might not be something that is wanted in 
> > every project.  Having signed commits would at least give the option.
> 
> Yes, that's very valid.  But if you trust me and I've gone and built 100 
> commits on top of something I got from someone else I trust but that you 
> don't trust, you are going to reject all of my changes and ask that I 
> rewrite them?  That's quite paranoid.

It is not only paranoid. It is bad practice.

We might be tempted to forget in these horrible times that distrust itself 
is a perpetuum mobile. Distrust results in distrust. And nobody being 
distrusted likes that fact. It makes for a bad working environment, for 
less code quality, and quite often, people get ideas from being 
distrusted: "If they think I could include a backdoor, well, that might 
actually be a good idea!".

Please have a look at the Linux kernel development, or for that matter, 
git development itself. Here, people care, people trust, people respect 
each other (sometimes YELLING, to keep discussions exciting). And the 
result is: nice code.

Ciao,
Dscho
