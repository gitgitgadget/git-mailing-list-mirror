From: Junio C Hamano <junkio@cox.net>
Subject: Re: activestate perl: Makemaker generates broken Makefiles.
Date: Thu, 05 Oct 2006 21:57:46 -0700
Message-ID: <7viriy2g8l.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0610040425j60d0647dk1489d02657379c13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Oct 06 06:58:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVhmW-0007Wz-2p
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 06:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWJFE5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 00:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWJFE5x
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 00:57:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:4065 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750996AbWJFE5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 00:57:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061006045751.NHXV6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Fri, 6 Oct 2006 00:57:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wsxu1V00A1kojtg0000000
	Fri, 06 Oct 2006 00:57:54 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0610040425j60d0647dk1489d02657379c13@mail.gmail.com>
	(Alex Riesen's message of "Wed, 4 Oct 2006 13:25:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28385>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Just a heads up. Makefile.PL can't be used. The attached patch removes
> everything perl (sorry, but it'd help someone to get going).

Since we do not have Git.xs anymore, wouldn't it be possible for
us to remove perl/Makefile.PL and have our own perl/Makefile
which does:

 * install Git.pm to $(prefix)/share/git-core/perl (aka GIT_PERL_DIR)

 * see if Error.pm is available on the system, and if not install
   private-Error.pm as Error.pm

to make everybody happy???
