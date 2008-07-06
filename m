From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: About -X<option>
Date: Sun, 6 Jul 2008 03:44:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807060342550.3557@eeepc-johanness>
References: <alpine.DEB.1.00.0807051454060.3334@eeepc-johanness> <20080705133245.GH4729@genesis.frugalware.org> <AB745D70-D23A-4742-A5B3-DC1B6CAD9C30@ai.rug.nl> <7v63rktekf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <frimmirf@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 03:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFJJF-0004NT-9u
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 03:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbYGFBoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 21:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYGFBoB
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 21:44:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:56311 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753324AbYGFBoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 21:44:00 -0400
Received: (qmail invoked by alias); 06 Jul 2008 01:43:59 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp033) with SMTP; 06 Jul 2008 03:43:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+p/QxQCu6p/Z8fUXxAfUySwCZS4a7FwxafMKByPS
	CETAOkmDLpjb7/
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v63rktekf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87484>

Hi,

On Sat, 5 Jul 2008, Junio C Hamano wrote:

> Also I do not see why -X<option> is not easy with parseopt() as Dscho 
> claimed in the original message in this thread...

Isn't that obvious?  -X looks like a short option, but the rest of that 
string does not consist of aggregated short options.

Besides, it is extremely ugly a syntax.  Just like git-log's -S thing.

Ciao,
Dscho
