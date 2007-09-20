From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] the return of the strbuf
Date: Thu, 20 Sep 2007 22:52:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709202252070.28395@racer.site>
References: <20070917125211.GA18176@artemis.corp> <20070917133522.GD18176@artemis.corp>
 <20070918035721.GL3099@spearce.org> <Pine.LNX.4.64.0709201248400.28395@racer.site>
 <7v1wctkoao.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYTxk-00072k-4V
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 23:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbXITVx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 17:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbXITVx2
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 17:53:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:57872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753290AbXITVx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 17:53:26 -0400
Received: (qmail invoked by alias); 20 Sep 2007 21:53:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 20 Sep 2007 23:53:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2mHhQeFH23PUHj0lTd+BkRcBGJTovqX2fwHpMf1
	AD/GbK2I1xCiWK
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wctkoao.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58811>

Hi,

On Thu, 20 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 17 Sep 2007, Shawn O. Pearce wrote:
> >
> >>  $ git log --pretty=format:%an --since=6.months.ago -- fast-import.c \
> >>       | sort | uniq -c | sort -nr
> >>   14 Shawn O. Pearce
> >>    3 Pierre Habouzit
> >>    3 Junio C Hamano
> >>    2 Simon Hausmann
> >>    2 Alex Riesen
> >>    1 Theodore Ts'o
> >>    1 Sven Verdoolaege
> >>    1 Sami Farin
> >>    1 Nicolas Pitre
> >>    1 Luiz Fernando N. Capitulino
> >>    1 Dana L. How
> >
> > FWIW I'd do
> >
> > git shortlog -n --since=6.months.ago HEAD -- fast-import.c|grep "^[A-Z]"
> >
> > instead...
> 
> I am sure you certainly meant a single command without grep, like:
> 
> 	$ git shortlog -n -s --since=6.months.ago HEAD -- fast-import.c

Hehe.  I said "I'd do" ;-)

Thanks,
Dscho
