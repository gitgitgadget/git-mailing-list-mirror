From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 09:35:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:37:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSFQQ-0007df-OS
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965582AbXCPQgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965571AbXCPQgO
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:36:14 -0400
Received: from smtp.osdl.org ([65.172.181.24]:50658 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965582AbXCPQgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:36:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2GGZrcD028888
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Mar 2007 09:35:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2GGZpvI016447;
	Fri, 16 Mar 2007 08:35:52 -0800
In-Reply-To: <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-0.483 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42377>



On Fri, 16 Mar 2007, Davide Libenzi wrote:
>
> > This one seems to do benchmarking with 8MB buffers if I read it right 
> > (didn't try).
> 
> Yes, I just wanted to have the biggest time spent in inflate(). That why I 
> use a big buffer.

Right. But if the biggest time is spent in setup, the big-buffer thing 
ends up being exactly the wrong thing to test ;)

> Definitely. The nature of the data matters.
> Did you try to make a zlib with my patch and oprofile git on real data 
> with that?

I haven't actually set it up so that I can build against my own zlib yet. 
Exactly because I was hoping that somebody would already have a solution 
;)

Will try to do later today, although since it's the kids school 
conferences today I'll effectively be in and out all day long.

		Linus
