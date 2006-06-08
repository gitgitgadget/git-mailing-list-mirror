From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 16:30:45 -0400
Message-ID: <BAYC1-PASMTP102B1021B943F57F9FB1EEAE8B0@CEZ.ICE>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
	<44880BE8.40804@etek.chalmers.se>
	<Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wtzaa26.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE>
	<Pine.LNX.4.63.0606082222470.28323@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, lukass@etek.chalmers.se, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 22:32:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoRAQ-0001FA-Oo
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 22:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWFHUbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 16:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWFHUbo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 16:31:44 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:39092 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S964979AbWFHUbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 16:31:43 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP10.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Jun 2006 13:33:56 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id C99E4644C28;
	Thu,  8 Jun 2006 16:31:41 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20060608163045.abd03553.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0606082222470.28323@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.9.2; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 Jun 2006 20:33:56.0578 (UTC) FILETIME=[DD6B0420:01C68B3A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 8 Jun 2006 22:24:31 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> I think --user makes more sense than --home, since it does not matter 
> _where_ it is stored, but _when_ it is retreived.

--home seems more natural to me for some reason but I don't feel strongly
about it.
 
> In the same vein, I do not think it is user friendly to expect the user to 
> remember if it was .gitconfig, .git or .gitrc.

Sure, was just thinking that this could be used by an administrator to
modify _other_ users' configs.. but probably not worth it.

Cheers,
Sean
