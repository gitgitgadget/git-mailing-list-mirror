From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: missing: git api, reference, user manual and mission statement
Date: Tue, 19 Apr 2005 09:51:56 -0400
Message-ID: <42650CFC.1010400@qualitycode.com>
References: <20050419123631.GD3739@xdt04.mpe-garching.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 15:50:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNt5J-0004Aq-C4
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 15:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVDSNwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 09:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVDSNwS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 09:52:18 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:38709 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261525AbVDSNwI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 09:52:08 -0400
Received: from [10.10.10.20] (147-49.35-65.tampabay.res.rr.com [65.35.49.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id BDE023C10;
	Tue, 19 Apr 2005 13:51:59 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
To: Klaus Robert Suetterlin <robert@mpe.mpg.de>
In-Reply-To: <20050419123631.GD3739@xdt04.mpe-garching.mpg.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Klaus Robert Suetterlin wrote:
> 1) There is no clear (e.g. by name) distinction between ``git as done
> by Linus'', which is a kind of content addressable database with added
> semantics, and ``git as done by the rest of You'', which is a kind of
> SCM on top of Linuses stuff.

I also see this as one of the biggest obstacles right now. It would be
very helpful if we could achieve the clear separation between git and
non-git that has been part of the design since the beginning.

Git is very immature, and currently should only be used by brave
pioneers. About the only way for a mortal to even try git is to stick to
git-pasky releases, and not try to track all the patches flying around.


> Linus must have had an idea of the final product, and how to use
> that.  The real day to day workflow.  

The best description I have seen so far is the README for git-pasky:
  http://pasky.or.cz/~pasky/dev/git/

It's not a bad mini-tutorial, really.

> I really believe a lot of questions on the git mailing list could
> be answered if there was a user manual and a reference for git.
> Even before all of it will be implemented.

As you know, documentation is a great way for non-coders to contribute
to a project. Until someone steps up to write it, it won't happen.

In a highly iterative development process like this one, it actually
doesn't make sense to write the docs first. You really don't know how it
should work until you code it, play with it, and then realize it should
be doing something different.


> The list of dependencies is long and growing.  So if the intent of
> doing gitSCM with shell scripts was to make it portable: that goal was missed.

I think the main goal was rapid implementation. I totally expect there
to be one or several wrappers, written in various languages, that will
eventually replace git-pasky.


> Still gitLinus lacks a clear definition of its interface, so I
> guess no one will be able to tell if it works correct.  How could You
> do a test case without knowing
> a) what the software should do and
> b) how You should tell it?

I agree that it would be nice to have automated unit tests.


> And of course there are still memory leaks.  

The code is still young, and these will be fixed. I'm not bothered that
there are leaks at this moment. I am a bit bothered by Linus's attitude
that some small leaks might not ever need to be fixed.

Kevin
