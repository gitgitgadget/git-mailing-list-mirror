From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Mon, 26 Oct 2009 21:12:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910262111340.4985@pacific.mpi-cbg.de>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>  <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>  <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>  <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>  <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
  <7v7huspjg0.fsf@alter.siamese.dyndns.org>  <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>  <20091022062145.6117@nanako3.lavabit.com>  <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de>  <7vzl7h8fjp.fsf@alter.siamese.dyndns.org>
 <117f2cc80910240759oa9f57e7h67f06816d37e328c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: David Roundy <roundyd@physics.oregonstate.edu>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:22:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2W5M-0002qO-45
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 21:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbZJZUWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 16:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbZJZUWX
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 16:22:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:39611 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755307AbZJZUWW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 16:22:22 -0400
Received: (qmail invoked by alias); 26 Oct 2009 20:09:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp072) with SMTP; 26 Oct 2009 21:09:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HezRIPDSHAwzI+KTyRDrDZAmxIBNs7J5lzogUKK
	0GOIdzVaT6MHLU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <117f2cc80910240759oa9f57e7h67f06816d37e328c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131264>

Hi,

On Sat, 24 Oct 2009, David Roundy wrote:

> On Sat, Oct 24, 2009 at 2:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> My take on it:
> >>
> >> 1) --no-porcelain
> >>
> >> 2) we all are bike-shedding, not being constructive at all
> >
> > You are right about (2), regarding the option name. I've queued one that
> > uses --no-guess.
> 
> Perhaps a universal --plumbing flag would be handy?

No.  Older Git versions do not know about it, so you cannot Just Modify 
Your Scripts.  So the benefit of --plumbing is dubitable.

FWIW the same goes for --no-porcelain.

Ciao,
Dscho
