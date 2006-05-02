From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 2 May 2006 14:23:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605021422200.4086@g5.osdl.org>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> <e34bdf$ho4$1@sea.gmane.org>
 <7vhd4as00i.fsf@assigned-by-dhcp.cox.net> <e34cb4$is1$1@sea.gmane.org>
 <44571967.7080807@op5.se> <7vy7xkn6kd.fsf@assigned-by-dhcp.cox.net>
 <e378fs$lpc$1@sea.gmane.org> <7v1wvcmejr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 23:23:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb2LE-00021b-Ek
	for gcvg-git@gmane.org; Tue, 02 May 2006 23:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWEBVX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 17:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWEBVX3
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 17:23:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964978AbWEBVX2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 17:23:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k42LN7tH000991
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 2 May 2006 14:23:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k42LN5ME015442;
	Tue, 2 May 2006 14:23:06 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wvcmejr.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19427>



On Tue, 2 May 2006, Junio C Hamano wrote:
> 
>  - The shell-script one, if you use GNU grep, accepts more
>    options to grep than what the current built-in one supports.
>    Notable ones that are missing: fixed strings (-F), patterns
>    from file (-f), count matches (-c), omit filenames (-h),
>    skipping binary files (-I, -U), files without match (-L),
>    pcre (-P), silent (-q), word expression (-w), NUL (-z).  They
>    should be easy to add if somebody cares enough, and I plan to
>    do a few myself before pushing it out to "master".

I use "-w" all the time, along with -5 or similar to get context for the 
grep.

		Linus
