From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 22:11:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706192210430.4059@racer.site>
References: <18039.52754.563688.907038@lisa.zopyra.com>
 <Pine.LNX.4.64.0706191359160.4059@racer.site> <20070619132456.GA15023@fiberbit.xs4all.nl>
 <18039.57099.57602.28299@lisa.zopyra.com> <20070619143000.GA15352@fiberbit.xs4all.nl>
 <18039.60598.264803.940960@lisa.zopyra.com> <86k5u0q8q9.fsf@lola.quinscape.zz>
 <18040.346.208040.842060@lisa.zopyra.com> <20070619200939.GA4180@steel.home>
 <18040.17211.575543.403408@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:11:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0kzO-0004TN-KY
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 23:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbXFSVLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 17:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754957AbXFSVLq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 17:11:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:50042 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753124AbXFSVLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 17:11:45 -0400
Received: (qmail invoked by alias); 19 Jun 2007 21:11:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 19 Jun 2007 23:11:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yhfgE+g6ywZvB719flI1tY5giy/hcoFcTQNwOfg
	BhVzU1i4q9XPye
X-X-Sender: gene099@racer.site
In-Reply-To: <18040.17211.575543.403408@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50510>

Hi,

On Tue, 19 Jun 2007, Bill Lear wrote:

> (cd blt && tar cf - .) | od -a | head -50
> 
> Here is the result of that:
> 
> 0000000   /   h   o   m   e   /   b   l   e   a   r   /   b   u   i   l
> 0000020   d   /   g   i   t   -   1   .   5   .   2   .   2   /   t   e
> 0000040   m   p   l   a   t   e   s   /   b   l   t  nl   .   / nul nul
> 0000060 nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul

As is easy to see, what has been suggested earlier is true. The cd 
(idiotically) outputs the path to stdout.

Hth,
Dscho
