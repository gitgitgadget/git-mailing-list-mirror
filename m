From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 22:22:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802202221130.17164@racer.site>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-243048860-1203546146=:17164"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:23:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxLU-0000lk-6s
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbYBTWWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbYBTWWp
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:22:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:50659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751141AbYBTWWo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:22:44 -0500
Received: (qmail invoked by alias); 20 Feb 2008 22:22:42 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp004) with SMTP; 20 Feb 2008 23:22:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VP/RzOctVCxXitbl+q4slp1O9vghPG4jNwU95KB
	pY03JLeAIXsRBV
X-X-Sender: gene099@racer.site
In-Reply-To: <200802202203.m1KM37aR012221@mi1.bluebottle.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74554>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-243048860-1203546146=:17164
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 21 Feb 2008, しらいしななこ wrote:

> Quoting Junio C Hamano <gitster@pobox.com>:
> 
> > Yeah, that "aka" is still disturbing.
> >
> > 	[url A]
> >         	aka = B
> >
> > would read to me: "A is also known as B" but that is clearly not
> > what it means here.  You would want this:
> >
> > 	[url A]
> >         	aka = B 
> > 		aka = C
> >
> > to mean "B is also known as A.  C is also known as A."  IOW, you
> > are using it backwards, because their name is more official and
> > you are using your own unofficial name to call it.
> >
> > Sorry, but I cannot think of a better way to resolve this, other
> > than by spelling the keyword backwards, but that still makes it
> > "aka".
> 
> Isn't what you mean to say "A stands for B and C"?

So you mean

[url A]
	standsFor = B
	standsFor = C

? ;-)

This might be seen as bike-shedding by some, but I think that it is 
actually worthwhile to kick back and forth some ideas, and pick the best 
one.

Ciao,
Dscho

---1463811741-243048860-1203546146=:17164--
