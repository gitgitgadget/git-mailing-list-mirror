From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Finally implement "git log --follow"
Date: Thu, 21 Jun 2007 16:55:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211654100.4059@racer.site>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
  <e5bfff550706192327l187b30eblb5bd5e4e76b3eab6@mail.gmail.com> 
 <alpine.LFD.0.98.0706200940000.3593@woody.linux-foundation.org>
 <e5bfff550706202321t354ec0e3xb218f382f1c983ae@mail.gmail.com>
 <alpine.LFD.0.98.0706210842340.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 17:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1P0B-0006oE-8U
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 17:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274AbXFUPzN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 11:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757238AbXFUPzM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 11:55:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:46914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756897AbXFUPzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 11:55:10 -0400
Received: (qmail invoked by alias); 21 Jun 2007 15:55:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 21 Jun 2007 17:55:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q8MA+62OqWOonJOvryr7aNiF3UWta7CzMXsd2YZ
	c/AOov7OQcCvF7
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0706210842340.3593@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50637>

Hi,

On Thu, 21 Jun 2007, Linus Torvalds wrote:

> On Thu, 21 Jun 2007, Marco Costalba wrote:
> > 
> > Bad: Currently git-log does not support --stdin option, required IMHO
> > when git-log is runned by a tool, not a user, due to the possibility
> > of a very long command line.
> 
> I do think we should just fix this. The patch to do so can't be *that* 
> bad.

The only quirk here is that "--stdin" makes no sense with a pager. 
Therefore, you'd have to move the automatic pager invocation to _after_ 
option parsing.

Ciao,
Dscho
