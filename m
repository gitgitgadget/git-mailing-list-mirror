From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsck --lost-found writes to subdirectories in .git/lost-found/
Date: Wed, 4 Jul 2007 02:41:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707040240320.4071@racer.site>
References: <Pine.LNX.4.64.0707021751380.4071@racer.site>
 <7vabuewgdb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707030018120.4071@racer.site>
 <7vps3auz5y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707030133060.4071@racer.site>
 <20070704013311.GA32210@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Jul 04 03:41:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5try-0000qP-76
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 03:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbXGDBlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 21:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbXGDBlY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 21:41:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:38452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754022AbXGDBlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 21:41:23 -0400
Received: (qmail invoked by alias); 04 Jul 2007 01:41:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 04 Jul 2007 03:41:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qX5c9VC6qhy7vhytllZBpU9o0e9Et2PRXL044HE
	cz+Xd2WGjbCIuC
X-X-Sender: gene099@racer.site
In-Reply-To: <20070704013311.GA32210@diku.dk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51557>

Hi,

On Wed, 4 Jul 2007, Jonas Fonseca wrote:

> -	Write dangling refs into .git/commit/ or .git/other/, depending
> -	on type.
> +	Write dangling refs into .git/lost-found/commit/ or
> +	.git/lost-found/other/, depending on type.

Oooooops.

Thanks,
Dscho
