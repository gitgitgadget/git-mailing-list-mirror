From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: whitespace cleanup around '='
Date: Thu, 22 Jun 2006 03:20:57 -0700
Message-ID: <7v64itsd86.fsf@assigned-by-dhcp.cox.net>
References: <20060622023546.28cb4291.froese@gmx.de>
	<11509591773212-git-send-email-jnareb@gmail.com>
	<7vejxhwts4.fsf@assigned-by-dhcp.cox.net> <e7dh1c$61n$1@sea.gmane.org>
	<7vodwlsfek.fsf@assigned-by-dhcp.cox.net> <e7doc6$sg7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 12:21:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtMJ7-0001fq-Hl
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 12:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWFVKVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 06:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWFVKVA
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 06:21:00 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52640 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751779AbWFVKU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 06:20:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622102058.BRWD554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 06:20:58 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e7doc6$sg7$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	22 Jun 2006 11:37:09 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22322>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> I remember discussing things with Timo and was putting it on
>> hold since I knew you were also actively futzing on gitweb.
>
> So when I apply someone else patches should I reply to the post
> with patch I have applied with
>
>   Acked-by: Jakub Narebski <jnareb@gmial.com>
>
> to notify of that fact?

Acked-by does not mean you've applied it to your tree, and even
if it did, it is unfair to expect me to remember that fact when
I review your patch later.  In this particular case, a note in
the patch to say it depends on such and such that _I_ do not
seem to have yet would have been more appropriate.

Acked-by would also be helpful when a de-facto owner of the code
wants to push acceptance of others' patches, but that is
independent from stating what a patch's prerequisites are.

Anyhow, I've reviewed Timo's patch (which made sense to me too),
and your whitespace fixes and pushed out the result, which
hopefully will be propagating to the mirrors soon.  Overall, I
would say that the clean-up on gitweb so far is reasonably
straightforward.  I have been running "next" version of gitweb
on my private machine and haven't found regression.

I'll go to bed now.  Thanks for the patches.
