From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Fri, 20 Mar 2009 10:17:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201015270.10279@pacific.mpi-cbg.de>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>  <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>  <20090319214001.GA6253@blimp.localdomain>  <alpine.DEB.1.00.0903200025170.10279@pacific.mpi-cbg.de>
 <81b0412b0903200130s594ce3beyae21eb0b5cc8fe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 10:17:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkaqo-0001OJ-OX
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 10:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020AbZCTJPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 05:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757278AbZCTJPi
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 05:15:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:60676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756274AbZCTJPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 05:15:36 -0400
Received: (qmail invoked by alias); 20 Mar 2009 09:15:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 20 Mar 2009 10:15:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UAoJA2AkUBoIt7NrHLsS1GWcA8HKDn81g9mL8JH
	aAmxUvGDX6Tpyc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0903200130s594ce3beyae21eb0b5cc8fe0@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113920>

Hi,

On Fri, 20 Mar 2009, Alex Riesen wrote:

> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Now, we _do_ have msysGit, you _do_ have shown the capability to fix 
> > issues when they arise, so I do _not_ see any obstacle why you should 
> > not go msysGit, rather than staying with the pain of trying to stay 
> > POSIX-compatible, but not quite all the time.
> 
> I understand. It is not pure POSIX compatibility I seek. I just can't 
> use MinGW port, because I absolutely must use the cygwin environment 
> (for "hysterical" reasons) and they don't play well together (tried, 
> yes. Conflicting libraries, but you already know that).

Maybe we can work on those conflicting libraries?  After all, we do have a 
"rebase.exe" tool now (for all those as puzzled by the naming as I was: 
the rebase.exe tool can shift the memory range used by a .dll so that it 
does not overlap with that one of another .dll).

Ciao,
Dscho
