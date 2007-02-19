From: Junio C Hamano <junkio@cox.net>
Subject: Re: Where/how to create tracking branches?
Date: Mon, 19 Feb 2007 11:43:36 -0800
Message-ID: <7vy7mu6ihj.fsf@assigned-by-dhcp.cox.net>
References: <17881.54325.475907.468492@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 20:43:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJEQK-000637-Q7
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 20:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbXBSTni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 14:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbXBSTni
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 14:43:38 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39148 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583AbXBSTnh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 14:43:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219194337.IIIA21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 14:43:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RXjc1W00Q1kojtg0000000; Mon, 19 Feb 2007 14:43:37 -0500
In-Reply-To: <17881.54325.475907.468492@lisa.zopyra.com> (Bill Lear's message
	of "Mon, 19 Feb 2007 10:45:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40139>

Bill Lear <rael@zopyra.com> writes:

> What is the recommended way to create tracking branches in my private
> repo if I first create the corresponding topic branch in my private
> repo and want to publish it via a public repo?
>
> Scenario:
>
> [my private repo]
> % git checkout -b topic
> [work, work, work, commit]
> % git push /public/repo/project topic:topic

So at this point the public shared repository has refs/heads/topic
branch you and colleagues can work on together.  So I am puzzled
about this part...

> Do I have to create the topic branch in my public repo first?  This
> seems crazy,...

because you did do so and I do not think it is crazy.

Maybe you meant "do I create tracking branch for 'topic' in public?",
in which case the answer is no.

> I tried this:
>
> % git pull /public/repo/project topic:origin/topic
>
> But it created a topic branch named "origin/topic" instead of a tracking
> branch.

Assuming your clone was initially made from /public/repo/project,
doesn't "git fetch" without _any_ parameter work?

	$ git fetch
