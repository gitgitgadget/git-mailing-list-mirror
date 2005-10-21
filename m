From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: add "--dense" flag
Date: Fri, 21 Oct 2005 16:55:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510211648340.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Oct 22 01:55:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET6jg-0001c6-A4
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 01:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVJUXze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 19:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVJUXze
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 19:55:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39352 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965099AbVJUXzd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 19:55:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9LNtMFC023827
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Oct 2005 16:55:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9LNtL0w028534;
	Fri, 21 Oct 2005 16:55:22 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10455>



On Fri, 21 Oct 2005, Linus Torvalds wrote:
>
> 	[torvalds@g5 linux]$ git-rev-list --dense HEAD -- kernel | wc -l
> 	356

Btw, one additional point.

This took 0.91 seconds to complete on the current kernel history on my 
machine with a pretty much fully packed archive, and the memory footprint 
was a total of about 12MB.

And it scales pretty well too. On the historical linux archive, which is 
three years of history, the same thing takes me just over 12 seconds and 
52MB, and that's for the _whole_ history. And it's not just following one 
file: it's following that subdirectory.

So it really is pretty damn cool. 

Of course, I might have a bug somewhere, but it all _seems_ to work very 
well indeed.

			Linus
