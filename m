From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 18:14:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606291814200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> 
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20060627223249.GA8177@steel.home>  <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0606290714v66a32976j531e2077ce6c1d77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 18:14:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvzAL-0002Fq-4k
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 18:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWF2QOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 12:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWF2QOu
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 12:14:50 -0400
Received: from mail.gmx.net ([213.165.64.21]:49048 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750910AbWF2QOu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 12:14:50 -0400
Received: (qmail invoked by alias); 29 Jun 2006 16:14:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 29 Jun 2006 18:14:48 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606290714v66a32976j531e2077ce6c1d77@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22871>

Hi,

On Thu, 29 Jun 2006, Alex Riesen wrote:

> On 6/29/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > most of this patch is just a "sub-file rename", i.e. moving code
> > literally (sue me, SCO!) from merge-base.c to commit.c.
> > 
> 
> BTW, you probably want to post merge-recursive.c changes separately.

My point being: it makes no sense to split off get_merge_bases() if nobody 
uses it except for git-merge-base.

Ciao,
Dscho
