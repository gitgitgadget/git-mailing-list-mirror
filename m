From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Thu, 15 Jan 2009 13:41:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch> <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
 <8763khtbfc.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jan 15 13:42:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRYI-0007jr-9A
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 13:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822AbZAOMkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 07:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756033AbZAOMkr
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 07:40:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:52940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755049AbZAOMkq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 07:40:46 -0500
Received: (qmail invoked by alias); 15 Jan 2009 12:40:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 15 Jan 2009 13:40:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+a1hYmGw6aEilzcEVi1r0AkypxOM/tiRcprLeilk
	G9Z4sP5aP/Cy1c
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <8763khtbfc.fsf@iki.fi>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105784>

Hi,

On Thu, 15 Jan 2009, Teemu Likonen wrote:

> Johannes Schindelin (2009-01-14 23:06 +0100) wrote:
> 
> > On Wed, 14 Jan 2009, Thomas Rast wrote:
> >>       -aaa [aaa]
> >>       +aaa (aaa) aaa
> >> 
> >> would still give you
> >> 
> >>       aaa (aaa)<GREEN> aaa<RESET>
> >> 
> >> which may be unexpected.
> >
> > But why should it be unexpected?  If people say that every length of "a" 
> > makes a word, and consequently everything else is clutter, then that's 
> > that, no?
> 
> It works logically but I'd very much like to see a some kind of advice
> in the man page. I already faced this (unexpected) situation and wasn't
> able to fix the regexp myself.

Exactly because it works logically, I do not want to change it.  This is 
what the user said, and for a change, it could be what the user meant.

You'll have to come up with a method to describe exactly what you want.  
So what is it exactly?  What would you want in such a situation?  You 
asked for words that consist solely of the letter 'a'.  Now, the 
surrounding stuff differs.  What should Git do?

BTW this gets even worse when you compare the following:

bbb aaa
ccc aaa

--color-words=a+ will show

ccc aaa

(!!!)

Ciao,
Dscho
