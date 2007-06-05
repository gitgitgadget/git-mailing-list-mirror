From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] git-merge-file: refuse to merge binary files
Date: Tue, 5 Jun 2007 06:11:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706050607490.4046@racer.site>
References: <Pine.LNX.4.64.0706050337010.4046@racer.site>
 <alpine.LFD.0.98.0706042059420.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 07:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvRMh-0000FD-1C
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 07:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbXFEFNl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 01:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbXFEFNl
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 01:13:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:51670 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754315AbXFEFNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 01:13:40 -0400
Received: (qmail invoked by alias); 05 Jun 2007 05:13:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 05 Jun 2007 07:13:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19aC14/SQZaOyGcjRCgENvv7hzlqsL3enOaWFmYXI
	3gpXTKWC21q4/x
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0706042059420.23741@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49160>

Hi,

On Mon, 4 Jun 2007, Linus Torvalds wrote:

> I really think this would be better off using the crlf-like heuristics.

I don't know. Given that it took quite a while to actually hit this bug...

> It's entirely possible that the "NUL character in the first X bytes" 
> heuristic is wrong for some cases, so I find it a bit nasty to 
> hardcoding it as the only rule for "it must be binary"

Yes, you're right.

However, if you call git-merge-file, you have to be aware of what it does. 
It is a _standalone_ program, meant to make it easier to write scripts. 
Maybe it is not worth detecting binary files _at all_ in merge-file.

Ciao,
Dscho
