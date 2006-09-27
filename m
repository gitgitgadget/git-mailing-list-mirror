From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Removed memory leaks from interpolation table uses.
Date: Wed, 27 Sep 2006 12:42:52 -0700
Message-ID: <7vven99jur.fsf@assigned-by-dhcp.cox.net>
References: <E1GSc4w-0005cu-I3@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 21:43:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSfJ3-0006UX-UA
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 21:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030717AbWI0Tmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 15:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030718AbWI0Tmy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 15:42:54 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16618 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030717AbWI0Tmx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 15:42:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927194253.FKBK18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 15:42:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TXiv1V00K1kojtg0000000
	Wed, 27 Sep 2006 15:42:55 -0400
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1GSc4w-0005cu-I3@jdl.com> (Jon Loeliger's message of "Wed, 27
	Sep 2006 11:16:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27925>

Jon Loeliger <jdl@jdl.com> writes:

> Junio,
>
> This is on top of my previous cleanup [PATCH Rev 3].

Thanks.

> BTW, In that previous patch of mine, this line:
>
>         -	and %D for the absolute path of the named repository.	
>
> has trailing blanks in my patch that must be removed in order
> to apply it correctly to the HEAD of git.  The _previous_ patch
> clearly was (correctly) applied with --whitepace=strip!

Yes, I usually use --whitespace=strip.  The only time I
deliberately had to turn it off was to apply patches to diff
output test vectors.

Hopefully the recent addition to "diff --color" output to highlight
these potential whitespace errors would help spot them before
making commits.
