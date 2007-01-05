From: Junio C Hamano <junkio@cox.net>
Subject: Re: New way of tracking remote branches -- question
Date: Fri, 05 Jan 2007 15:39:00 -0800
Message-ID: <7vmz4xcacr.fsf@assigned-by-dhcp.cox.net>
References: <776323.21089.qm@web31808.mail.mud.yahoo.com>
	<7vzm8xcbcp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 00:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2yeU-00028R-OQ
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbXAEXjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbXAEXjE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:39:04 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:43429 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbXAEXjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:39:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105233901.UXRO18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 18:39:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7beC1W00m1kojtg0000000; Fri, 05 Jan 2007 18:38:12 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <7vzm8xcbcp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 05 Jan 2007 15:17:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36049>

Junio C Hamano <junkio@cox.net> writes:

> Luben Tuikov <ltuikov@yahoo.com> writes:
>
>> I can see that the remote heads are where they are supposed to be
>> but no local tracking heads are created (by default).  I had
>> to do this manually.
>>
>> Old behavior was that git did that for you automatically.
>> So I suppose this is another newbie protection.
>
> A very fuzzily stated question which is hard to answer, but I do
> not think it is another newbie protection, if it apparently is
> actively hurting you.  Also the documentation may need to be
> updated to teach you enough about how to achieve what you want.

Can you state the problem you observed about the recent git in a
way that is easier to debug?

For example, you could state:

	With older git (I verified that v1.3.0 still works like
	this), I used to be able to just say:

		$ git fetch

	(this is the exact command line -- I am not giving a URL
	nor even "origin" after "git fetch").  When the upstream
	created a new branch 'blah', the above command created a
	new local branch 'blah' automatically for me.  With the
	tip of 'master' (e27e609), this does not happen anymore.

	My configuration is that I have .git/remotes/origin file
	whose contents is ....  I do not have any remote.*.url,
	remote.*.fetch, nor branch.*.remote configuration variables.

to be more helpful.

I am not dismissing your message as whining.  You probably have
hit a regression while we adopted the BCP to encourage separate
remote layout, and I would like to understand the issue.
