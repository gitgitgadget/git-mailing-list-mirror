From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Tue, 30 Jan 2007 02:57:10 -0800
Message-ID: <7vlkjkzss9.fsf@assigned-by-dhcp.cox.net>
References: <45BDABB5.4070301@fs.ei.tum.de>
	<86zm82dpql.fsf@blue.stonehenge.com>
	<dbfc82860701290438y4e00cc05s5f8c8acdc8022768@mail.gmail.com>
	<86fy9udmf6.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nikolai Weibull" <now@bitwi.se>,
	"Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue Jan 30 12:07:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBqft-0003aW-0x
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 11:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbXA3K5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 05:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbXA3K5N
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 05:57:13 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60595 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbXA3K5M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 05:57:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130105711.NGIX18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jan 2007 05:57:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HNxW1W00f1kojtg0000000; Tue, 30 Jan 2007 05:57:31 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38152>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Nikolai" == Nikolai Weibull <now@bitwi.se> writes:
>
> Nikolai> We do require a POSIX-compliant version of sh already, right?
>
> OK, sorry for raising the flag.  I just know that writing portable shell
> is far trickier than writing portable Perl, so I get overly cautious
> on anything that wasn't in Unix V7.

You seem to be as old fashioned as I am (I grew up with V7
shell).  People complained often enough how antiquated my shell
script (hence many but not all git Porcelain-ish) style is.

I have tried very hard to reject "Hey, it's in POSIX -- we'll
use it and screw platforms that are not exactly POSIX".  I only
use POSIX as a yardstick to decide what to stay away from, as in
"Let's not use ${parameter//pattern/string} -- it is not _even_
in POSIX".
