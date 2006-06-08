From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 16:55:25 -0400
Message-ID: <BAYC1-PASMTP040660E676E00AD1631524AE8B0@CEZ.ICE>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
	<44880BE8.40804@etek.chalmers.se>
	<Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wtzaa26.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE>
	<Pine.LNX.4.63.0606082222470.28323@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP102B1021B943F57F9FB1EEAE8B0@CEZ.ICE>
	<Pine.LNX.4.63.0606082235020.28405@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, lukass@etek.chalmers.se, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 22:56:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoRYL-0006AO-IB
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 22:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWFHU40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 16:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWFHU40
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 16:56:26 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:13919 "EHLO
	BAYC1-PASMTP04.CEZ.ICE") by vger.kernel.org with ESMTP
	id S965012AbWFHU40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 16:56:26 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP04.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Jun 2006 13:56:23 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 2D1F8644C28;
	Thu,  8 Jun 2006 16:56:22 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20060608165525.e42917d2.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0606082235020.28405@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.9.2; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 Jun 2006 20:56:23.0491 (UTC) FILETIME=[003DA130:01C68B3E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 8 Jun 2006 22:42:17 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> I'd like to know how --home tells you when this key is retreived.

I honestly don't know.  How does --user tell you when this key is retrieved?

> The admin has no business messing around with the users' configuration. 
> And if she absolutely wants to be a BOFH, she can fire up any editor, or 
> copy .gitconfig to /root/.gitconfig, use git-config, and copy it back, or 
> do what she does all the time: "su <user>". But frankly, we should not 
> support a bad work flow.
> 
> BTW it is the same reason I would rather not see /etc/gitconfig: it 
> meddles with an existing configuration. If you want to give defaults, you 
> can use a skeleton for $HOME, and templates for $GIT_DIR. As a user, I 
> would be very surprised if the behaviour of git changed from one day to 
> the other without my changing anything.

This seems like a rather heavy handed policy for an application to enforce.
To my mind, these types of decisions are best left up to administrators; 
obviously we can't guess all the creative ways git will be used beforehand.

Sean
