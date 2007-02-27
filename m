From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Wed, 28 Feb 2007 00:13:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280012250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702271356300.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702272322590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271503140.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:13:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBVN-0000mC-B3
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbXB0XNG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXB0XNG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:13:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:53077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbXB0XNE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:13:04 -0500
Received: (qmail invoked by alias); 27 Feb 2007 23:13:01 -0000
X-Provags-ID: V01U2FsdGVkX1+XCKUAwCiX2D5p/OvFwWfiogWGbcLd45tRbeCuDd
	FUcA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271503140.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40840>

Hi,

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> On Tue, 27 Feb 2007, Johannes Schindelin wrote:
> 
> > On Tue, 27 Feb 2007, Linus Torvalds wrote:
> > 
> > > Side note: one of the reasons I like having more fine-grained date 
> > > flags is that I've occasionally wanted a "show in UTC time" or "show 
> > > everything in *my* local time" option.
> > 
> > I found the --relative-date option very useful to that end, if a bit 
> > long to type.
> 
> That really doesn't work for stuff that is more than a day old. The 
> difference between "3 weeks ago" and "3 weeks ago" is not usually very 
> obvious.
> 
> (Hint: often they are days apart, but the relative date-format will just 
> hide any differences due to excessive granularity).

Maybe we need --relative-but-verbose-date?

Ciao,
Dscho
