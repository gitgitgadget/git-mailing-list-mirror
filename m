From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision: allow selection of commits that do not match
 a pattern
Date: Sat, 7 Jul 2007 18:33:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071831300.4093@racer.site>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071724410.4093@racer.site> <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jul 07 19:40:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7EGm-0008Kh-HN
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 19:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbXGGRkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 13:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbXGGRkS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 13:40:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:58530 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751513AbXGGRkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 13:40:17 -0400
Received: (qmail invoked by alias); 07 Jul 2007 17:40:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 07 Jul 2007 19:40:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0VlUtKnv0Nly3gd9GfSNr3UcyWpbhHN7xpH2Ggk
	MQ5/qVMGFLD1Eh
X-X-Sender: gene099@racer.site
In-Reply-To: <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51830>

Hi,

On Sat, 7 Jul 2007, Sven Verdoolaege wrote:

> On Sat, Jul 07, 2007 at 05:27:23PM +0100, Johannes Schindelin wrote:
> > I suspect that with this patch,
> > 
> > 	git rev-list --not --grep bugfix HEAD
> > 
> > does not work as expected. Why?
> 
> Well... I guess that depends on what you expect...

Well, at least you hopefully that it is confusing. To use --not for grep 
patterns _as well_ as for revision arguments.

> > Why not make "git rev-list --grep '!bugfix' HEAD" work?
> > 
> > Yes, you would have to have a special exception that the prefix "!!" 
> > actually matches an exclamation mark, but I'd be willing to live with 
> > that.
> 
> Hmm... what if you want to (not) match anything starting with
> one or more '!' ?

Yeah, that would not work.

> How about I add a '--invert-match' option that would
> apply to all following match options?
> Or we could escape the '!' with backslash.

If we want to match it at the beginning. Yes, that sounds more reasonable 
to me.

Ciao,
Dscho
