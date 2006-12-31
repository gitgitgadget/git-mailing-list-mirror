From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): fix a segmentation fault when refining
 conflicts
Date: Sun, 31 Dec 2006 02:09:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612310208460.25709@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061227041644.GA22449@spearce.org>
 <Pine.LNX.4.63.0612271214120.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyb11ouy.fsf@wine.dyndns.org> <Pine.LNX.4.63.0612281710350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061229041626.GA12072@spearce.org> <Pine.LNX.4.63.0612301944350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <en6fj1$ji5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 02:10:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0pD7-0004id-RQ
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWLaBJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWLaBJ7
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:09:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:35826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932512AbWLaBJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 20:09:58 -0500
Received: (qmail invoked by alias); 31 Dec 2006 01:09:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 31 Dec 2006 02:09:56 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <en6fj1$ji5$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35638>

Hi,

On Sat, 30 Dec 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > Of course, you can hit mismerges like the illustrated one _without_ 
> > being marked as conflict (e.g. if the chunk of identical code is _not_ 
> > added, but only the increments), but we should at least avoid them 
> > where possible.
> 
> Perhaps you could make it even more conservating merge conflicts option 
> (to tighten merge conflicts even more) to xdl_merge, but not used by 
> default because as it removes accidental conflicts it increases 
> mismerges (falsely not conflicted).

There is no way to do this sanely. If you want to catch these mismerges, 
you have to mark _all_ modifications as conflicting.

Ciao,
Dscho
