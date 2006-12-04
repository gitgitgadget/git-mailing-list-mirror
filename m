X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT 2] Branching and merging with git
Date: Sun, 3 Dec 2006 20:19:58 -0500
Message-ID: <20061204011958.GB28043@fieldses.org>
References: <7vslghftix.fsf@assigned-by-dhcp.cox.net> <20061120235136.4841.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 01:20:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061120235136.4841.qmail@science.horizon.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33157>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr2V7-0001lr-2B for gcvg-git@gmane.org; Mon, 04 Dec
 2006 02:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760193AbWLDBUB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 20:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760192AbWLDBUA
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 20:20:00 -0500
Received: from mail.fieldses.org ([66.93.2.214]:65470 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1760193AbWLDBUA
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 20:20:00 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gr2Uw-0006Es-Tq; Sun, 03 Dec 2006
 20:19:58 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

On Mon, Nov 20, 2006 at 06:51:36PM -0500, linux@horizon.com wrote:
> I tried to incorporate all the suggestions.  There are still a few things
> I have to research, and now I'm worried it's getting too long.  Sigh.

If you made another pass for it asking whether each sentence was really
absolutely necessary you'd be able to cut quite a bit without
compromising on content.  One example:

> In CVS, branches are difficult and awkward to use, and generally
> considered an advanced technique.  Many people use CVS for a long time
> without departing from the trunk.

Lots of people have CVS experience, but not everyone does, and this
paragraph isn't really necessary.  Cut it out, and the following
paragraph (minus first sentence) stands just fine on its own:

> Git is very different.  Branching and merging are central to effective use
> of git, and if you aren't comfortable with them, you won't be comfortable
> with git.  In particular, they are required to share work with other
> people.

Note also "if you aren't comfortable with them..." just repeats
something you've already said.  So now we're down to just:

	"Branching and merging are central to effective use of git.  In
	particular, they are required to share work with other people."

which is short and to the point.  Neat!

I'm not sure of the ordering.  For example:

> The only things that are a bit confusing are some of the names.
> In particular, at least when beginning:
> - You create new branches with "git checkout -b".
>   "git branch" should only be used to list and delete branches.
> - You share work with "git fetch" and "git push".  These are opposites.
> - You merge with "git pull", not "git merge".  "git pull" can also do a
>   "git fetch", but that's optional.  What's not optional is the merge.
>
> Also, a good habit it to never commit directly to your main "master"
> branch.  Do all work in temporary "topic" branches, and then merge them
> into the master.  Most experienced users don't bother to be quite this
> purist, but you should err on the side of using separate topic branches,
> so it's excellent practice.

We're diving in here without explaining what checkout, fetch, push,
pull, or merge are yet, or what the master branch is.

The document seems to be targetted at someone who has read some
scattered git documentation, gotten confused, and needs help putting it
all together.  This is understandable--there are a lot of people like
that right now!  But if we're going to get the documentation in some
sort of sensible order then we need to think about how to start with
someone who is a blank slate and lead them step by step to what they
most need to know.

That doesn't mean *you* need to do everything from scratch, but it would
be helpful to figure out where this would fit in with the other
documentation in a logical progression.  As a start, the first paragraph
could say "before reading this, we assume you've read X, Y, and Z", and
then the rest of the document could be audited to make sure that it
didn't assume anything that isn't in X, Y, and Z.

