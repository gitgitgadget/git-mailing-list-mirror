From: sean <seanlkml@sympatico.ca>
Subject: Re: git ident
Date: Sun, 9 Apr 2006 15:02:42 -0400
Message-ID: <BAYC1-PASMTP08A5DFC9CAE6F26A5E3B68AECF0@CEZ.ICE>
References: <44395711.7000902@jeremyenglish.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 21:06:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSfEg-0008E8-7P
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 21:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWDITGH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 15:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWDITGH
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 15:06:07 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:47414 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750761AbWDITGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 15:06:06 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 9 Apr 2006 12:09:54 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 33BC5644C28;
	Sun,  9 Apr 2006 15:06:04 -0400 (EDT)
To: Jeremy English <jhe@jeremyenglish.org>
Message-Id: <20060409150242.1796c993.seanlkml@sympatico.ca>
In-Reply-To: <44395711.7000902@jeremyenglish.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 Apr 2006 19:09:54.0843 (UTC) FILETIME=[2F864EB0:01C65C09]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 09 Apr 2006 13:48:49 -0500
Jeremy English <jhe@jeremyenglish.org> wrote:

> I keep a local project in a git archive.  After the last upgrade I get a 
> ident error when trying to commit.  It works after I set the environment 
> variables.  What I don't like is that the error comes up after I have 
> typed in my comment, then my comment is lost, that's frustrating.  The 
> other thing is I don't care if the commit is coming from a valid person, 
> why require this?

Believe it is required to reduce the number of commits made in the 
kernel project with incorrect attribution.   To remove the need to
set environment variables, use the repo-config command to set some
defaults:

$ git repo-config user.email "you@email.com"
$ git repo-config user.name "your name"

HTH,
Sean
