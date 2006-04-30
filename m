From: sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] git builtin "push"
Date: Sun, 30 Apr 2006 16:50:28 -0400
Message-ID: <BAYC1-PASMTP037751CEC096DA29400513AEB00@CEZ.ICE>
References: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org>
	<445516F5.1090204@garzik.org>
	<Pine.LNX.4.64.0604301303010.5231@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jeff@garzik.org, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 22:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaIwm-00079V-Ox
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 22:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWD3UzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 16:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWD3UzI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 16:55:08 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:65513 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751217AbWD3UzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 16:55:07 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Apr 2006 13:55:06 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 46338644C28;
	Sun, 30 Apr 2006 16:55:05 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060430165028.215d4fdf.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0604301303010.5231@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 30 Apr 2006 20:55:06.0562 (UTC) FILETIME=[5C46F220:01C66C98]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 30 Apr 2006 13:07:42 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> The way it works is that
> 
> 	"git push repo"
> 
> with no branch specs will update all branches that are IN COMMON between 
> your tree and the repository you're pushing to. In other words, it's meant 
> to sync up the branches that you have already pushed.

True, as long as you don't have any Push: lines in your .git/remotes/repo
file.  Any such lines act just like you gave them on the command line
which afaik effectively removes the ability to say "update all branches
we have in common".

Sean
