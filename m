From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Ignore file filter
Date: Sat, 14 May 2005 15:28:07 +0100
Message-ID: <42860AF7.3060208@dgreaves.com>
References: <4283CAF8.3050304@dgreaves.com> <20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com> <20050514122134.GF3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 16:28:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWxd5-00082g-1h
	for gcvg-git@gmane.org; Sat, 14 May 2005 16:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVENO23 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 10:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVENO22
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 10:28:28 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:723 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262771AbVENO2U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 10:28:20 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 97C3BE6D69; Sat, 14 May 2005 15:26:46 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20101-15; Sat, 14 May 2005 15:26:46 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.207.172])
	by mail.ukfsn.org (Postfix) with ESMTP
	id E4E68E6A8B; Sat, 14 May 2005 15:26:45 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWxce-00085p-2q; Sat, 14 May 2005 15:28:08 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514122134.GF3905@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Dear diary, on Sat, May 14, 2005 at 10:28:24AM CEST, I got a letter
>where David Greaves <david@dgreaves.com> told me that...
>  
>
>>Also I don't think cg-Xlib should be doing arg handling.
>>As an include it should provide an arg handling function that the
>>scripts call.
>>    
>>
>
>I'd prefer the few and scattered users which don't want arg handling to
>explicitly set some magic variable before calling cg-Xlib rather than
>adding the arg parser function call everywhere else.
>  
>
OK

>>>>	    if [[ $file =~ $patt ]]; then
>>>>        
>>>>
>>>I'm sorry but this is really nothing my bash-2.05.0(1)-release supports.
>>>We're already bash-only, but further reducing that to bash3 really won't
>>>work. I *might* get convinced to add some bash2+-only feature, but only
>>>if you'll be really good at explaining that it makes sense.
>>>      
>>>
>>OK
>>I don't know how to do that.
>>I was actually aiming for glob matching when I came upon this in the
>>manpage.
>>    
>>
>Ok, so what's the outcome? Are you going to stop at this point, or will
>you change the scripts so that they use the glob list?
>  
>
Well, Junio solved that for me - I'll gather the comments and resubmit.

David

-- 

