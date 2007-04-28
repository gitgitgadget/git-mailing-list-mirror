From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Sat, 28 Apr 2007 18:48:36 +0200
Message-ID: <20070428164836.GA6646@steel.home>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br> <1177693212202-git-send-email-lcapitulino@mandriva.com.br> <Pine.LNX.4.64.0704280446180.12006@racer.site> <20070428115059.GA4888@steel.home> <20070428130201.27630ed4@gnut>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, junkio@cox.net,
	git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Sat Apr 28 18:48:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhq6F-0002w2-GR
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 18:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031549AbXD1Qsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 12:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031552AbXD1Qsk
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 12:48:40 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:47079 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031549AbXD1Qsj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 12:48:39 -0400
Received: from tigra.home ([195.4.175.39] [195.4.175.39])
	by post.webmailer.de (fruni mo63) (RZmta 5.8)
	with ESMTP id F063abj3SANEsR ; Sat, 28 Apr 2007 18:48:37 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5A676277BD;
	Sat, 28 Apr 2007 18:48:37 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D5BC0CF17; Sat, 28 Apr 2007 18:48:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070428130201.27630ed4@gnut>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOMblA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45780>

Luiz Fernando N. Capitulino, Sat, Apr 28, 2007 18:02:01 +0200:
> > Look at what list_for_each_* macros did to the source of Linux kernel.
> 
> BTW, I was considering using Linux kernel's linked list
> implementation in git, since we have some linked lists around.

Do you have some definite place in mind? It's just that the kernel
lists where intentionally kept very simple, so the list
implementations in git probably are as close to the kernel's as it
sanely possible, at which point bringing them in wont change much.

> But I think people won't like it.

It depends on what you change and how you do it. Show us
