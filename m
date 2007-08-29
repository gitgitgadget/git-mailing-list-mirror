From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5701: "wc -l" may add whitespace
Date: Wed, 29 Aug 2007 18:00:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708291759270.28586@racer.site>
References: <Pine.LNX.4.64.0708291752050.28586@racer.site> <vpqbqcqi8km.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 29 19:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQQvA-0004xT-E3
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 19:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbXH2RBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 13:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbXH2RBE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 13:01:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:58399 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753597AbXH2RBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 13:01:03 -0400
Received: (qmail invoked by alias); 29 Aug 2007 17:01:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 29 Aug 2007 19:01:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MBRljUEjMVWqkIfHSrEUglbnq4EnzTnKMBTQX2o
	bkYY5AqeUaC4dp
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqbqcqi8km.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56967>

Hi,

On Wed, 29 Aug 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > -	linked=$(find objects -type f ! -links 1 | wc -l) &&
> > -	test "$linked" = 0
> > +	test $(find objects -type f ! -links 1 | wc -l) = 0
> 
> You can also use "test x -eq y" to compare integers.
> 
> I don't know which one is the most portable.

Who cares when my version is obviously portable?

Ciao,
Dscho
