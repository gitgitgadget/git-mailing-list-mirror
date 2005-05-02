From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 02 May 2005 11:49:32 -0400
Message-ID: <42764C0C.8030604@tmr.com>
References: <20050429203959.GC21897@waste.org><20050429203959.GC21897@waste.org> <20050430025211.GP17379@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 17:50:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSdBg-00023Q-FM
	for gcvg-git@gmane.org; Mon, 02 May 2005 17:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVEBP4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 11:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVEBP4I
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 11:56:08 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:15754 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261347AbVEBPzc
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 11:55:32 -0400
Received: from [127.0.0.1] (oddball.prodigy.com [127.0.0.1])
	by oddball.prodigy.com (8.11.6/8.11.6) with ESMTP id j42FtGp29772;
	Mon, 2 May 2005 11:55:20 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
To: Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20050430025211.GP17379@opteron.random>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Andrea Arcangeli wrote:
> On Fri, Apr 29, 2005 at 01:39:59PM -0700, Matt Mackall wrote:
> 
>>Mercurial is ammenable to rsync provided you devote a read-only
>>repository to it on the client side. In other words, you rsync from
>>kernel.org/mercurial/linus to local/linus and then you merge from
>>local/linus to your own branch. Mercurial's hashing hierarchy is
>>similar to git's (and Monotone's), so you can sign a single hash of
>>the tree as well.
> 
> 
> Ok fine. It's also interesting how you already enabled partial transfers
> through http.
> 
> Please apply this patch so it doesn't fail on my setup ;)
> 
> --- mercurial-0.4b/hg.~1~	2005-04-29 02:52:52.000000000 +0200
> +++ mercurial-0.4b/hg	2005-04-30 00:53:02.000000000 +0200
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python
>  #
>  # mercurial - a minimal scalable distributed SCM
>  # v0.4b "oedipa maas"

Could you explain why this is necessary or desirable? I looked at what 
env does, and I am missing the point of duplicating bash normal 
behaviour regarding definition of per-process environment entries.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

