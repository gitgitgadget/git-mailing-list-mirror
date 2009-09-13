From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Effectively tracing project contributions with git
Date: Sun, 13 Sep 2009 16:30:10 +0200
Message-ID: <4AAD01F2.5010803@webdrake.net>
References: <4AAB9459.3070809@webdrake.net> <20090912185940.GA21277@coredump.intra.peff.net> <fabb9a1e0909121203r527bc81ctd68382fc1107bf06@mail.gmail.com> <4AAC3889.6030908@webdrake.net> <20090913022843.GB26588@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 13 16:30:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmq67-0006Tp-UF
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 16:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbZIMOaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 10:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754158AbZIMOaK
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 10:30:10 -0400
Received: from up.nbi.dk ([130.225.212.6]:42479 "EHLO mail2.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132AbZIMOaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 10:30:09 -0400
Received: from [192.168.0.4] (zux221-207-155.adsl.green.ch [81.221.207.155])
	by mail2.nbi.dk (Postfix) with ESMTP id 0746B3C93F;
	Sun, 13 Sep 2009 16:30:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20090913022843.GB26588@mit.edu>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128364>

Theodore Tso wrote:
> This will display all of the diffs on file (pathname) XXX by contributor YYY:
> 
> 	git log -p --author=YYY XXX 
> 
> You might also find the diffstats useful:
> 
> 	git log --stat --author=YYY XXX
> 
> Or if you want *only* the diffstats for the file in question, you might try:
> 
> 	git log --stat --pretty=format: --author=YYY XXX | grep XXX

That's absolutely brilliant -- using these commands makes my task much
easier.

As for reasons -- there are several.  For the FOSS project, here is a
potential relicensing issue (guarding against future problems rather
than addressing present ones) and indeed I'm going about it the way you
suggest -- getting consent from as many contributors as possible.
Despite that, it seems useful to have up-to-date file-by-file credits
and copyright notices.

Personally, there's also a degree of curiosity and wanting to learn some
of the more complex and advanced possibilities of git -- and also
basically wanting to see to what extent this task is possible.  How
fine-grained a degree of credit/blame can I extract for a given piece of
code?  And how far back in history? etc.

Finally, there's an aspect which has nothing to do with code but could
still be very interesting for some people in the git community.  I've
long been fascinated by DVCS as a collaborative tool and over the last
year have been part of the Liquid Publications project:
http://project.liquidpub.org/

... that is trying to develop new models for scientific collaboration
and publishing/sharing of results and ideas.  One of my interests is to
see whether DVCS can be harnessed to enable better and more open
collaboration and micro-credit for scientific contributions.

We've already set up a project on Launchpad to try to turn one of our
project reports into a review paper via open collaboration:
https://code.launchpad.net/~webdrake/liquidpub/peer-review

... and I'll shortly be setting up a GitHub branch for another,
from-scratch article directly on DVCS and their potential applications
(the use of different VCS is deliberate: one thing I'll be doing is
testing different VCS and their different features).  This is something
I'd very much like to have git (and bzr, and hg) community members
involved in.

I was going to write to the git community about this at a later date
once I'd got more stuff prepared, but since the present discussion could
generate useful material for that it seems only fair to be open.

The FOSS project stuff has nothing to do with that, but I certainly see
it as a good experience to feed the LiquidPub research.

Thanks for the useful advice and best wishes,

    -- Joe
