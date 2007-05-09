From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-commit: Reformat log messages provided on commandline
Date: Wed, 9 May 2007 17:01:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091658210.4167@racer.site>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705061851411.4015@racer.site>
 <vpqk5vlamav.fsf@bauges.imag.fr> <7vvef5c0fw.fsf@assigned-by-dhcp.cox.net>
 <20070509125225.GP4489@pasky.or.cz> <Pine.LNX.4.64.0705091513360.4167@racer.site>
 <20070509142426.GV4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 09 17:01:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlnfT-0004bo-Iy
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbXEIPBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756076AbXEIPBS
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:01:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:52537 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755722AbXEIPBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:01:17 -0400
Received: (qmail invoked by alias); 09 May 2007 15:01:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 09 May 2007 17:01:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LPNkZlm+LrItAhO2h+vCXA0dxv2pZ4rhbANn/gN
	Ddi1tPv+aMbP4k
X-X-Sender: gene099@racer.site
In-Reply-To: <20070509142426.GV4489@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46722>

Hi,

On Wed, 9 May 2007, Petr Baudis wrote:

> On Wed, May 09, 2007 at 03:57:28PM CEST, Johannes Schindelin wrote:
> > Another reason is that you can see how the end result will look like in an 
> > editor. For example, you'll have a hard time making sure in the 
> > command line that the lines are no longer than 76 characters.
> 
>   oh, indeed - good point. cg-commit uses fmt to format the message, I
> think git-commit should do the same;

FWIW, I have a builtin git-fmt in my local repo, which uses the (slightly 
enhanced) functions in utf8.c... Maybe after 1.5.2 I dare to submit 
this...

Ciao,
Dscho
