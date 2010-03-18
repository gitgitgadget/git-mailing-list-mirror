From: tytso@mit.edu
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 16:44:16 -0400
Message-ID: <20100318204416.GM8256@thunk.org>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
 <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
 <4ba27424.9804cc0a.4b1f.11b1@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 21:44:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsMaE-0000SF-F3
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 21:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab0CRUol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 16:44:41 -0400
Received: from thunk.org ([69.25.196.29]:57644 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab0CRUok (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 16:44:40 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1NsMZn-0000XC-EZ; Thu, 18 Mar 2010 16:44:19 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1NsMZk-0006GY-Ve; Thu, 18 Mar 2010 16:44:16 -0400
Content-Disposition: inline
In-Reply-To: <4ba27424.9804cc0a.4b1f.11b1@mx.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142517>

On Thu, Mar 18, 2010 at 11:42:44AM -0700, Michael Witten wrote:
> Could people still bungle the uuid or enter trash?
> Sure, but that's essentially no different than the
> current situation. This would be an improvement,
> because at least some people would take advantage
> of it; in fact, I bet most people would use it
> properly because:
> 
>     * The information required is easily remembered
>       and reproduced; it has that emotional aspect.
> 
>     * People have an emotional attachment to getting
>       proper attribution for their work, and this
>       helps.

The problem is that people don't get emotionally attached to a UUID.
And even if the UUID is generated algorithmically, they need to
remember, gee, was my UUID generated using:

	Theodore Y. Ts'o <tytso@mit.edu>
	Theodore Tso <tytso@mit.edu>
	Theodore T'so <tytso@valinux.com>  (*) 
	Theodore Y Tso <theotso@us.ibm.com
	Ted Tso <tytso@google.com>
	Theodore Tso <tytso@google.com>
	<etc.>

(*) The VA Linux folks screwed up where the apostrophe goes in some
press release, and the mispelling of my last name has followed me for
the last ten years since then.

More importantly, there's a lot more to someone's reputation than just
Git.  What about reviews of other people's patches on LKML?  Can you
**honestly** expect people to say,

   Hi, I'm <dd1b51a1-ce2a-41fd-ae89-f68b7f0ace85> and here are the things
   that you need to fix with your patch....

People who give thoughtful reviews of other people's code count for a
lot, and people are not going to track that sort of thing by UUID.
They are going to track it by name and e-mail address.

Or what about papers?  Can you honestly expect that it would matter
even one iota if someone put in a bibliography of a paper

R. Card (14a8da4b-0231-497b-aa66-1809cc9727f9), T. Y. Ts'o
(dd1b51a1-ce2a-41fd-ae89-f68b7f0ace85), and S. Tweedie
(9052e458-32cc-11df-93b8-0016eb0fac40), "Design and implementation of
the second extended filesystem," in Proceedings of the 1994 Amsterdam
Linux Conference, 1994.

Is that going to contribute to my identity any?   I don't think so.


Finally, if someone misses one of my commits in a git changelog, so
what?  People don't guage impact by the number of commits.  There are
some people who have huge numbers commits, but they are all spelling
corrections.  A developer's reputation is developed over many months
or years of contributions; of interactions over e-mail; interactions
in hallway discussions at conferences; papers which they author; etc.
It's not just about git commits.

   	      	 	       	  	   	  - Ted
