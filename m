From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 23:06:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNDtU-00015T-22
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbZANWF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755164AbZANWF6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:05:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:56908 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753962AbZANWF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:05:58 -0500
Received: (qmail invoked by alias); 14 Jan 2009 22:05:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 14 Jan 2009 23:05:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+P6ht2czePXgQwoY10WnVG5CsgeJUUbSO3T4yuUM
	c8ipMeEnbyGtoj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901142059.09005.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105709>

Hi,

On Wed, 14 Jan 2009, Thomas Rast wrote:

> Teemu Likonen wrote:
> >     -aaa (aaa)
> >     +aaa (aaa) aaa
> 
> Bug aside, examples like this one make me wonder if we should force a
> "last resort" match for `[^[:space:]]`.  For example,
> 
>       -aaa [aaa]
>       +aaa (aaa) aaa
> 
> would still give you
> 
>       aaa (aaa)<GREEN> aaa<RESET>
> 
> which may be unexpected.

But why should it be unexpected?  If people say that every length of "a" 
makes a word, and consequently everything else is clutter, then that's 
that, no?

So people might be surprised, but then they should have said something 
like

	[-.+#@"'$%^&*([{<>~|]*[A-Za-z][A-Za-z0-9]*[-.+#@"'$%&*)\]}>|]*

instead.

Although I have to say that for some applications, it is a pity that 
even POSIX extended regular expressions knows neither lookahead nor 
lookbehind.

Which reminds me... should we activate REG_EXTENDED by default?

Ciao,
Dscho
