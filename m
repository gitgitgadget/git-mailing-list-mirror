From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 22:01:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711142159400.4362@racer.site>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home>
 <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home>
 <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home>
 <7vmythr8xf.fsf@gitster.siamese.dyndns.org> <20071114071929.GA2942@steel.home>
 <Pine.LNX.4.64.0711141709410.4362@racer.site> <20071114194522.GA3973@steel.home>
 <20071114203409.GD3973@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 23:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsQJN-0005zx-6P
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 23:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbXKNWCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 17:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbXKNWCA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 17:02:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:48109 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753370AbXKNWB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 17:01:59 -0500
Received: (qmail invoked by alias); 14 Nov 2007 22:01:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 14 Nov 2007 23:01:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JaGJ0+P8JBBRH86DZTCeoxUdfG8f479XjfFoI8p
	6pbPzNP8A7glDx
X-X-Sender: gene099@racer.site
In-Reply-To: <20071114203409.GD3973@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65020>

Hi,

On Wed, 14 Nov 2007, Alex Riesen wrote:

> Alex Riesen, Wed, Nov 14, 2007 20:45:22 +0100:
>
> > Well, I do not know it _should_ fail. Personally, I would not even 
> > care: I see no way to cover with just one exit code multiple failures. 
> > Some references were updated and I don't even know which. So I'd 
> > better check whatever exit code.
> 
> "I'd better check whatever was updated and damn the exit code"

My point was: why not check both?  I mean, you know if it fails in your 
case.  Better to test for this behaviour, than to have it succeed here, 
but fail there.

It's really easy, too: if it does not succeed, it fails.  Just test for 
it.

Ciao,
Dscho "consistency is good"
