From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Thu, 5 Jul 2007 20:22:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707052018260.9789@racer.site>
References: <Pine.LNX.4.64.0707051312260.9789@racer.site>
 <81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com>
 <7vsl82dcj0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707051811310.9789@racer.site>
 <7vfy42d6m0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 21:23:01 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Wuq-0002tz-Co
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 21:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555AbXGETW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 15:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757255AbXGETW5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 15:22:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:37021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756883AbXGETW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 15:22:57 -0400
Received: (qmail invoked by alias); 05 Jul 2007 19:22:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 05 Jul 2007 21:22:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vW7Ncev/vf7Mk0Z7S9AxOdBLcOrRRUTo+I8ojCo
	O4PAr6/pqJozFa
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy42d6m0.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51691>

Hi,

On Thu, 5 Jul 2007, Junio C Hamano wrote:

> I think what Alex meant is this.
> 
> diff --git a/templates/rr-cache-- b/templates/rr-cache--
> new file mode 100644
> index 0000000..fae8870
> --- /dev/null
> +++ b/templates/rr-cache--
> @@ -0,0 +1 @@
> +: this is just to ensure the directory exists.
> 

Yes, I fully understood.

However, when I use a new version of Git (which happens regularly, since I 
pull quite often), I do not update the templates. I guess that many 
distros do not update their templates as often as the core, because they 
are much more likely to be modified distro-specifically. Further, there 
are some platforms which are insane enough that you cannot trust the 
executable bit, and therefore the templates are disabled by default.

All this means that the given patch would not hardly make rerere as 
widespread as I intended.

Yes, templates are nice. But I don't think that templates are the way to 
go for introducing nice features as rr-cache.

Ciao,
Dscho
