From: Junio C Hamano <junkio@cox.net>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 16:15:17 -0700
Message-ID: <7v4pva2g6y.fsf@assigned-by-dhcp.cox.net>
References: <20060914142249.GK23891@pasky.or.cz>
	<Pine.LNX.4.64.0609140824580.4388@g5.osdl.org>
	<Pine.LNX.4.64.0609141714010.2627@xanadu.home>
	<1158269854.5724.240.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609141742000.2627@xanadu.home>
	<1158270859.5724.244.camel@localhost.localdomain>
	<1158272651.5724.251.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 01:15:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO0QV-0005he-LS
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 01:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWINXPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 19:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWINXPU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 19:15:20 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:55225 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932107AbWINXPS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 19:15:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914231517.GCOA22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 19:15:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NPF61V0091kojtg0000000
	Thu, 14 Sep 2006 19:15:06 -0400
To: tglx@linutronix.de
In-Reply-To: <1158272651.5724.251.camel@localhost.localdomain> (Thomas
	Gleixner's message of "Fri, 15 Sep 2006 00:24:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27052>

Thomas Gleixner <tglx@linutronix.de> writes:

>> [tglx@hera history.git]$ git --version
>> git version 1.4.2.1
>
> I know I'm stupid
>
> "git-repack --window=50 --depth=50 -a -f" works
> "git-repack -a -f --window=50 --depth=50" does not
>
> Intuitive user interfaces are my favorite pitfalls.

Whaaaat?

I've run them under "sh -x" and both results in a pipe of:

	git-rev-list --objects --all |
        git-pack-objects --non-empty --no-reuse-delta --window=50 --depth=50 \
	.git/.tmp-<somepid>-pack

Now you are making me really worried.
