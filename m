From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/21] Use prefixcmp() instead of memcmp() for cleaner
 code with less magic numbers
Date: Sun, 10 Jun 2007 09:41:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100939460.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090217.49818.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJ28-0005Dn-Q1
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbXFJIoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbXFJIoU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:44:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:59251 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751549AbXFJIoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:44:19 -0400
Received: (qmail invoked by alias); 10 Jun 2007 08:44:18 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp029) with SMTP; 10 Jun 2007 10:44:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KhdNUqYwKUbHCSpj5Wgj7D6NIAb/xkVFGj0ZS1d
	luhWvrqMd5w3jk
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090217.49818.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49684>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:
>
> -	if (memcmp(data, "object ", 7))
> +	if (prefixcmp(data, "object "))

FWIW I think that _these_ changes are actually somewhat worth it. And they 
should have come _instead_ of moving the order of the memcmp() around 
(you know which patch that was).

Ciao,
Dscho
