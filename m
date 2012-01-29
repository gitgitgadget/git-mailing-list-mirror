From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree
Date: Sun, 29 Jan 2012 16:07:59 -0600
Message-ID: <87aa56kvr4.fsf@smith.obbligato.org>
References: <nngaa638nwf.fsf@transit.us.cray.com>
	<CALkWK0nU9iO_6CCbWw8c_Fz=xodkaAW4300Jpc7M7D+kBP=QRg@mail.gmail.com>
	<87ipkq199w.fsf@smith.obbligato.org>
	<20120105154740.GA11475@sigill.intra.peff.net>
	<87zke2yv27.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Greene <dag@cray.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 30 07:40:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrkv8-000292-F2
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 07:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab2A3Gku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 01:40:50 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8]:52300 "EHLO
	smith.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751694Ab2A3Gkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 01:40:49 -0500
X-Greylist: delayed 5397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jan 2012 01:40:49 EST
Received: from greened by smith.obbligato.org with local (Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1Rrcul-0005Wa-OW; Sun, 29 Jan 2012 16:07:59 -0600
In-Reply-To: <87zke2yv27.fsf@smith.obbligato.org> (David A. Greene's message
	of "Thu, 05 Jan 2012 10:26:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189325>

greened@obbligato.org (David A. Greene) writes:

>> I'd favor keeping the history and doing the munge-overlay thing.
>
> Ok, that sounds fine to me.  I'll do that in a private branch.  What
> should I send as patches to the mailing list?  I'm assuming we don't
> want [PATCH 235/12342], etc. sent to the list chronicling the entire
> history.  :)
>
>> Although part of me wants to join the histories in a subtree so that we
>> can use "git subtree" to do it (which would just be cool),
>
> Heh.  I thought about that too.  :)

I actually did end up doing a subtree merge via git subtree.  It was
more convenient to put it in contrib/ like that as almost everthing
there is in its own subdirectory.

I'm cleaning things up there to remove redundancy, rewrite tests (using
earlier work), etc.  What number should I use for git-subtree tests?
Here are some logical candidates:

        5 - the pull and exporting commands
        6 - the revision tree commands (even e.g. merge-base)
        7 - the porcelainish commands concerning the working tree
        9 - the git tools

git-subtree can pull and export.  It also affects revision trees (it
merges, for example) and is a porcelainish command that affects the
working tree.  It is also a "git tool" of a sort.

I originally put them under t97XX but now that is taken, as is
everything up to and including t99XX.

Anyone have a strong opinion?

Thanks!

                           -Dave
