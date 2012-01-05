From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree
Date: Thu, 05 Jan 2012 16:16:53 -0600
Message-ID: <8762gpyeui.fsf@smith.obbligato.org>
References: <nngaa638nwf.fsf@transit.us.cray.com>
	<CALkWK0nU9iO_6CCbWw8c_Fz=xodkaAW4300Jpc7M7D+kBP=QRg@mail.gmail.com>
	<87ipkq199w.fsf@smith.obbligato.org>
	<20120105154740.GA11475@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Greene <dag@cray.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 05 23:25:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rivk4-000280-7S
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 23:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835Ab2AEWYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 17:24:52 -0500
Received: from dsl001-154-008.msp1.dsl.speakeasy.net ([72.1.154.8]:45713 "EHLO
	smith.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932516Ab2AEWY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 17:24:26 -0500
Received: from greened by smith.obbligato.org with local (Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RivcD-0000tw-AD; Thu, 05 Jan 2012 16:16:53 -0600
In-Reply-To: <20120105154740.GA11475@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 Jan 2012 10:47:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188006>

Jeff King <peff@peff.net> writes:

> I think this is also somewhat different in that git-subtree has a
> multi-year history in git that we may want to keep. So it is more

I agree there may be some value in preserving this history.

> The biggest decision is whether or not to import the existing history.

I agree.  I will leave that decision to the more experienced git
developers.  I'm happy to work either way.

> If we want to throw away the existing history, then I think you end up
> doing the same munging as the latter option above, and then just make a
> single patch out of it instead of a merge.

Right.  That's the approach I've taken for now but it's easy to switch.
There aren't that many changes.

> I don't use git-subtree, but just glancing over the repo, it looks like
> that munging is mostly:
>
>   1. git-subtree.sh stays, and gets added to git.git's top-level Makefile

Done.

>   2. the test.sh script gets adapted into t/tXXXX-subtree.sh

Done.

>   3. git-subtree.txt goes into Documentation/

Done.

>   4. The rest of the files are infrastructure that can go away, as they
>      are a subset of what git.git already contains.

Done.

I have a patch that does all of the above but it is one monolithic blob.
Like I said, the changes aren't extensive so it's easy for me to change
strategies.

> I'd favor keeping the history and doing the munge-overlay thing.

Ok, that sounds fine to me.  I'll do that in a private branch.  What
should I send as patches to the mailing list?  I'm assuming we don't
want [PATCH 235/12342], etc. sent to the list chronicling the entire
history.  :)

> Although part of me wants to join the histories in a subtree so that we
> can use "git subtree" to do it (which would just be cool),

Heh.  I thought about that too.  :)

> I think the resulting code layout doesn't make much sense unless
> git-subtree is going to be maintained separately.

Yeah, I agree.

                                -Dave
