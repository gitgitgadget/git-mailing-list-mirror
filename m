From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow setting default diff options via
 diff.defaultOptions
Date: Thu, 9 Apr 2009 12:43:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
 <20090409084903.GA18947@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 12:43:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrrjP-0007We-UF
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 12:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934256AbZDIKk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 06:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934290AbZDIKkz
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 06:40:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:55577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934256AbZDIKkx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 06:40:53 -0400
Received: (qmail invoked by alias); 09 Apr 2009 10:40:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 09 Apr 2009 12:40:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DoapnbiqDLaYo0ZAMFsC8ihQeuowoADkJ+u0ACk
	+Vf51qTirbBr2U
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090409084903.GA18947@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116161>

Hi,

On Thu, 9 Apr 2009, Jeff King wrote:

> On Thu, Apr 09, 2009 at 10:45:40AM +0200, Johannes Schindelin wrote:
> 
> > Now, it is easy to put a patch on top of my patch to support something 
> > like --no-defaults.
> 
> No, it's not. We went over this in great detail earlier in the thread. 
> If you want:
> 
>   git diff --no-defaults
> 
> then you basically have to parse twice to avoid the chicken-and-egg
> problem.

So what?  We parse the config a gazillion times, and there we have to 
access the _disk_.

Ciao,
Dscho
