From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix approxidate() to understand more extended numbers
Date: Thu, 28 Sep 2006 23:03:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609282300190.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0609281211260.3952@g5.osdl.org> 
 <Pine.LNX.4.64.0609281212380.3952@g5.osdl.org>
 <118833cc0609281712u2ce01bc5r8f3e97ae9c9a749a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 29 08:03:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTBSy-0002Qy-QW
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 08:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbWI2GDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 02:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161285AbWI2GDS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 02:03:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161267AbWI2GDR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 02:03:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8T63CnW031245
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 23:03:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8T63B9s005739;
	Thu, 28 Sep 2006 23:03:11 -0700
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0609281712u2ce01bc5r8f3e97ae9c9a749a@mail.gmail.com>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28090>



On Thu, 28 Sep 2006, Morten Welinder wrote:
>
> Just don't hack at 12am or 12pm.

I think 12pm is correct, but 12am probably isn't (12am should _subtract_ 
12, while 12pm does _not_ add 12).

That said, I have a rice cooker that avoids the problem by saying "0:10 PM" 
for ten minutes past midday ;)

Of course, all sane and civilized countries just use 24-hour format 
anyway. "Military time" my *ss. 

Some day the US will turn metric and 24-hour-format. If the sun doesn't 
turn into a red giant first, that is.

		Linus
