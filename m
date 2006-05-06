From: sean <seanlkml@sympatico.ca>
Subject: Re: Unresolved issues #2
Date: Sat, 6 May 2006 11:35:49 -0400
Message-ID: <BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605041627310.6713@iabervon.org>
	<Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
	<7vhd43vgnm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 06 17:41:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcOu5-0002sr-Ae
	for gcvg-git@gmane.org; Sat, 06 May 2006 17:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWEFPkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 11:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWEFPkt
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 11:40:49 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:39001 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750872AbWEFPkt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 11:40:49 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP10.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 6 May 2006 08:42:40 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4FAE1644C28;
	Sat,  6 May 2006 11:40:47 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060506113549.48e553d1.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 06 May 2006 15:42:40.0750 (UTC) FILETIME=[B56188E0:01C67123]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 6 May 2006 08:26:36 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> I _personally_ care about the semantics, but not very deeply - since I 
> tend to actually have just one main branch, and a couple of throw-away 
> ones if I ended up working on something.
> 
> But I think that for this thing to become useful, we want to care about 
> the format - or at least the interface to the different users (with the 
> acknowledgement that "users" should often be porcelain above us).
> 
> Right now we've basically had people hand-editing the remotes files, and I 
> think cogito still uses the older branches format that came from cogito in 
> the first place. I think we should just try to decide on a config file 
> format, and make it easy for cogito etc to use it.

Linus,

Wondering why you feel so strongly that most "users" shouldn't be real people.
What is wrong with continuing to make git easier for developers to use without
needing any extra software?

Sean
