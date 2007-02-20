From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 20 Feb 2007 00:35:00 -0800
Message-ID: <7v1wklz0p7.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<20070220082020.GA27084@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 09:35:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJQSq-0006An-G2
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 09:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbXBTIfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 03:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbXBTIfE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 03:35:04 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44639 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965301AbXBTIfC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 03:35:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220083500.NGRL27628.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 03:35:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rkb11W0011kojtg0000000; Tue, 20 Feb 2007 03:35:01 -0500
In-Reply-To: <20070220082020.GA27084@localdomain> (Eric Wong's message of
	"Tue, 20 Feb 2007 00:20:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40211>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> * js/diff-2 (Sun Feb 18 12:44:43 2007 +0100) 1 commit
>>  - Add `git diff2`, a GNU diff workalike
>> 
>> Undecided.  Perhaps will merge to 'next' to see if somebody else
>> comes up with a better naming idea.
>
> With this, we can get rid of any test dependency on an external diff
> and have a consistent replacement for cmp[1], as well.
>
> `git gdiff`?  `git xdiff`?  `gdiff` would be easier on the fingers
> (assuming querty), but `xdiff` is probably a more accurate name.

Well, my trouble was that it is anything other than "diff".

An obvious alternative is the same command name (at least
superficially) with an option, such as "diff --fs".  I am not
sure if that is any better than "git {something}diff", though.
