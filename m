From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-log --follow?
Date: Thu, 12 Jul 2007 11:44:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707121142110.4516@racer.site>
References: <20070704203541.GA13286@artemis.corp> <7vzm22vyin.fsf@assigned-by-dhcp.cox.net>
 <7vsl7uvx8v.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 12:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8wAD-0003vq-0y
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 12:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760860AbXGLKop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 06:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760329AbXGLKop
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 06:44:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:50128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760068AbXGLKoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 06:44:44 -0400
Received: (qmail invoked by alias); 12 Jul 2007 10:44:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 12 Jul 2007 12:44:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Bmvh59kzBNqsG14FpYTlyugK0U8nGR2FgABA8l7
	TFLnPjigLbVvmL
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl7uvx8v.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52266>

Hi,

On Thu, 12 Jul 2007, Junio C Hamano wrote:

> The message I am following up is a patch to unpack-trees.c, whose basic 
> code structure is Daniel's work, so I wanted to CC him and the easiest 
> way to look his address up was to run git-log on it.
> 
> Not so.
>
> [...]
> 
> "git log -- unpack-trees.c" would not follow into read-tree.c, but I 
> thought "git log --follow -- unpack-trees.c" is supposed to; I tried it 
> for the first time, but it does not seem to work as well as I hoped.

Your lesson as to why following renames is not as useful as some might 
want to make us believe is duly noted; will use it as back reference 
should I have to defend that view again.

However, I have to wonder why you did not solve your problem this way:

	git log --author=Daniel

Ciao,
Dscho
