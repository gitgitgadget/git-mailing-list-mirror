From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 21:06:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705042104370.4015@racer.site>
References: <463ADE51.2030108@gmail.com> <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net> <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
 <463AFAAE.853DEF7B@eudaptics.com> <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 21:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk37B-0006UV-6h
	for gcvg-git@gmane.org; Fri, 04 May 2007 21:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161888AbXEDTGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 15:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161893AbXEDTGm
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 15:06:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:44607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161888AbXEDTGl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 15:06:41 -0400
Received: (qmail invoked by alias); 04 May 2007 19:06:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 04 May 2007 21:06:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5xsYVauz5Fhoaq0sZm7Pkm/EdVFcN+CsGwkFQkh
	66c9WeYTylajhH
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46201>

Hi,

On Fri, 4 May 2007, Junio C Hamano wrote:

> (a big release in the future, perhaps 1.6.0)
> 
>  - "<something>:<path>" becomes relative to where you are.

FWIW I still find that unintuitive. I know "<something>:<path>" from ssh, 
and there it does not change meaning depending on where I am. IMHO in most 
cases you want to use git-diff anyway, which _does_ honour the current 
relative path.

Ciao,
Dscho
