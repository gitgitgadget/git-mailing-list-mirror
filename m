From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 17:14:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003261712100.7596@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de> <20100326124650.GA12215@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 17:14:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvCBQ-0006IZ-Ix
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 17:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab0CZQOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 12:14:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:59550 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751716Ab0CZQOr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 12:14:47 -0400
Received: (qmail invoked by alias); 26 Mar 2010 16:14:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 26 Mar 2010 17:14:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//FCQZmKf/vDfBRc/6HpEZ+nshpz4y7FfQ5FUqlz
	co4WGD0VQ/eIZI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100326124650.GA12215@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143256>

Hi,

On Fri, 26 Mar 2010, Jeff King wrote:

> On Fri, Mar 26, 2010 at 11:48:41AM +0100, Johannes Schindelin wrote:
> 
> > This supports opening the results of a 'git grep' directly in a pager 
> > (where the pager can be 'vi', too).
> 
> This is not an argument against your patch, but you may be interested in 
> an alternate method:
> 
>   git grep -n $pattern >grep.out vim -q grep.out
> 
> The advantage is that the editor understands the output as a "quickfix" 
> list and lets you cycle through the hits (just like you might with 
> compiler errors). The disadvantage is that quickfix is a vim extension, 
> so "less" and stock "vi" can't do this (I imagine emacs has a similar 
> feature). It's also obviously a little more typing, but you can hide it 
> inside an alias quite easily.

In addition to the disadvantages you are listing, it does not jump 
directly to the word I am looking for. As you know, I am working 
with LaTeX files heavily, where convention dictates that a paragraph is 
represented by a single line in the source code.

So yes, I really need -O, and if a colleague would not have asked me why 
this useful feature is not in upstream Git, I would not even have 
submitted the patch pair.

Ciao,
Dscho
