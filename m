From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pulling peer's branch and getting tracking branch created
Date: Mon, 26 Feb 2007 17:06:11 -0800
Message-ID: <7v3b4sl88s.fsf@assigned-by-dhcp.cox.net>
References: <17891.32095.655545.637691@lisa.zopyra.com>
	<7v7iu4l8k0.fsf@assigned-by-dhcp.cox.net>
	<17891.33709.278100.35712@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 02:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLqnH-0006WN-T4
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 02:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbXB0BGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 20:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbXB0BGN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 20:06:13 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33476 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030545AbXB0BGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 20:06:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227010612.SDFO3767.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 26 Feb 2007 20:06:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UR6C1W00H1kojtg0000000; Mon, 26 Feb 2007 20:06:12 -0500
In-Reply-To: <17891.33709.278100.35712@lisa.zopyra.com> (Bill Lear's message
	of "Mon, 26 Feb 2007 19:04:45 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40684>

Bill Lear <rael@zopyra.com> writes:

> On Monday, February 26, 2007 at 16:59:27 (-0800) Junio C Hamano writes:
>>Bill Lear <rael@zopyra.com> writes:
>>
>>> I can't seem to figure out the correct magic to get my buddy's branch,
>>> and create the appropriate tracking branch at the same time without
>>> doing a clone.
>>
>>I'll cheat and ask "git show b6f5da1e" ;-).
>>
>>	$ git remote add -f -m master bob ../bob.git/
>>
>>which should add:
>>
>>	[remote "bob"]
>>        	url = ../bob.git/
>>		fetch = +refs/heads/*:refs/remotes/bob/*
>>
>>to .git/config, and perform the initial "git fetch bob" so that
>>bob's heads appear under your .git/refs/remotes/bob/*, iow,
>>after this, you can ask:
>>
>>	$ git branch -r
>>	  bob/HEAD
>>          bob/master
>>          bob/topic-1
>>          bob/topic-2
>
> Ok, and then:
>
> % git checkout -b topic-1 bob/topic-1
>
> Gets me onto a topic branch ...
>
> So, this does do what I've asked, and more: however, how can I get it
> to do only the one branch that I want and not all of the others?  If
> this part is really annoyingly hard and/or stupid, don't hesitate to
> say so.

This time, I'll cheat and ask you to ask "git show b6f5da1e"
;-).
