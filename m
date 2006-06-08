From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 17:23:15 -0400
Message-ID: <BAYC1-PASMTP0920A286F2CC0660B6FDF1AE8B0@CEZ.ICE>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
	<44880BE8.40804@etek.chalmers.se>
	<Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wtzaa26.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE>
	<Pine.LNX.4.63.0606082222470.28323@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP102B1021B943F57F9FB1EEAE8B0@CEZ.ICE>
	<Pine.LNX.4.63.0606082235020.28405@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP040660E676E00AD1631524AE8B0@CEZ.ICE>
	<Pine.LNX.4.63.0606082308010.28722@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, lukass@etek.chalmers.se, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 23:25:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoRzH-0002z5-8R
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 23:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWFHVYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWFHVYO
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 17:24:14 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:60939 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S965029AbWFHVYO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 17:24:14 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Jun 2006 14:26:05 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 3FD12644C28;
	Thu,  8 Jun 2006 17:24:12 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20060608172315.15c2af3c.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0606082308010.28722@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.9.2; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 Jun 2006 21:26:05.0421 (UTC) FILETIME=[265A91D0:01C68B42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 8 Jun 2006 23:10:15 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> If I have --user vs. --repo, then I expect the setting to be active for 
> the user vs. the repository, respectively.

*shrug*  This seems exactly the same for --home; like I said I don't
care enough to argue about it though.

> Clearly, you have not met the same administrators as I did.

Maybe not.
 
> > obviously we can't guess all the creative ways git will be used beforehand.
> 
> That is right, but is it for somebody else to decide the creative way, or 
> for you?

My argument was that we should not build in policies that assume administrators
are incompetent.  That we should put the tools in their hands and not restrict
them.  That lets them be as creative as they want and not constrained because
we have a preexisting opinion about their abilities or an opinion about the
policies they should follow with regard to their users files etc.

Anyway, i'm bowing out of this discussion because i'm sure you'll decide
a reasonable course of action.

Cheers,
Sean
