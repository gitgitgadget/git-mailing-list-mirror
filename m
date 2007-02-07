From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 07 Feb 2007 14:56:47 -0800
Message-ID: <7vd54l60gg.fsf@assigned-by-dhcp.cox.net>
References: <17866.20355.744025.133326@lisa.zopyra.com>
	<Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvid-0000c2-RR
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161474AbXBGW4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161475AbXBGW4t
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:56:49 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63739 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161474AbXBGW4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:56:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207225649.OTNI1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 17:56:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lmwn1W00b1kojtg0000000; Wed, 07 Feb 2007 17:56:48 -0500
In-Reply-To: <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 7 Feb 2007 14:49:50 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38989>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 7 Feb 2007, Bill Lear wrote:
>> 
>> I thought that it would be very useful to have a history of git
>> commands that have been run against a repo, in order to hopefully
>> debug this sort of thing --- perhaps only those that modify the repo.
>
> The "reflog" is kind of that, and you can literally do
>
> 	less .git/logs/refs/heads/master
>
> to get some kind of idea what's up.
>
> Newer gits enable reflogs by default, older gits don't (and *really* old 
> git versions don't support it at all).
>
> Of course, we should probably just have a
>
> 	git reflog show
>
> command for this to make it prettier.

	$ git log -g?
