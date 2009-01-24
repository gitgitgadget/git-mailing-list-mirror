From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Sat, 24 Jan 2009 01:28:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901240127110.3586@pacific.mpi-cbg.de>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com> <7vwscm4xx0.fsf@gitster.siamese.dyndns.org> <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com> <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
 <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com> <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de> <20090123223205.GA11491@coredump.intra.peff.net> <bd6139dc0901231434n6d6af5a6ma8bb12a634d5b3ba@mail.gmail.com>
 <20090123223740.GA11527@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:29:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQWPC-0006pH-KO
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 01:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255AbZAXA2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 19:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755614AbZAXA2S
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 19:28:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:60523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754861AbZAXA2R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 19:28:17 -0500
Received: (qmail invoked by alias); 24 Jan 2009 00:28:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 24 Jan 2009 01:28:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iL19ISjwiJzreJ644iZHsxDIdaJq9Go3SxXYykV
	UsPjrwhUoG3LqE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090123223740.GA11527@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106933>

Hi,

On Fri, 23 Jan 2009, Jeff King wrote:

> But I thought the issue at hand was that for some instances, we would 
> report that we successfully created an empty repository, when in fact 
> what happened was that we failed to clone a non-empty repository. And 
> that that was fixable, but it was a problem with our code interfaces 
> (which should be fixable) and not some fundamental limitation.

It appears that the HTTP code (at least after the first round of Mike's 
patches) has issues there, yes, but I think it would not be fair to stop 
Sverre's patch because of that: the HTTP code needs fixing anyway, and 
this fix is orthogonal to the empty clones.

Ciao,
Dscho
