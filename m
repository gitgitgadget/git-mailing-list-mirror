From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] builtin-prune: protect objects listed on the command
 line
Date: Thu, 27 Mar 2008 17:35:46 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803271735010.3802@racer.site>
References: <200803232150.29971.barra_cuda@katamail.com> <200803241502.21465.barra_cuda@katamail.com> <7vwsnrubmd.fsf@gitster.siamese.dyndns.org> <200803242218.44026.barra_cuda@katamail.com> <7vtzivmgpg.fsf@gitster.siamese.dyndns.org>
 <7vve389lgc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jev5x-0003O3-Sg
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 17:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758996AbYC0Qft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 12:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758412AbYC0Qft
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 12:35:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:48600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758776AbYC0Qft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 12:35:49 -0400
Received: (qmail invoked by alias); 27 Mar 2008 16:35:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp015) with SMTP; 27 Mar 2008 17:35:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18J5lkmXrgJNuceHgB9AQuM7ZWP9MTUHV7Q5L7HOt
	5sMEMAyhYOhoU5
X-X-Sender: gene099@racer.site
In-Reply-To: <7vve389lgc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78355>

Hi,

On Thu, 27 Mar 2008, Junio C Hamano wrote:

> Junio C Hamano <junio@pobox.com> writes:
> 
> > From: Junio C Hamano <gitster@pobox.com>
> > Date: Mon, 24 Mar 2008 23:20:51 -0700
> >
> > Finally, this resurrects the documented behaviour to protect other 
> > objects listed on the command line from getting pruned.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com> ---
> >  * This is done deliberately differently from what you did.  Because 
> >    we do not want to accept "we allow losing what's reachable from 
> >    master" with "git prune master..next", setup_revisions() is not the 
> >    right thing to use for this command.
> 
> Ping?

I did not see any problem with your implementation, but I thought Michele 
would look more deeply, as he obviously cares about the to-be-fixed 
behaviour.

Ciao,
Dscho
