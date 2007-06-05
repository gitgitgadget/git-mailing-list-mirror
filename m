From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-filter-branch
Date: Tue, 5 Jun 2007 14:55:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706051454210.4046@racer.site>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <f3t2mm$f0$1@sea.gmane.org>
 <Pine.LNX.4.64.0706030147520.4046@racer.site> <20070605101845.GA16160@diku.dk>
 <7vzm3ebsnk.fsf@assigned-by-dhcp.cox.net> <20070605103421.GB16160@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Jun 05 15:57:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvZXM-0002NB-0r
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 15:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760529AbXFEN5U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 09:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761428AbXFEN5U
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 09:57:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:59174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760529AbXFEN5T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 09:57:19 -0400
Received: (qmail invoked by alias); 05 Jun 2007 13:57:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 05 Jun 2007 15:57:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hewcTgCAhA2RCyMqsQHx/w8xErMvNNg1RCDBnOn
	5crYs/u+M9ocaE
X-X-Sender: gene099@racer.site
In-Reply-To: <20070605103421.GB16160@diku.dk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49199>

Hi,

On Tue, 5 Jun 2007, Jonas Fonseca wrote:

> Junio C Hamano <gitster@pobox.com> wrote Tue, Jun 05, 2007:
>
> > The one in filter-branch that bit you does not dereference 'i'.
> > I am reasonably sure if you fix it to read:
> > 
> > 	i=$(( $i+1 ))
> > 
> > dash would grok it.
> 
> This works here. Even without the spaces.

Thanks for fixing up so quickly after me.

Ciao,
Dscho
