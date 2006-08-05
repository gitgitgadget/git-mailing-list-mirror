From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] gitweb: No periods for error messages
Date: Sat, 05 Aug 2006 00:03:17 -0700
Message-ID: <7vwt9nekay.fsf@assigned-by-dhcp.cox.net>
References: <7vpsfgghi2.fsf@assigned-by-dhcp.cox.net>
	<20060805010307.17651.qmail@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 05 09:03:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9GC9-0008FW-UK
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 09:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161592AbWHEHDT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 03:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161590AbWHEHDT
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 03:03:19 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:22262 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161592AbWHEHDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 03:03:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805070318.ILFN6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 03:03:18 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20060805010307.17651.qmail@web31807.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 4 Aug 2006 18:03:07 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24891>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>
>> I tend to prefer ending each sentence with a full stop.
>
> I've never seen this in, among other things,
>   - kernel messages
>   - errno messages
>   - web server messages
>   - RFC text describing error messages, (web services),
>   - etc.

Comparing

	git grep \( -e die --or -e die \) --and -e '\."' -- '*.c'

and

	git grep \( -e die --or -e die \) --and --not -e '\."' -- '*.c'

tells me that we omit periods, mostly.

> I was going for was consistency.  I'd say apply Jacob's [6/5].

Well, [6/5] is on top of [1/5] which had the problem of
parroting unsanitized user input, so I'd rather use a clean
patch that does only this error message cleanups.
