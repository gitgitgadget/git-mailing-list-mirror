From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Introduce optional "keywords" on tag objects
Date: Sun, 10 Jun 2007 19:42:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706101937250.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net> <200706101347.57023.johan@herland.net>
 <200706101350.00271.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:46:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxSQQ-0005TJ-K3
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 20:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758698AbXFJSqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 14:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758946AbXFJSqA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 14:46:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:37149 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757439AbXFJSp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 14:45:58 -0400
Received: (qmail invoked by alias); 10 Jun 2007 18:45:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 10 Jun 2007 20:45:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zUy89yHNzE/1CrnXyROH8ip/bGcjc7cWYqDqPKy
	RWdZ7aetEaxthc
X-X-Sender: gene099@racer.site
In-Reply-To: <200706101350.00271.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49754>

Hi,

On Sun, 10 Jun 2007, Johan Herland wrote:

> +	/* Verify the keywords: disallow ctrl chars, spaces and double commas */

What about Junio's suggestion, making it really strict at first, and only 
loosening it if we need to? IIRC it was alnum + '_', maybe even '-'.

Other than that, looks good to me. I trust that the test cases are 
exhaustive enough to support the patch from the practical side.

BTW this patch is exactly what I meant by conceptually closed. Thank you.

And please accept my apologies for my language. Reading some of it, I have 
to admit that it sounded as harsh as Junio suggested it to be. My only 
excuse is that I had an unplanned stay at the Paris airport for more than 
9 hours (after a night in the plane where I could hardly sleep), so I 
should really have stayed away from writing emails. But since you 
addressed your emails to me, I wanted to reply to you as soon as I had the 
chance to.

Ciao,
Dscho
