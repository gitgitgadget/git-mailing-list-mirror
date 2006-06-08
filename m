From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 12:36:52 -0400
Message-ID: <BAYC1-PASMTP04DDBAA584B31A4B0F31DCAE8B0@CEZ.ICE>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
	<44880BE8.40804@etek.chalmers.se>
	<Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wtzaa26.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, lukass@etek.chalmers.se,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 18:38:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoNW7-0004q5-SG
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 18:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWFHQhv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 12:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWFHQhv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 12:37:51 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:25720 "EHLO
	BAYC1-PASMTP04.CEZ.ICE") by vger.kernel.org with ESMTP
	id S964778AbWFHQhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 12:37:50 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP04.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Jun 2006 09:37:49 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id AB7B1644C28;
	Thu,  8 Jun 2006 12:37:48 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060608123652.6c3acf76.seanlkml@sympatico.ca>
In-Reply-To: <7v1wtzaa26.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.9.2; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 Jun 2006 16:37:49.0705 (UTC) FILETIME=[E14DBF90:01C68B19]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 08 Jun 2006 09:25:53 -0700
Junio C Hamano <junkio@cox.net> wrote:


> The wording "--no-local" means you are looking at things
> relative to a particular repository.  I.e. some configuration
> variables come from repository-local file, and others from
> somewhere else.  But I do not think that somewhere else is
> "global".  We are reading from $HOME, which is different
> depending on who is interacting with that same repository.  So I
> would probably call the other one "--user" or something if I
> were force to pick name.

--user or --home makes a lot of sense.  Alternatively you could
just be explicit: --config=~ or --config=/etc/gitconfig where
/.gitconfig is automatically appended to the path if it ends in
a directory name.

Sean
