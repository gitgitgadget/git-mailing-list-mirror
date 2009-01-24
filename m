From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Sat, 24 Jan 2009 15:14:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901241513460.13232@racer>
References: <20090117153846.GB27071@coredump.intra.peff.net> <200901220113.32711.markus.heidelberg@web.de> <7vmydi4kiz.fsf@gitster.siamese.dyndns.org> <200901241228.33690.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 15:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQjI1-0002K5-49
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 15:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbZAXONu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 09:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbZAXONt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 09:13:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:47516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753618AbZAXONs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 09:13:48 -0500
Received: (qmail invoked by alias); 24 Jan 2009 14:13:46 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp035) with SMTP; 24 Jan 2009 15:13:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QUtl+QVzQrlg33zCN6a0ENWjF6vQelnhDSMsKDi
	fKmqIjUhv737iz
X-X-Sender: gene099@racer
In-Reply-To: <200901241228.33690.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106968>

Hi,

On Sat, 24 Jan 2009, Markus Heidelberg wrote:

> format-patch is perhaps the only place where the commit has broken 
> things, because I didn't find other places, where color config options 
> were set, but not the corresponding variables. So it seems as if only 
> format-patch needed code like this to turn off the colors.

So you want to add a test case when you resubmit your patch...

Ciao,
Dscho
