From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git config fail on variables with no section, as
 documented
Date: Sun, 26 Jul 2009 21:48:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907262146530.8306@pacific.mpi-cbg.de>
References: <1248474081-sup-2762@utwig> <1248625102-472-1-git-send-email-alex@chmrr.net> <alpine.DEB.1.00.0907261849110.8306@pacific.mpi-cbg.de> <1248636518-sup-7499@utwig>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sun Jul 26 21:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV9hn-0006xI-ST
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 21:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbZGZTsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 15:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbZGZTsQ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 15:48:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:60987 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752917AbZGZTsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 15:48:15 -0400
Received: (qmail invoked by alias); 26 Jul 2009 19:48:14 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 26 Jul 2009 21:48:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Xa1tUdT1Xf8cC+OfKjB/4gEEpw8J6ER2RR2AAsC
	IVZsnL5egKihLT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1248636518-sup-7499@utwig>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124136>

Hi,

On Sun, 26 Jul 2009, Alex Vandiver wrote:

> At Sun Jul 26 12:49:28 -0400 2009, Johannes Schindelin wrote:
> > Is there any downside in allowing this?
> 
> Not explicitly.  However, there are no legal current uses of it, and
> allowing it might encourage extensions to use the top-level config
> namespace.

So?

> It also has the odd property that it _must_ be at the top of a 
> configuration file -- unlike all other configuration options, you can 
> never return to the section to add more variable definitions later.

Yes, that is a special property that you might actually want in some 
contexts.

That, together with the fact that "git config -f <file>" was meant 
_explicitely_ to allow 3rd party porcelains having their own config files 
without having to implement their own "git config" lets me suspect that 
we'd rather want the current behavior.

Ciao,
Dscho
