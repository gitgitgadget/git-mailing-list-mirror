From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/11] Misc. pull/merge/am improvements
Date: Fri, 29 Dec 2006 09:53:59 -0800
Message-ID: <7vtzzeoafc.fsf@assigned-by-dhcp.cox.net>
References: <20061228073441.GB17304@spearce.org>
	<7vmz58whnx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612291845070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 18:54:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0Lvi-0003P8-Vc
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 18:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWL2RyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 12:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWL2RyD
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 12:54:03 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:44881 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965071AbWL2RyB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 12:54:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229175400.VJNZ19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Dec 2006 12:54:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4htE1W00r1kojtg0000000; Fri, 29 Dec 2006 12:53:15 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612291845070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 29 Dec 2006 18:46:02 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35597>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 28 Dec 2006, Junio C Hamano wrote:
>
>> Although I do find the detached HEAD attractive [...]
>
> You do mean "git fetch --depth 0", don't you? (Totally untested, of 
> course.)

No, what I meant was

	$ git checkout v1.5.0
	Checking out a tag -- you are not on any branch now...
        $ ls -l .git/HEAD
        -rw-rw-r-- 1 junio junio 41 2006-12-29 09:51 .git/HEAD
	$ git branch
          master
        $ git commit -m 'fix' -a; echo $?
        You cannot commit without the current branch.
        0
        $ git checkout -b maint-1.5.0
        $ git commit -m 'fix' -a
