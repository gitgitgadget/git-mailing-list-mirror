From: Junio C Hamano <junkio@cox.net>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 15:06:25 -0700
Message-ID: <7vhddgnw9q.fsf@assigned-by-dhcp.cox.net>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 00:08:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7gv7-00061u-E2
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 00:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVHWWG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 18:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVHWWG2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 18:06:28 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:11927 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932455AbVHWWG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 18:06:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823220626.NZIS1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 18:06:26 -0400
To: Len Brown <len.brown@intel.com>
In-Reply-To: <1124831571.13042.27.camel@firebird.lenb.worldpath.net> (Len
	Brown's message of "Tue, 23 Aug 2005 17:12:51 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7677>

Len Brown <len.brown@intel.com> writes:

> The merge issue below is reproduced in a "git clone -l" copy
> with no plain files present.

Meaning you did not have any file in the working tree?  It seems
to me that what is happenning is the resolve is trying to merge
the head of your tree and from-linus, but at the same time it
notices that you removed those files from your working tree and
thinks that is what you would want to do.

I could get to 81065e2f415af6... commit (Linus tip at this
moment), so if you can tell me where to snarf the other commit
(702c7e76....) that would help me diagnose the problem a lot.

Thanks.
