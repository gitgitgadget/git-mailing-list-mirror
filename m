From: Junio C Hamano <junkio@cox.net>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 16:36:39 -0700
Message-ID: <7v8xj72a9k.fsf@assigned-by-dhcp.cox.net>
References: <200610221548.42048.andyparkins@gmail.com>
	<Pine.LNX.4.64.0610221017180.3962@g5.osdl.org>
	<200610222117.45766.andyparkins@gmail.com>
	<Pine.LNX.4.64.0610221331571.3962@g5.osdl.org>
	<ehgoii$1ap$1@sea.gmane.org>
	<Pine.LNX.4.63.0610230008490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<ehgrj9$8u9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 01:36:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbms1-00064i-A2
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 01:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWJVXgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 19:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWJVXgl
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 19:36:41 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63403 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750759AbWJVXgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 19:36:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061022233640.ECEI12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Oct 2006 19:36:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dbcj1V00N1kojtg0000000
	Sun, 22 Oct 2006 19:36:44 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ehgrj9$8u9$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	23 Oct 2006 00:33:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29806>

Jakub Narebski <jnareb@gmail.com> writes:

> Johannes Schindelin wrote:
>
>> On Sun, 22 Oct 2006, Jakub Narebski wrote:
>> 
>>> BTW. what does "recursive diff" mean (in git)?
>> 
>> AFAIU it means that the diff code recurses into subdirectories.
>
> When git-diff _doesn't_ recurse into subdirectories?

When it is not told to.

The Porcelainish commands (git-diff, git-show) default to
recursive, but low-level commands don't.

Compare these three:

	git diff --raw v1.4.3.1^^^..v1.4.3.1^^
	git diff-tree v1.4.3.1^^^..v1.4.3.1^^
	git diff-tree -r v1.4.3.1^^^..v1.4.3.1^^
