From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rename warn() to warning() to fix symbol conflicts on
 BSD and Mac OS
Date: Sat, 31 Mar 2007 12:46:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703311245510.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11752960251394-git-send-email-tytso@mit.edu>
 <7vejn5ygkc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 12:46:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXb64-00035S-8p
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 12:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbXCaKqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 06:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbXCaKqI
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 06:46:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:49665 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752871AbXCaKqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 06:46:07 -0400
Received: (qmail invoked by alias); 31 Mar 2007 10:46:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 31 Mar 2007 12:46:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NbmEmJU9N5vP++c9wuzRsPGiu3vU1T2FOIo2eCe
	gZQJgXP330/+Ky
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vejn5ygkc.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43543>

Hi,

On Sat, 31 Mar 2007, Junio C Hamano wrote:

> Theodore Ts'o <tytso@mit.edu> writes:
> 
> > This fixes a problem reported by Randal Schwartz:
> >
> >>I finally tracked down all the (albeit inconsequential) errors I was getting
> >>on both OpenBSD and OSX.  It's the warn() function in usage.c.  There's
> >>warn(3) in BSD-style distros.  It'd take a "great rename" to change it, but if
> >>someone with better C skills than I have could do that, my linker and I would
> >>appreciate it.
> >
> > It was annoying to me, too, when I was doing some mergetool testing on
> > Mac OS X, so here's a fix.
> 
> I'd take this for now, but I wonder where we should stop.  If
> somebody exports error() or die(), would we end up renaming them
> to git_error() and git_die()?

Libification, here we come ;-)

Ciao,
Dscho
