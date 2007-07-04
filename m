From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Document git-filter-branch
Date: Wed, 4 Jul 2007 13:29:01 +0200
Message-ID: <20070704112900.GO12721@planck.djpig.de>
References: <Pine.LNX.4.64.0707031746400.4071@racer.site> <20070703220540.GN12721@planck.djpig.de> <Pine.LNX.4.64.0707040004200.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 13:29:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I632o-0005yk-ET
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 13:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338AbXGDL3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 07:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756171AbXGDL3L
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 07:29:11 -0400
Received: from planck.djpig.de ([85.10.192.180]:2821 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964AbXGDL3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 07:29:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id F0AAE88102;
	Wed,  4 Jul 2007 13:29:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CM+DgGzib9KQ; Wed,  4 Jul 2007 13:29:01 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 4961888105; Wed,  4 Jul 2007 13:29:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707040004200.4071@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51595>

On Wed, Jul 04, 2007 at 12:17:05AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> [if you comment on just a small portion of the text, could you please 
> quote only that? Thank you]
> 
> On Wed, 4 Jul 2007, Frank Lichtenheld wrote:
> 
> > General note: All the stuff in all uppercase should probably also
> > have some asciidoc emphasis.
> 
> I do not understand. I grepped through all the docs for uppercase words 
> emphasized in any way, and could not find one.

True. On the other hand it is used at least in the case of WARNING as
a means of emphasis and this should be reflected in the end result
as markup. So I still suggest changing it to *WARNING* or even
*Warning* if you don't want to double the emphasis.

> > On Tue, Jul 03, 2007 at 05:47:44PM +0100, Johannes Schindelin wrote:
> > > +the id of the commit being rewritten.  The author/committer environment
> > > +variables are set before the first filter is run.
> > 
> > Maybe give the actual names of the environment variables here?
> 
> If you think so:
> 
> 	Also, GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, 
> 	GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE is 
> 	set according to the current commit.

"are" set. And yeah, it doesn't look pretty. I still prefer having the
list somewhere in the text, though.

> > > +	Only regard the history, as seen by the given subdirectory. The
> >                               ^^^
> > Does this comma belong there?
> 
> This is my bad English. What I meant was this:
> 
>         Only ever look at the history, which touches the given 
> 	subdirectory.  The result will contain that directory as its 
> 	project root.

I'm still not sure there should be a comma in this sentence, but my
English grammar is a bit rusty.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
