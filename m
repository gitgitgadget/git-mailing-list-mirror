From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] include $PATH in generating list of commands for
 "help -a"
Date: Mon, 29 Oct 2007 11:30:29 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710291129250.4362@racer.site>
References: <1193474215-6728-6-git-send-email-srp@srparish.net>
 <1193582654-12100-1-git-send-email-srp@srparish.net>
 <Pine.LNX.4.64.0710281642220.4362@racer.site> <20071029024431.GA12459@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 12:31:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImSqX-0004fE-0s
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 12:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbXJ2LbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 07:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbXJ2LbK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 07:31:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:58066 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752378AbXJ2LbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 07:31:09 -0400
Received: (qmail invoked by alias); 29 Oct 2007 11:31:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 29 Oct 2007 12:31:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+T/O5UIaqToBro4L16I7VIY72W2vC2Z7/uE01jQP
	6UUm2S+46zjk30
X-X-Sender: gene099@racer.site
In-Reply-To: <20071029024431.GA12459@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62613>

Hi,

On Sun, 28 Oct 2007, Scott Parish wrote:

> On Sun, Oct 28, 2007 at 04:51:00PM +0000, Johannes Schindelin wrote:
> 
> > > +static void subtract_cmds(struct cmdnames *a, struct cmdnames *b) {
> > 
> > Maybe "exclude_cmds()", and choose more suggestive names for the 
> > parameters?
> 
> I was thinking set operations when i named this (hense "a" and "b"),
> but i'll try this out.

Yes, I guessed that.  But in that case, "subtract" is actively wrong, 
since you cannot guarantee (and indeed do not want to assume) that one is 
the subset of the other.

Ciao,
Dscho
