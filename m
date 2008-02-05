From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/9] Send unpack-trees debugging output to stderr
Date: Tue, 5 Feb 2008 01:20:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050117410.8543@racer.site>
References: <alpine.LNX.1.00.0802041335430.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 02:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMCVY-0001w7-3t
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 02:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595AbYBEBVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 20:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbYBEBVX
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 20:21:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:32926 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754759AbYBEBVX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 20:21:23 -0500
Received: (qmail invoked by alias); 05 Feb 2008 01:21:20 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 05 Feb 2008 02:21:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18O175XL3UOV/eWrqo62hnRBDuJ6MCpPZRMpBKE+h
	TnSKU7Da1a/lsi
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041335430.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72606>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:

>  #if DBRT_DEBUG > 1
>  		if (first)
> -			printf("index %s\n", first);
> +			fprintf(stderr, "index %s\n", first);
>  #endif

This code path is only affected when DBRT_DEBUG is defined ("Daniel 
Barkalow's Roasted Tomatoes"?).  So technically, I do not really see why 
this is part of this patch series...

Ciao,
Dscho
