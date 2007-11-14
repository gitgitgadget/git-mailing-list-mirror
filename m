From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 17:10:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711141709410.4362@racer.site>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home>
 <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home>
 <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home>
 <7vmythr8xf.fsf@gitster.siamese.dyndns.org> <20071114071929.GA2942@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsLlW-0003mS-KX
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 18:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988AbXKNRKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 12:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755881AbXKNRKq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 12:10:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:34446 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755969AbXKNRKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 12:10:45 -0500
Received: (qmail invoked by alias); 14 Nov 2007 17:10:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 14 Nov 2007 18:10:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/qRZVTkV/fS2AIzit9BY7bSEscvwyfdSdFCDg/y
	+bo/T9FrQhyrAp
X-X-Sender: gene099@racer.site
In-Reply-To: <20071114071929.GA2942@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64990>

Hi,

On Wed, 14 Nov 2007, Alex Riesen wrote:

> Junio C Hamano, Wed, Nov 14, 2007 01:02:20 +0100:
> > Alex Riesen <raa.lkml@gmail.com> writes:
> > 
> > > Ignore exit code of git push in t5404, as it is not relevant for the 
> > > test
> > 
> > This proposed log message solicits a "Huh? -- Since when ignoring exit 
> > code is an improvement?" reaction.  If this push is expected to error 
> > out, then wouldn't you want to make sure it errors out as expected?  
> > If the problem is that the exit status is unreliable, maybe we need to 
> > make it reliable instead?
> 
> Well, it is kind of undefined. git push just updated some remote 
> references and failed on the others. It has had some failures, so it 
> returns non-0. And as I said, it really is not about the operation, but 
> about if the tracking and remote branches are set as we want them.

If you know it should fail, why not make the test dependent on that 
failure?  I mean, should git-push have a bug and not fail, it would be 
nice to catch this early...

Ciao,
Dscho
