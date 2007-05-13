From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git config gets confused
Date: Sun, 13 May 2007 12:46:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705131243020.6410@racer.site>
References: <20070512235230.GE7184@planck.djpig.de> <7vtzuhtjj6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 12:46:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnBar-00086s-Cj
	for gcvg-git@gmane.org; Sun, 13 May 2007 12:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbXEMKqU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 06:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754924AbXEMKqU
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 06:46:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:53254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754173AbXEMKqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 06:46:19 -0400
Received: (qmail invoked by alias); 13 May 2007 10:46:17 -0000
Received: from R4457.r.pppool.de (EHLO noname) [89.54.68.87]
  by mail.gmx.net (mp058) with SMTP; 13 May 2007 12:46:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nF19tbDXnY0sCmpcAbWkMPB92xeTF2U0afXo7Im
	gYVnQLpvEfAsop
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtzuhtjj6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47138>

Hi,

On Sat, 12 May 2007, Junio C Hamano wrote:

> Oh, boy.
> 
> Why am I not surprised by another bug in config writer?
> 
> Dscho, does this look good?

Yes, it does. This part of the config writer dates slightly prior to our 
allowing hierarchical section names, which explains this bug, methinks.

Ciao,
Dscho
