From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 21:42:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705042140430.4015@racer.site>
References: <463ADE51.2030108@gmail.com> <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net> <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
 <463AFAAE.853DEF7B@eudaptics.com> <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0705042104370.4015@racer.site> <7v1whwtmvj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0705042127390.4015@racer.site> <7vwszos7l2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 21:43:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk3gW-0005Kq-1r
	for gcvg-git@gmane.org; Fri, 04 May 2007 21:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161914AbXEDTnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 15:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161922AbXEDTnE
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 15:43:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:56226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161919AbXEDTnB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 15:43:01 -0400
Received: (qmail invoked by alias); 04 May 2007 19:42:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 04 May 2007 21:42:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0cQlhvuG0ReT7x5GiU0/HtstEgIQhsXmDgGYlHV
	dNEDHkhYOLkTX4
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwszos7l2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46207>

Hi,

On Fri, 4 May 2007, Junio C Hamano wrote:

> ... don't you expect "git show HEAD@{yesterday}:git.txt" while
> in Documentation/ subdirectory to work?

Actually, no. I expect "git diff HEAD@{yesterday} git.txt" to work fine, 
and "git show HEAD@{yesterday}:git.c" also, both when in Documentation/, 
because I expect "git show HEAD@{yesterday}:git.c" to work _also_ when I 
set GIT_DIR=/path/to/my/bare-repo.git/ before that, while I do not expect 
the call to git-diff to work (for obvious reasons).

Ciao,
Dscho
