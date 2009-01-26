From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: backwards compatibility, was Re: [PATCH v1 1/3] Introduce config
 variable "diff.primer"
Date: Mon, 26 Jan 2009 11:59:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901261154330.14855@racer>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
 <20090126031206.GB14277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 12:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRPCw-0001SW-NW
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbZAZK7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 05:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbZAZK7S
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 05:59:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:39032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751139AbZAZK7S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 05:59:18 -0500
Received: (qmail invoked by alias); 26 Jan 2009 10:59:16 -0000
Received: from pD9EB294D.dip0.t-ipconnect.de (EHLO noname) [217.235.41.77]
  by mail.gmx.net (mp049) with SMTP; 26 Jan 2009 11:59:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JM7wrMziJ08qTxs0a0oRk90/ikFyl1i5Qi6EyiI
	UB0jGcOVRvszbv
X-X-Sender: gene099@racer
In-Reply-To: <20090126031206.GB14277@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107186>

Hi,

On Sun, 25 Jan 2009, Jeff King wrote:

>   1. Sometimes we blur the line of plumbing and porcelain, where
>      functionality is available only through plumbing. For example,
>      gitweb until recently called "git diff" because there is no other
>      way to diff two arbitrary blobs. But the solution there is, I
>      think, to make that functionality available through plumbing. Not
>      to disallow enhancements to porcelain.

Just a reminder: we are very conservative when it comes to breaking 
backwards compatibility.  For example, people running (but not upgrading) 
gitweb who want to upgrade Git may rightfully expect their setups not to 
be broken for a long time, if ever.

So your mentioning gitweb using "git diff" precludes all kind of cute 
games, methinks.

And please no "anybody who would do this and that would be nuts" excuses: 
if you want to change something fundamental like this, _you_ have to 
defend it.

It is not acceptable to just shout out what you want and expect those 
affected negatively to do the impact analysis for you.

Ciao,
Dscho
