From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git diff --summary --diff-filter=AD" without --stat does not work.
Date: Tue, 03 Oct 2006 13:36:41 -0700
Message-ID: <7vejtpm90m.fsf@assigned-by-dhcp.cox.net>
References: <7v3ba5tdlj.fsf@dee.twinsun.com>
	<Pine.LNX.4.63.0610032221330.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 22:37:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUr0R-00053n-1n
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWJCUgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWJCUgn
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:36:43 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:17147 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030361AbWJCUgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 16:36:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003203642.UMFZ26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 16:36:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vwcb1V00m1kojtg0000000
	Tue, 03 Oct 2006 16:36:36 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610032221330.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 3 Oct 2006 22:23:02 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28302>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I think it should only show create/delete notes and not even
>> diff text.
>
> What exactly is the problem? My tree only has minor patches, which should 
> not affect the output of your command, and it does this:
>
> $ git diff --summary --diff-filter=AD next..pu
>  create mode 100644 builtin-diff-status.c
>  create mode 100644 para-walk.c
>  create mode 100644 para-walk.h
>  create mode 100644 test-para.c

I suspect the real issue is that it does not turn 'recursive'
on.
