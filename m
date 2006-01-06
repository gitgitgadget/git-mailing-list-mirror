From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Fri, 6 Jan 2006 15:28:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601061525100.3169@g5.osdl.org>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com>
 <7vek3lq8wu.fsf@assigned-by-dhcp.cox.net> <86wthd7ypx.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 00:29:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev11A-000050-TL
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 00:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWAFX3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 18:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWAFX3F
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 18:29:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932285AbWAFX3E (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2006 18:29:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k06NStDZ014262
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 Jan 2006 15:28:55 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k06NSrEC018608;
	Fri, 6 Jan 2006 15:28:54 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86wthd7ypx.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14228>



On Fri, 6 Jan 2006, Randal L. Schwartz wrote:

> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> 
> Junio> So I'd prefer not touching for (@df) { print H "$_\n" } loops.
> 
> Being as I'm a *bit* familiar with Perl, I'd write that as:
> 
>   print H "$_\0" for @deletedfiles;
> 
> if you want to write "for" as "foreach", I wouldn't complain either.
> After all, that's spelled "f o r", but pronounced "foreach". :)

It is official: perl people are crazy.

I'm sorry, Randal, but you're clearly a totally different species.

I just hope you don't cross-breed. Shudder.

		Linus
