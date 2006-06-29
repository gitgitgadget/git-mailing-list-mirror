From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Thu, 29 Jun 2006 15:16:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606291440510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060627223249.GA8177@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 15:16:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvwNM-0007D9-6x
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 15:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWF2NQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 09:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWF2NQE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 09:16:04 -0400
Received: from mail.gmx.de ([213.165.64.21]:63211 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750705AbWF2NQD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 09:16:03 -0400
Received: (qmail invoked by alias); 29 Jun 2006 13:16:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 29 Jun 2006 15:16:02 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060627223249.GA8177@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22859>

Hi,

On Wed, 28 Jun 2006, Alex Riesen wrote:

> > > Path list optimization should be next (and I'll be glad if someone does 
> > > this before me).
> > 
> > See below.
> > 
> 
> Aah, thanks. Merged, tried, tested, left in patch.
> The reallocs can cause some undesirable heap fragmentation, don't you
> think?

I do not care too deeply about the heap fragmentation there: it is just 4 
bytes per file name. Besides, I chose an increment of 32 (probably I 
should use alloc_nr() instead).

> I tried to replace that code completely with a call to git-merge-base
> (it does not happen too often). So far it passed all tests.
> 
> > I have some commits in a private branch to split out get_merge_bases() 
> > from merge-base.c, so I'll try that next.
> 
> Thanks, that'd be nice.

Will reply with two patches.

> > BTW, before actually finishing this, we might want to do away with 
> > capitalizedFunctionNames and 4-space indent.
> 
> 4-space indent should be gone by now, the names pending (they were
> important in initial debugging after conversion).

Okay.

Ciao,
Dscho
