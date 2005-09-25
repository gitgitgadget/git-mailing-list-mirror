From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: /bin/sh portability question
Date: Sun, 25 Sep 2005 15:36:45 -0400 (EDT)
Message-ID: <BAYC1-PASMTP02CBC8364AB52CD372AEC0AE880@CEZ.ICE>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
    <7vzmq4faz6.fsf@assigned-by-dhcp.cox.net>
    <BAYC1-PASMTP05141C92C0F083A17B2EEFAE960@CEZ.ICE>
    <7vfyrwdtv0.fsf@assigned-by-dhcp.cox.net>
    <39450.10.10.10.28.1127471685.squirrel@linux1>
    <20050925192608.GD19023@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 21:37:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJcIx-0006ZZ-Cb
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 21:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVIYTgt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 15:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVIYTgt
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 15:36:49 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:56683 "EHLO
	BAYC1-PASMTP02.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932279AbVIYTgs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 15:36:48 -0400
X-Originating-IP: [64.231.205.75]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.75]) by BAYC1-PASMTP02.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 25 Sep 2005 12:36:09 -0700
Received: by linux1.attic.local (Postfix, from userid 48)
	id F3DA9644C14; Sun, 25 Sep 2005 15:36:45 -0400 (EDT)
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 25 Sep 2005 15:36:45 -0400 (EDT)
Message-ID: <33541.10.10.10.28.1127677005.squirrel@linux1>
In-Reply-To: <20050925192608.GD19023@schottelius.org>
To: "Nico -telmich- Schottelius" <nico-linux-git@schottelius.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 25 Sep 2005 19:36:09.0412 (UTC) FILETIME=[61137840:01C5C208]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, September 25, 2005 3:26 pm, Nico -telmich- Schottelius said:

> I think it's a bad idea, because some systems do not have and want bash,
> because it's unneeded. On all systems here we've ash as /bin/sh and
> /bin/zsh as primary user shell. Thus, /bin/bash does not exist, because
> it's not as comfortable as zsh and not as small as ash.

Hi Nico,

My guess is that your system configuration is in the minority and that
most target systems have bash installed today.  But all you'd have to do
is make a link from /bin/zsh to /bin/bash, or use the SHELL_PATH variable
to change all the scripts to /bin/zsh at install time.

Sean
