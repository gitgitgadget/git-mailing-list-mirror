From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Wed, 11 May 2005 18:54:02 -0700
Message-ID: <7v4qd9mcp1.fsf@assigned-by-dhcp.cox.net>
References: <1115839456.22180.79.camel@tglx>
	<7vy8alr0mz.fsf@assigned-by-dhcp.cox.net>
	<1115843429.22180.90.camel@tglx>
	<7vis1pqvi4.fsf@assigned-by-dhcp.cox.net>
	<20050511221719.GH22686@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 03:48:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW2na-0005Xb-20
	for gcvg-git@gmane.org; Thu, 12 May 2005 03:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVELByK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 21:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVELByK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 21:54:10 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:23986 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261265AbVELByE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 21:54:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512015401.GHKM12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 21:54:01 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511221719.GH22686@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 12 May 2005 00:17:19 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> it will show the merged revisions properly, but for

PB>      o
PB>      | \
PB>      o  |
PB>     ------
PB>      |  o
PB>      |  o
PB>      o /
PB>      o

PB> it won't show the full merge. Whilst when you do

PB> 	*-log --since foo

PB> I think you mean it to show everything going into the tree since foo -
PB> that would include the whole branch you cut off now.

I use "rev-tree HEAD ^$(git-merge-base HEAD foo)" for this
kind of thing, so rev-list does not really matter.

>> --- a/checkout-cache.c
>> +++ b/checkout-cache.c
PB> I assume this is irrelevant here?

Sorry for sending a dirty patch in.  Will fix it up.


