From: sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 14:14:12 -0400
Message-ID: <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org>
	<7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
	<e2lijt$aco$1@sea.gmane.org>
	<Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
	<BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE>
	<Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 20:18:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYS7Q-0000tZ-7w
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 20:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWDYSSd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 14:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWDYSSd
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 14:18:33 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:32402 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932200AbWDYSSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 14:18:33 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Apr 2006 11:18:32 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 76D9D644C28;
	Tue, 25 Apr 2006 14:18:31 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060425141412.5c115f51.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 Apr 2006 18:18:32.0860 (UTC) FILETIME=[A92105C0:01C66894]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Apr 2006 11:08:31 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Which is exactly what I told you to do. Just don't make it a git header. 

Well I just don't see how making it a header, or plopping it at the
end of a commit message makes an iota of difference to git, while it 
can help porcelain.

> We do that already. Look at "git revert". Ooh. Aah. It works today.

Nice.  Gotta love git.
 
> Just don't make it something that changes semantics, and that git parses 
> and "understands". Because git clearly doesn't understand it at all, since 
> you didn't define it to have any meaning that _can_ be understood.

But that's exactly the point, it's no different than extending git to be
able to store more than one comment.   Comment1 Comment2 Comment3.  
Pure content that git need not give any semantic meaning.  Git has a 
limitation of only a single comment today, there's no semantic damage
to extending git to allow multiple comments.   And there are a few 
applications, like bug tracking etc, which could use such a feature 
to good effect.

Sean
