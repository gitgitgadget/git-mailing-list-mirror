From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: export options
Date: Sun, 17 Sep 2006 03:34:03 -0700
Message-ID: <7vodte4w9w.fsf@assigned-by-dhcp.cox.net>
References: <20060916192750.GA27008@moooo.ath.cx>
	<20060916223027.GA32679@moooo.ath.cx>
	<20060916223101.GB32679@moooo.ath.cx>
	<7v64fm7u2q.fsf@assigned-by-dhcp.cox.net>
	<20060917090710.GA18153@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 12:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOtyb-0007dM-AF
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 12:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWIQKeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 06:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWIQKeG
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 06:34:06 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:46740 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964910AbWIQKeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 06:34:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917103403.NPDU6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 06:34:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PNZr1V00B1kojtg0000000
	Sun, 17 Sep 2006 06:33:51 -0400
To: Matthias Lederhofer <matled@gmx.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27182>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Matthias Lederhofer <matled@gmx.net> writes:
>> Is this replacement for your earlier two patches?
> Yes, it is, they did not apply on the current master. (I fetched the
> new heads, had a short look at the log but forgot to update my working
> heads :) ).
>
>>         [PATCH] gitweb: export-ok option
>>         [PATCH] gitweb: option 'strict export'
>> 
>> What's the difference between this and the previous two?
>
> Now I decided to split it in another way: first remove the
> no-such-directory error and then implement the two new features. The
> patches should be equivalent to those before.

I see.

The PATHINFO stuff Martin Waitz did mucks with $project somewhat
later than this part of the patch, possibly bypassing your
checks.  Could you check what's in 'master' to see if it is
reasonable and if not fix it up please?
