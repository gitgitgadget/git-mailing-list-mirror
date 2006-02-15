From: Junio C Hamano <junkio@cox.net>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 16:34:31 -0800
Message-ID: <7vpslppii0.fsf@assigned-by-dhcp.cox.net>
References: <43F20532.5000609@iaglans.de>
	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
	<87fymlvgzv.wl%cworth@cworth.org>
	<200602142230.11442.Josef.Weidendorfer@gmx.de>
	<7v7j7xr54u.fsf@assigned-by-dhcp.cox.net> <43F26129.4040804@op5.se>
	<Pine.LNX.4.63.0602150022470.24570@wbgn013.biozentrum.uni-wuerzburg.de>
	<43F270F5.7070804@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 01:34:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Acw-0001LZ-Cc
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 01:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422898AbWBOAef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 19:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422899AbWBOAef
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 19:34:35 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33683 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422898AbWBOAee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 19:34:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215003302.PMGJ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 19:33:02 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43F270F5.7070804@op5.se> (Andreas Ericsson's message of "Wed, 15
	Feb 2006 01:08:21 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16196>

Andreas Ericsson <ae@op5.se> writes:

> Heh. You're right. :) Didn't grok that from the man-page. I'm so used
> to seeing <commit-ish> everywhere that when it says "<branch> can be
> any object that refers to a commit" I get confused.

You are right; the documentation is wrong.  It says

'git-checkout' [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]

It should have said something like:

git-checkout [ -f | -m ] <branch>    		or
git-checkout [-b <new_branch>] <committish>	or
git-checkout [<committish> | -- ] <paths>...

The first form is to switch to a branch (with flag to say what
to do when conflict can lose local modification); the second
form is to create a new branch out of comittish and switch to
it; and the third is not switching branches but just checking
out named paths out of index or arbitrary comittish (I think any
ent should do but I have not verified it).
