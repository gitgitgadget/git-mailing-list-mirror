From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/9] Export create_branch() from builtin-branch.c
Date: Tue, 5 Feb 2008 01:38:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802050136440.8543@racer.site>
References: <alpine.LNX.1.00.0802041336010.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 02:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMCnI-00061w-D7
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 02:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915AbYBEBjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 20:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757146AbYBEBjq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 20:39:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:42330 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755768AbYBEBjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 20:39:45 -0500
Received: (qmail invoked by alias); 05 Feb 2008 01:39:43 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp058) with SMTP; 05 Feb 2008 02:39:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OMHkuCoXO9M6GBsfr47fFTJyR+C1/VehG5qPKiL
	9lYnv0FrSJpilr
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041336010.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72610>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:

> You can also create branches, in exactly the same way, with checkout -b.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  builtin-branch.c |    4 ++--
>  cache.h          |    4 ++++

Note that builtin-branch.c is not part of libgit.a, so you are only moving 
the declaration into the "libgit" part.

Maybe it would be better to move this function, say, into refs.c?

Ciao,
Dscho
