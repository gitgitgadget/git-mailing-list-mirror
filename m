From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 05:02:57 -0400 (EDT)
Message-ID: <BAYC1-PASMTP05141C92C0F083A17B2EEFAE960@CEZ.ICE>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
    <7vzmq4faz6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Peter Eriksen" <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 11:03:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIjSl-0007nU-Qx
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 11:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVIWJDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 05:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVIWJDK
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 05:03:10 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:10571 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750827AbVIWJDF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 05:03:05 -0400
X-Originating-IP: [64.231.205.75]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.75]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 23 Sep 2005 02:02:30 -0700
Received: by linux1.attic.local (Postfix, from userid 48)
	id F2F6D644C12; Fri, 23 Sep 2005 05:02:57 -0400 (EDT)
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 23 Sep 2005 05:02:57 -0400 (EDT)
Message-ID: <54643.10.10.10.28.1127466177.squirrel@linux1>
In-Reply-To: <7vzmq4faz6.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Sep 2005 09:02:31.0439 (UTC) FILETIME=[87C5A9F0:01C5C01D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, September 23, 2005 4:24 am, Junio C Hamano said:

> I haven't assessed the extent of damage if we tried to use ``
> for portability lately (I did once, and it did not look too bad
> back then).  If somebody comes up with a readable patch, I might
> be persuaded to take it [*1*].

Junio,

It sounds like changing the sha-bang line to "#!/bin/bash" would fix the
problem on Solaris.  As an aside, it would improve vi syntax highlighting
as well.  Does any target system lack bash?

If not, would you accept a patch that first converted the shell scripts to
#!/bin/bash and then added a "make install" option that allowed them to be
replaced?   Something like "make install S=/bin/ash" for instance?

Sean
