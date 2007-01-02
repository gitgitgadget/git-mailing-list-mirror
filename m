From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): fix a segmentation fault when refining
 conflicts
Date: Tue, 2 Jan 2007 22:17:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701022216420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061227041644.GA22449@spearce.org> <en6fj1$ji5$1@sea.gmane.org>
 <Pine.LNX.4.63.0612310208460.25709@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701021418.48624.jnareb@gmail.com> <Pine.LNX.4.63.0701022144290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk605t9qz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 02 22:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1r14-0007tM-Qc
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbXABVRr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755419AbXABVRr
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:17:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:59925 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755417AbXABVRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:17:46 -0500
Received: (qmail invoked by alias); 02 Jan 2007 21:17:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 02 Jan 2007 22:17:45 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk605t9qz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35819>

Hi,

On Tue, 2 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > That is certainly a possibility! But how would you specify it? If you 
> > do it as a command line option, you'd have to add it to git-merge, 
> > git-pull, git-merge-recursive and git-merge-file. Ugly.
> 
> Another thing to worry about is that this would make things
> "works most of the time but when it fails it fails silently"
> which would lead to very hard to detect problem in the project
> managed by git.  I'd be very hesitant about this for this reason
> alone.

Right. That was what I was alluding to with my comment "what if you prefer 
the deletion over the addition?"

It _seems_ clever at first sight, but it isn't.

Ciao,
Dscho
