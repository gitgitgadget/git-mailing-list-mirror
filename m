From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix push with refspecs containing wildcards
Date: Fri, 8 Jun 2007 11:13:32 +0200
Message-ID: <20070608091332.GA2429@steel.home>
References: <20070607225302.GA10633@steel.home> <20070607234305.GB10633@steel.home> <7v4pljlzm3.fsf@assigned-by-dhcp.cox.net> <7vodjqlwnc.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 11:14:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwaXq-0003b5-AG
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 11:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbXFHJNh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 05:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763954AbXFHJNh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 05:13:37 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:18558 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbXFHJNf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 05:13:35 -0400
Received: from tigra.home (Fc805.f.strato-dslnet.de [195.4.200.5])
	by post.webmailer.de (fruni mo54) (RZmta 7.2)
	with ESMTP id F01734j588AcJF ; Fri, 8 Jun 2007 11:13:33 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C7591277BD;
	Fri,  8 Jun 2007 11:13:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B31D8BEA7; Fri,  8 Jun 2007 11:13:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vodjqlwnc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWosH
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49452>

Junio C Hamano, Fri, Jun 08, 2007 09:42:47 +0200:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Sending a fix is a good thing, but whenever doing one, could
> > people please also do a testcase that demonstrates the original
> > bug, and also a demonstration that the fix does not introduce
> > regression?

Sorry. I actually have a test script I used to develop the fix,
but somehow missed to send it.

> > For this one, obviously a test for push that uses such wildcard
> > ref is needed but at the same time we would want a test for push
> > that does _not_ use a wildcard, fetch that uses a wildcard, and
> > a fetch that does not use a wildcard.
> 
> How about this?
> ---
> 
>  t/t5516-fetch-push.sh |   82 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 82 insertions(+), 0 deletions(-)
> 

Gratefully-Acked-by: Alex Riesen <raa.lkml@gmail.com>
