From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 06:21:06 +1000
Message-ID: <4262C532.4070203@zytor.com>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 22:21:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNGFy-0007rx-Ke
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVDQUYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVDQUWu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:22:50 -0400
Received: from terminus.zytor.com ([209.128.68.124]:14465 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261517AbVDQUV1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 16:21:27 -0400
Received: from [172.18.240.151] ([203.53.50.91])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3HKL9vS032269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 17 Apr 2005 13:21:15 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> Ok, nobody really objected to the notion of leaving the kernel history
> behind for now, and in fact most people seemed to basically agree. So with
> that decided, the old kernel testing tree was actually perfectly ok,
> except it had been build up with the old-style commit date handling, which
> made me not want to use it as a base for any real work.
> 
> So I re-created the dang thing (hey, it takes just a few minutes), and
> pushed it out, and there's now an archive on kernel.org in my public
> "personal" directory called "linux-2.6.git". I'll continue the tradition
> of naming git-archive directories as "*.git", since that really ends up
> being the ".git" directory for the checked-out thing.
> 
> I'm not going to announce it on linux-kernel yet, because I don't think
> it's useful to anybody but a git person anyway. Besides, I don't actually
> know how happy the kernel.org people are about this distribution method
> and whether it ends up being a horrible disaster for the mirroring setup. 
> 
> Peter made some noises about /pub/scm, which makes sense, and would be a
> better place than my public tree. Apparently there are other places that
> are willing and able to host things too, so we'll see.
> 

I would suggest something like /pub/scm/kernel/git/<people> on 
kernel.org.  This is easy to do, and being outside the "mirrored 
worldwide" set shouldn't cause anyone any issues.

/pub/linux/... is mirrored worldwide and that might cause some 
consternation.

If this is OK with everyone I'll try to set them up (I'm at LCA at the 
moment, so I might have limited connectivity at any one particular 
moment in time.)

	-hpa
