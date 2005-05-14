From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH 2/2] update cg-* to use cg-Xignore
Date: Sat, 14 May 2005 15:44:00 +0100
Message-ID: <42860EB0.9000105@dgreaves.com>
References: <E1DWihi-0007DQ-SD@ash.dgreaves.com> <20050513225516.GG32232@pasky.ji.cz> <4285B5CA.8060106@dgreaves.com> <20050514121846.GE3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 16:44:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWxsH-0000u5-Lf
	for gcvg-git@gmane.org; Sat, 14 May 2005 16:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVENOoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 10:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVENOoM
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 10:44:12 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:28116 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262775AbVENOoH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 10:44:07 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 4C0D6E6D9E; Sat, 14 May 2005 15:42:31 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21153-19; Sat, 14 May 2005 15:42:31 +0100 (BST)
Received: from oak.dgreaves.com (modem-4012.lynx.dialup.pol.co.uk [217.135.207.172])
	by mail.ukfsn.org (Postfix) with ESMTP
	id A3C29E6D69; Sat, 14 May 2005 15:42:30 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWxs0-00086R-RM; Sat, 14 May 2005 15:44:00 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514121846.GE3905@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Dear diary, on Sat, May 14, 2005 at 10:24:42AM CEST, I got a letter
>where David Greaves <david@dgreaves.com> told me that...
>  
>
>>Petr Baudis wrote:
>>    
>>
>Makes sense, ok.
>
>What about cg-commit? You already even added it.
>  
>

I'd use the same argument - you want to commit files changed in a directory:
find src | xargs cg-commit
find Documentation | xargs cg-commit

I agree it's less compelling.
I admit I was primarily just making sure that all cg-* commands behaved
the same way.
I also don't have an ignore-override - do you think we need one?

>>No, cogito has an ignore.
>>git has a less powerful exclude.
>>cogito users won't need exclude but power-users aren't barred from it.
>>    
>>
>
>I think having two essentially redundant things is useless. But you'll
>be able to use the --exclude powers now since you have to fall back to
>good ol' globs.
>  
>
unless...

-- 

