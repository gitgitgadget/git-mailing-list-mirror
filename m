X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Change in git-svn dcommit semantics?
Date: Tue, 19 Dec 2006 19:38:58 -0500
Message-ID: <C2881A17-27F7-467C-B353-189BB7DBFD1E@silverinsanity.com>
References: <m2mz5jegka.fsf@ziti.local> <94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com> <Pine.LNX.4.63.0612200053550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 00:39:19 +0000 (UTC)
Cc: Seth Falcon <sethfalcon@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612200053550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34873>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpUD-0003aA-2i for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753905AbWLTAjE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbWLTAjD
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:39:03 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:57106 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932669AbWLTAjA (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 19:39:00 -0500
Received: from [192.168.1.6] (cpe-66-67-221-135.rochester.res.rr.com
 [66.67.221.135]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by silverinsanity.com (Postfix) with ESMTP id
 5AEC21FFC02B; Wed, 20 Dec 2006 00:39:00 +0000 (UTC)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org


On Dec 19, 2006, at 6:57 PM, Johannes Schindelin wrote:

>> Mine also has a few variables like "COLLISION_CHECK=paranoid" and  
>> my own
>> prefix.
>
> Just to wake sleeping tigers: have you done a "grep COLLISION_CHECK *"
> recently (where recently means any date after May 3rd, 2005)?

Oh, well, that's cute.  It's a configuration option that doesn't  
touch any code at all...  Not that I really cared about the check, I  
just thought it was a nice paranoid thing to activate and I like a  
certain amount of paranoia in my SCMs.  But maybe the description  
should be removed from the Makefile then?  Or better yet, collision  
checking could be put back in?

And is there an easier way to find these things than "git rev-list  
HEAD | git diff-tree -r -s --stdin -SCOLLISION | xargs git show"?  I  
cobbled that together from poking around inside gitk (which mostly  
works in OS X, but has some issues that make me prefer the command  
line).

