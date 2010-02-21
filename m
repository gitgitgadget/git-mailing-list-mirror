From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Storing (hidden) per-commit metadata
Date: Sun, 21 Feb 2010 09:49:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002210945490.20986@pacific.mpi-cbg.de>
References: <1266599485.29753.54.camel@ganieda> <1266687636-sup-7641@ben-laptop> <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com> <20100221063433.GA2840@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 21 10:57:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj7Or-0002fH-7k
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 09:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab0BUImo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 03:42:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:43674 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754473Ab0BUImn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 03:42:43 -0500
Received: (qmail invoked by alias); 21 Feb 2010 08:42:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 21 Feb 2010 09:42:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nTDU630Hn5DCVHKp5UlN4awlRRz8sufqD3ND7U/
	KTcj2xgL4lFK49
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100221063433.GA2840@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140605>

Hi,

On Sun, 21 Feb 2010, Jeff King wrote:

> If the only problem is that the data is ugly in "git show", then perhaps 
> we need a "suppress these pseudo-headers" feature for showing logs. It 
> keeps them easily available for inspection or for --grep, but most of 
> the time you would not see them.

Whoa. Even more processing to do for each commit during a "git log" run? 
You know, other people are working on _accelerating_ git log as we speak!

And really, while I can understand that the OP wanted to hide the 
information, I am really against that. For example, when I see a log with 
git-svn footers, it gives me _additional_ information which I actually 
like (it tells me where these commits really come from). If they do not 
need bidirectional, they can skip those footers.

But I do agree that it is better to put the information into the same 
objects rather than notes, lest the information get out-of-sync.

Ciao,
Dscho
