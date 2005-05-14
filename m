From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Ignore file filter
Date: Sat, 14 May 2005 09:28:24 +0100
Message-ID: <4285B6A8.4080309@dgreaves.com>
References: <4283CAF8.3050304@dgreaves.com> <20050513231229.GI32232@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 10:29:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWs0g-0007It-L6
	for gcvg-git@gmane.org; Sat, 14 May 2005 10:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVENI2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 04:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVENI2e
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 04:28:34 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:35747 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262492AbVENI22 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 04:28:28 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id A5F3BE6D4F; Sat, 14 May 2005 09:26:56 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03092-02; Sat, 14 May 2005 09:26:56 +0100 (BST)
Received: from oak.dgreaves.com (modem-2954.leopard.dialup.pol.co.uk [217.135.155.138])
	by mail.ukfsn.org (Postfix) with ESMTP
	id F081CE6A8B; Sat, 14 May 2005 09:26:55 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWs0W-0007dy-P9; Sat, 14 May 2005 09:28:24 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513231229.GI32232@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Dear diary, on Thu, May 12, 2005 at 11:30:32PM CEST, I got a letter
>where David Greaves <david@dgreaves.com> told me that...
>  
>
>># This doesn't allow the -h which is the [ arg for symlinks...
>>    
>>
>
>But so is -L. And I'd just use -l...
>  
>
OK

>>#. ${COGITO_LIB}cg-Xlib
>>_git=${GIT_DIR:-.git}
>>    
>>
>
>...but it makes no sense anyway I think to reinclude this stuff from a
>cg-Xfile you are including from other scripts anyway.
>  
>
cg-Xignore isn't included - only called.
it's also just a library program.
Also I don't think cg-Xlib should be doing arg handling.
As an include it should provide an arg handling function that the
scripts call.

>>	    if [[ $file =~ $patt ]]; then
>>    
>>
>
>I'm sorry but this is really nothing my bash-2.05.0(1)-release supports.
>We're already bash-only, but further reducing that to bash3 really won't
>work. I *might* get convinced to add some bash2+-only feature, but only
>if you'll be really good at explaining that it makes sense.
>  
>
Ah
OK
I don't know how to do that.
I was actually aiming for glob matching when I came upon this in the
manpage.
I just thought it was bash and didn't think to check what version it was
introduced with.

>Besides, I'd prefer just the shell globs in the ignore file, as it is
>done in the rest of the world, and in all the real-world scenarios I've
>seen, the globs were powerful enough.
>
>Also, how does this interact with git-ls-files --exclude and
>.git/exclude? We would have two ignoring mechanisms...
>
>  
>
because one was cogito's and one was git's.
Cogitos was supposed to have a more powerful, pattern based abroach.

David

-- 

