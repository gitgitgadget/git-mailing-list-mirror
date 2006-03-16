From: sean <seanlkml@sympatico.ca>
Subject: Re: git-reset and clones
Date: Thu, 16 Mar 2006 10:21:45 -0500
Message-ID: <BAYC1-PASMTP0354DF2E1D7C62E86C43D9AEE70@CEZ.ICE>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
	<44197C04.5080400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: paul@clubi.ie, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 16:25:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJuKj-0002Px-Jm
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 16:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWCPPYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 10:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbWCPPYK
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 10:24:10 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:53016 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751913AbWCPPYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 10:24:09 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 16 Mar 2006 07:24:08 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id BB6F2644C28;
	Thu, 16 Mar 2006 10:24:07 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Message-Id: <20060316102145.35294eed.seanlkml@sympatico.ca>
In-Reply-To: <44197C04.5080400@op5.se>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.14; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 16 Mar 2006 15:24:08.0707 (UTC) FILETIME=[AB7BFD30:01C6490D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Mar 2006 15:53:56 +0100
Andreas Ericsson <ae@op5.se> wrote:

> In mothership-repo:
> 	git checkout master
> 	git branch next-master ORIGIN
> 	git rebase next-master; # fix conflicts and commit
> 	git branch -d master
> 	git checkout -b master next-master
> 	git -d next-master
> 	git revert (the bad commits)

Downstream repos may still be broken afterward though; not much 
you can do about that unfortunately.

Sean
