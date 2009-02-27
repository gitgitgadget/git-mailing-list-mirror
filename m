From: Nicolas Pitre <nico@cam.org>
Subject: Re: [WARNING] Proposed future changes that are backward incompatible
Date: Fri, 27 Feb 2009 14:42:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902271439310.5511@xanadu.home>
References: <20090227192708.6266.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 20:44:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8dA-00056o-I9
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844AbZB0Tm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756793AbZB0Tm3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:42:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32665 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398AbZB0Tm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:42:28 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KFQ007XNPEK32G0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 27 Feb 2009 14:42:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090227192708.6266.qmail@science.horizon.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111701>

On Fri, 27 Feb 2009, George Spelvin wrote:

> There's one more change that was suggested that I'd like to propose:
> - Make "git grep" search the whole repository by default; include an
>   explicit "." path limiter to search only the current directory.

Isn't that already the default?

[nico@xanadu git]$ git grep Alice
Documentation/gittutorial.txt:Suppose that Alice has started a new project with a git repository in
Documentation/gittutorial.txt:This creates a new directory "myrepo" containing a clone of Alice's
Documentation/gittutorial.txt:When he's ready, he tells Alice to pull changes from the repository
Documentation/gittutorial.txt:This merges the changes from Bob's "master" branch into Alice's
Documentation/gittutorial.txt:current branch.  If Alice has made her own changes in the meantime,
Documentation/gittutorial.txt:Note that in general, Alice would want her local changes committed before
Documentation/gittutorial.txt:initiating this "pull".  If Bob's work conflicts with what Alice did since
Documentation/gittutorial.txt:their histories forked, Alice will use her working tree and the index to
Documentation/gittutorial.txt:refuse to merge --- Alice will have to get rid of her local changes in
Documentation/gittutorial.txt:Alice can peek at what Bob did without merging first, using the "fetch"
Documentation/gittutorial.txt:command; this allows Alice to inspect what Bob did, using a special
Documentation/gittutorial.txt:This operation is safe even if Alice has uncommitted local changes.
Documentation/gittutorial.txt:Alice already knows everything that leads to her current state (HEAD),
Documentation/gittutorial.txt:If Alice wants to visualize what Bob did since their histories forked
Documentation/gittutorial.txt:Alice may want to view what both of them did since they forked.
Documentation/gittutorial.txt:After inspecting what Bob did, if there is nothing urgent, Alice may
Documentation/gittutorial.txt:does have something Alice would immediately need, Alice may choose to
Documentation/gittutorial.txt:With this, Alice can perform the first part of the "pull" operation alone using the
Documentation/gittutorial.txt:Unlike the longhand form, when Alice fetches from Bob using a
Documentation/gittutorial.txt:Alice's master branch.
Documentation/gittutorial.txt:After examining those changes, Alice
Documentation/gittutorial.txt:Later, Bob can update his repo with Alice's latest changes using
Documentation/gittutorial.txt:Note that he doesn't need to give the path to Alice's repository;
Documentation/gittutorial.txt:when Bob cloned Alice's repository, git stored the location of her
Documentation/gittutorial.txt:Git also keeps a pristine copy of Alice's master branch under the
t/t5519-push-alternates.sh:	# Project Bob is a fork of project Alice
t/t5519-push-alternates.sh:		# Bob acquires what Alice did in his work tree first.
t/t5519-push-alternates.sh:		# need to send the commit Bob received from Alice
t/t5519-push-alternates.sh:		# to his public repository, as all the object Alice
t/t5519-push-alternates.sh:	# Check that the second commit by Alice is not sent
t/t5519-push-alternates.sh:		# Alice does not care what Bob does.  She does not
t/t5519-push-alternates.sh:		# This time Bob does not pull from Alice, and
t/t5519-push-alternates.sh:		# Alice does not care what Bob does.  She does not
t/t5519-push-alternates.sh:		# This time Bob does not pull from Alice, and
t/t5519-push-alternates.sh:		# necessary tree) in his repository from Alice.


Nicolas
