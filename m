From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cygwin playbook?
Date: Wed, 06 Sep 2006 23:59:22 -0700
Message-ID: <7v7j0g40xh.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90609062159v3858a771t38355ed60867ccfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 08:59:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLDr2-0000iy-2W
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 08:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWIGG7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 02:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWIGG7N
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 02:59:13 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5517 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750851AbWIGG7L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 02:59:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907065911.FTTI6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 02:59:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KJz31V00C1kojtg0000000
	Thu, 07 Sep 2006 02:59:03 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90609062159v3858a771t38355ed60867ccfc@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 7 Sep 2006 16:59:22 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26605>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> - What cygwin packages are needed?

I am not in front of Windows machine so I need to check later if
nobody beats me to this, but essentially it is the same as on
sane Unix systems.  Cygwin folks did a good job providing
necessary libraries readily available from their Setup.exe.

> - Need to fudge makefile?

No; not even autoconf was needed and it installed out of the box
for me (w2k).

> - How do I install for personal use?

make install would install under whereever you call ~/bin in
Cygwin environment, and that is how I have mine.

> - How do I install in /usr/local?

I do not think of a reason why "make prefix=/usr/local" would
not work but I haven't tried it myself so don't quote me on
this.

> - Anything else I should know?

You would probably have great pain if on vfat.  It appears to
work Ok on NTFS.  It appears to be quite slow, judging from
the way it runs our standard test suite.
