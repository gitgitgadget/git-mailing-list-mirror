From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document git-stash
Date: Sun, 01 Jul 2007 14:54:00 -0700
Message-ID: <7vlkdz4wp3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706301853400.4438@racer.site>
	<200707010533.l615XiH6006728@mi1.bluebottle.com>
	<20070701080757.GA6093@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 01 23:54:08 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I57Mt-0004wX-RH
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 23:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbXGAVyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 17:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbXGAVyE
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 17:54:04 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53658 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbXGAVyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 17:54:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701215400.ZXSP1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Jul 2007 17:54:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JMu01X00F1kojtg0000000; Sun, 01 Jul 2007 17:54:01 -0400
In-Reply-To: <20070701080757.GA6093@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 1 Jul 2007 04:07:57 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51325>

Jeff King <peff@peff.net> writes:

>> +(no subcommand)::
>> +
>> +	Save your local modifications to a new 'stash', and run `git-reset
>> +	--hard` to revert them.
>
> For orthogonality's sake, should this be 'git-stash save', aliased to
> just 'git-stash'? It would make this heading a little more intuitive,
> and the very first paragraph (describing all of the modes) a little more
> clear.

I would further suggest that we _require_ 'git stash save' to
create a new one and perhaps make the non-subcommand case run
'git stash list'.  While I was trying the code out I
accidentally created a new stash when I did not mean to, which
pushed the stash I wanted to apply down in the list every time I
made such a mistake.
