From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to say HEAD~"all the way back - 1"
Date: Sat, 24 Feb 2007 01:30:18 -0800
Message-ID: <7virdrzyvp.fsf@assigned-by-dhcp.cox.net>
References: <17885.60477.53356.123095@lisa.zopyra.com>
	<20070222193625.GA4489@pasky.or.cz> <ern9gn$h4d$1@sea.gmane.org>
	<17887.10938.419368.304761@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Feb 24 10:30:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKtEg-000272-ID
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 10:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933457AbXBXJaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 04:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933458AbXBXJaV
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 04:30:21 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35441 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933457AbXBXJaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 04:30:19 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224093018.YTWG2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Feb 2007 04:30:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TMWJ1W0051kojtg0000000; Sat, 24 Feb 2007 04:30:18 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40508>

Bill Lear <rael@zopyra.com> writes:

> Exactly what I was after.  Something like:
>
> % git diff HEAD~-1
>
> or
>
> % git diff ^HEAD~0
>
> whatever ...

<amusement>

        $ git rev-parse HEAD~4096
        fatal: ambiguous argument 'HEAD~4096': unknown revision or path ...
        $ git rev-parse HEAD~2048
        231af8322...
        $ git rev-parse HEAD~3072
        723c31fea...
        $ git rev-parse HEAD~3584
        ....
        $ git rev-parse HEAD_3952
        e83c5163316f89bfbde7d9ab23ca2e25604af290

</amusement>

If you somehow need to know where the root is all the time, you
could do the above once and say:

	$ git tag root-commit e83c5163316f89bfbde7d9ab23ca2e25604af290
