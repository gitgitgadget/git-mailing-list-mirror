From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/21] Free mktag's buffer before dying
Date: Sun, 10 Jun 2007 09:38:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100927050.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090216.41856.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:42:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIzw-0004z6-BC
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762884AbXFJImE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762851AbXFJImB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:42:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:34508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762850AbXFJImA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:42:00 -0400
Received: (qmail invoked by alias); 10 Jun 2007 08:41:59 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp019) with SMTP; 10 Jun 2007 10:41:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FXApqYhbFjJwaUXCSPud+uBlqk7NfbOZcGiRu06
	LyEWPQOcGVdatQ
X-X-Sender: gene099@racer.site
In-Reply-To: <200706090216.41856.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49681>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

How does this:

> -		usage("git-mktag < signaturefile");
> +		usage("git-mktag < tag_data_file");

and this:

> -

relate with your commit message?

You might understand that people _could_ get the impression that the 
patches were not very carefully crafted. Or even worse, the impression, 
that it was tried to slip some changes by, with a totally unrelated 
"official" purpose. (Again, reminds me of politics: it's like 
slipping an intrusive privacy law into an agriculture related law at the 
11th hour, just before Christmas, when people do not really pay 
attention.)

Ciao,
Dscho
