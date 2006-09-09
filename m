From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] git-archive: wire up TAR format.
Date: Fri, 08 Sep 2006 18:53:42 -0700
Message-ID: <7vk64derfd.fsf@assigned-by-dhcp.cox.net>
References: <450019C3.4030001@innova-card.com>
	<11576347252834-git-send-email-vagabon.xyz@gmail.com>
	<4501D0CF.70306@lsrfire.ath.cx>
	<7vlkouf32i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 03:53:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLs2C-0003W3-Vq
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 03:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWIIBxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 21:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWIIBxS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 21:53:18 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:17613 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751324AbWIIBxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 21:53:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060909015315.FKPO18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Sep 2006 21:53:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L1tG1V0051kojtg0000000
	Fri, 08 Sep 2006 21:53:16 -0400
To: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26730>

Junio C Hamano <junkio@cox.net> writes:

> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> I did not sign off this exact patch.  I wrote and submitted the
>> builtin-tar-tree.c part, with memory leak and all, then sent a note
>> on where the leak needs to be plugged.  You put it together and
>> converted it to struct archiver_args.  I'd very much have liked to
>> see a comment stating this.  Or simply just say "based on code by
>> Rene" or something.  The same is true for patch 3/4.
>>...
>> Especially I would not have signed off this invisible comment. ;)
>
> I take your response is a mild NAK.

Just to reduce everybody's pain, why don't I fix them up and
push out the 4 series in "pu" with attribution clarification and
review comments from Rene in mind, so that you two can Ack them?
After that they will be placed on "next".

I needed to apply small tweaks on 1/4 (ANSI-C pedantic did not
like empty struct initializers) and 4/4 (the updated 1/1 needed
the way struct archiver is initialized and used be different
from the original one) as well.
