From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 13:20:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091319420.4362@racer.site>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org>
 <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org> <7v640cxitc.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711090225110.4362@racer.site> <6FCE17E3-9FAA-4676-B12A-369B31743DA6@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Fri Nov 09 14:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqTni-0008J2-OJ
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbXKINVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 08:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758601AbXKINVU
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:21:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:53563 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751578AbXKINVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 08:21:19 -0500
Received: (qmail invoked by alias); 09 Nov 2007 13:21:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 09 Nov 2007 14:21:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CYtRb0LrCPvQRKDm+qwCnIydWUdTbFHmeuVuQqy
	9Recpl11Aky+YH
X-X-Sender: gene099@racer.site
In-Reply-To: <6FCE17E3-9FAA-4676-B12A-369B31743DA6@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64176>

Hi,

On Fri, 9 Nov 2007, Benoit Sigoure wrote:

> On Nov 9, 2007, at 3:28 AM, Johannes Schindelin wrote:
> 
> > Would that not be easier to read as
> > 
> > 		test t = "$INTERACTIVE" &&
> > 			git_editor "$TODO" || die "Could not execute editor"
> 
> Hmm this will `die' if you're not running interactively.

D'oh.  Of course I meant

		test -z "$INTERACTIVE" || git_editor "$TODO" || die ...

Ciao,
Dscho
