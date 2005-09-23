From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 06:34:45 -0400 (EDT)
Message-ID: <BAYC1-PASMTP03087B2B759861CF1C864AAE960@CEZ.ICE>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
    <7vzmq4faz6.fsf@assigned-by-dhcp.cox.net>
    <BAYC1-PASMTP05141C92C0F083A17B2EEFAE960@CEZ.ICE>
    <7vfyrwdtv0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 12:36:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIktd-0004O7-Fk
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 12:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVIWKex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 06:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbVIWKex
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 06:34:53 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:15377 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750848AbVIWKew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 06:34:52 -0400
X-Originating-IP: [64.231.205.75]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.75]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 23 Sep 2005 03:34:15 -0700
Received: by linux1.attic.local (Postfix, from userid 48)
	id 436F9644C12; Fri, 23 Sep 2005 06:34:45 -0400 (EDT)
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 23 Sep 2005 06:34:45 -0400 (EDT)
Message-ID: <39450.10.10.10.28.1127471685.squirrel@linux1>
In-Reply-To: <7vfyrwdtv0.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Sep 2005 10:34:16.0094 (UTC) FILETIME=[58CD5BE0:01C5C02A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, September 23, 2005 5:19 am, Junio C Hamano said:
> "Sean" <seanlkml@sympatico.ca> writes:
>
>> If not, would you accept a patch that first converted the shell scripts
>> to
>> #!/bin/bash and then added a "make install" option that allowed them to
>> be
>> replaced?   Something like "make install S=/bin/ash" for instance?
>
>     $ make SHELL_PATH=/bin/bash
>
> Perhaps?
>

Heh.. so you've already got that working :o)   So on Solaris one fix would
be to just use the SHELL_PATH setting when installing to point to
/bin/bash.   What do you think about making /bin/bash the default?

Sean
