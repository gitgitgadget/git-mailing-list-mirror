From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git init: activate rerere by default
Date: Thu, 5 Jul 2007 23:40:32 +0200
Message-ID: <20070705214032.GB8751@steel.home>
References: <Pine.LNX.4.64.0707051312260.9789@racer.site> <81b0412b0707050610mddaf5c0w724b747fe10ed6f9@mail.gmail.com> <7vsl82dcj0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707051811310.9789@racer.site> <7vfy42d6m0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707052018260.9789@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 23:40:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Z43-0007Xb-FV
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 23:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759957AbXGEVkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 17:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760289AbXGEVkg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 17:40:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:11628 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759817AbXGEVkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 17:40:35 -0400
Received: from tigra.home (Fa824.f.strato-dslnet.de [195.4.168.36])
	by post.webmailer.de (fruni mo30) (RZmta 8.3)
	with ESMTP id n000e7j65LKc0M ; Thu, 5 Jul 2007 23:40:33 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E8DB4277BD;
	Thu,  5 Jul 2007 23:40:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BEEFCC164; Thu,  5 Jul 2007 23:40:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707052018260.9789@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTYT9w==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51695>

Johannes Schindelin, Thu, Jul 05, 2007 21:22:43 +0200:
> Yes, templates are nice. But I don't think that templates are the way to 
> go for introducing nice features as rr-cache.

Looks like you're trying to enforce the feature, not introduce.
It changes the user-visible behaviour, and this can be unexpected.

It is not like you see people asking question: "How do I avoid
repeating the same boring conflict?" every day on vger or irc.

That said, the templates are installed with every make install (and I
suppose with every .deb and .rpm), and template is copied in every new
repo, so people will get the rr-cache sooner or later. What's wrong
with "a bit later" than "much sooner"?
