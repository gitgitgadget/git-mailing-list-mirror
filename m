From: sean <seanlkml@sympatico.ca>
Subject: Re: Unresolved issues #2
Date: Sat, 6 May 2006 12:53:23 -0400
Message-ID: <BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605041627310.6713@iabervon.org>
	<Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
	<7vhd43vgnm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
	<BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE>
	<Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 18:58:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcQ71-0005CS-LO
	for gcvg-git@gmane.org; Sat, 06 May 2006 18:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWEFQ6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 12:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWEFQ6X
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 12:58:23 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:8124 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750971AbWEFQ6W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 12:58:22 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 6 May 2006 10:02:50 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id F0517644C28;
	Sat,  6 May 2006 12:58:20 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060506125323.544c35db.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 06 May 2006 17:02:50.0718 (UTC) FILETIME=[E85867E0:01C6712E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 6 May 2006 09:30:48 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Basically, it boils down to the end result.
> 
> If you design things for "people", then things tend to become hard to 
> automate, and it's hard to make wrappers around it. Maybe you've even made 
> the interfaces interactive, and thus any wrappers around it are simply 
> screwed, or need to do insane things.

Okay, I mistook the scope of you comments to apply to all of git rather than
as a reminder that we can't forget about the toolkit design.  So I take it
you're not at all against git including higher level user commands; just so
long as they're built on top of lower level toolkit commands that other
porcelain can use as well.

In this particular case I see "git repo-config" as the low level command that
any porcelain can use to access the remotes information and the proposed
"git remotes" as a simple convenience wrapper on top of this.  Of course,
everyone has to agree on the config file format; but that is true whether
the human-friendly wrapper exists or not.

Sean
