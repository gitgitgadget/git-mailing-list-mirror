From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Distinguish branches by more than case in tests.
Date: Fri, 06 Apr 2007 14:47:38 -0700
Message-ID: <7v7ispjhtx.fsf@assigned-by-dhcp.cox.net>
References: <20070406054204.GA13108@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwHt-00053N-Rj
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933075AbXDFVrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933165AbXDFVrk
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:47:40 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42528 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075AbXDFVrj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:47:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070406214739.IJFY24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 17:47:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id jxne1W0071kojtg0000000; Fri, 06 Apr 2007 17:47:38 -0400
In-Reply-To: <20070406054204.GA13108@Hermes.local> (Brian Gernhardt's message
	of "Fri, 6 Apr 2007 01:42:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43922>

Brian Gernhardt <benji@silverinsanity.com> writes:

> The renaming without config test changed a branch from q to Q, which
> fails on non-case sensitive file systems.  Change the test to use q
> and q2.
> ---
>
> Notably, HFS+ is not case sensitive.  IIRC there are others.  This isn't
> a flaw of git, just a bad choice of branch names for certain systems.

Sigh.

I always wonder why people pay money to buy case insensitive
filesystems (MacOS is not free, is it?).

More mysterious is that there apparently are peole who are paid
to produce such systems (Apple has paid employees to work on
MacOS, doesn't it?).

The worst of all this is that I have to be careful not to break
things on such a system, and take a patch like this (admittedly,
you did the real fixing, so that is less work for me, but
still...).

And puzzlingly enough, I am not paid to do this ;-).

Thanks for the patch.  Will apply.
