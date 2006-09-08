From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] git-archive: wire up TAR format.
Date: Fri, 08 Sep 2006 14:42:13 -0700
Message-ID: <7vlkouf32i.fsf@assigned-by-dhcp.cox.net>
References: <450019C3.4030001@innova-card.com>
	<11576347252834-git-send-email-vagabon.xyz@gmail.com>
	<4501D0CF.70306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 08 23:42:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLo6h-0000CW-KE
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 23:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWIHVls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 17:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWIHVls
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 17:41:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42957 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751193AbWIHVlr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 17:41:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908214147.CANP6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Sep 2006 17:41:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Kxhn1V00o1kojtg0000000
	Fri, 08 Sep 2006 17:41:48 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26718>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I did not sign off this exact patch.  I wrote and submitted the
> builtin-tar-tree.c part, with memory leak and all, then sent a note
> on where the leak needs to be plugged.  You put it together and
> converted it to struct archiver_args.  I'd very much have liked to
> see a comment stating this.  Or simply just say "based on code by
> Rene" or something.  The same is true for patch 3/4.
>...

Thanks for clarification -- I also was wondering if you two were
working as a team exchanging drafts and the message I saw was
the fruit of such collaboration (like the way Johannes/Alex team
worked on C rewrite of merge-recursive).  Otherwise the sign-off
was indeed inappropriate.

>> +/*
>> + *
>> + */
>
> Especially I would not have signed off this invisible comment. ;)

I take your response is a mild NAK.
