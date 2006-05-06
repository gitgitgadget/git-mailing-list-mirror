From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] binary patch.
Date: Sat, 06 May 2006 00:40:22 -0700
Message-ID: <7vwtcztxcp.fsf@assigned-by-dhcp.cox.net>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
	<7vwtd10xyd.fsf@assigned-by-dhcp.cox.net>
	<7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 06 09:40:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcHOw-0007hb-VF
	for gcvg-git@gmane.org; Sat, 06 May 2006 09:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWEFHkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 03:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWEFHkX
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 03:40:23 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30973 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751282AbWEFHkX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 03:40:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060506074022.VEEA25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 03:40:22 -0400
To: git@vger.kernel.org
In-Reply-To: <7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 05 May 2006 03:15:53 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19653>

Junio C Hamano <junkio@cox.net> writes:

>> Yeah, things still to be done are deflating both delta and
>> optionally perhaps use just deflate without delta for "new file"
>> codepath.
>>
>> And testsuite.
>
> -- >8 --
> [PATCH] binary diff: further updates.
>...
> Signed-off-by: Junio C Hamano <junkio@cox.net>
>
> ---
>
>  * Have done only very minimum testing, and unlike somebody else ;-)
>    my code is not always perfect, so this will still stay out of
>    "next" for a while.

OK, now it passes the testsuite I wrote, so I'll push this out
in "next".  I was not drunk while doing the testsuite so the
code now must be perfect ;-).
