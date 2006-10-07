From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Sat, 07 Oct 2006 15:34:17 -0700
Message-ID: <7vmz87pxg6.fsf@assigned-by-dhcp.cox.net>
References: <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 00:34:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWKkQ-0003fC-FT
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 00:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877AbWJGWeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 18:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932878AbWJGWeT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 18:34:19 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17549 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932877AbWJGWeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 18:34:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007223418.JAQN2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 18:34:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XaaL1V00K1kojtg0000000
	Sat, 07 Oct 2006 18:34:21 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Sat, 7 Oct 2006 11:44:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28515>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Petr Baudis <pasky@suse.cz> wrote:
>> Signed-off-by: Petr Baudis <pasky@suse.cz>
>> ---
>
> First, this is a Unixism, and would confuse other OS users.
> Second, "/" is after all _not part of the name_ of the tree/directory,
> but part of the filesystem's path separator, let's not export it
> to users of other OS's.
> Third, directories/trees are already clearly 
>   1) underlined, and
>   2) differently colored,
> which makes it overly obvious what it what.

I was actually hoping that we can get rid of the differences you
cited above.

Underlines make entries harder to read, and colouring is 
distracting; some people do not see all colours and to them it
may not distracting but then they need another way to notice the
differences between tree/blob.
