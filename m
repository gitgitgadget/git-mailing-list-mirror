From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Update bash completion to ignore some more plumbing commands
Date: Tue, 22 May 2007 23:06:24 +0200
Message-ID: <20070522210624.GA7518@diku.dk>
References: <20070519213521.GA32221@diku.dk> <20070521061228.GJ3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 22 23:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqbYu-00022H-Ds
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163AbXEVVG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757137AbXEVVG2
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:06:28 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:39850 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756044AbXEVVG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:06:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 08AF39680AF;
	Tue, 22 May 2007 23:06:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YAScmBZ8az4T; Tue, 22 May 2007 23:06:24 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 9AB109680AC;
	Tue, 22 May 2007 23:06:24 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 0C5476DF823; Tue, 22 May 2007 23:04:35 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7CB9F62A5D; Tue, 22 May 2007 23:06:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070521061228.GJ3141@spearce.org>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48115>

Shawn O. Pearce <spearce@spearce.org> wrote Mon, May 21, 2007:
> Jonas Fonseca <fonseca@diku.dk> wrote:
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> > ---
> >  contrib/completion/git-completion.bash |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> OK, sorry this missed 1.5.2.  I've applied it into my fastimport
> master branch, I guess it will be in the next 1.5.2 based release.
> ;-)

Good! :) I didn't know, it was maintained in the fastimport branch. You
might consider mentioning it in the header of the file.

> >  I am not sure if it is OK to exclude checkout-index as it is
> >  the only method of exporting the source as a directory. Also,
> 
> It might make sense to exclude checkout-index as plumbing, but I
> use it myself so often (and tab complete it too) that I want to
> keep it in.  So I deleted that one line out of your patch when I
> applied it.

Very well.

> >  I don't understand why git-diff-* is not excluded.
> 
> Because I personally also use git diff-tree a lot.  The others
> (diff-files, diff-index) I *never* use directly so I'm thinking
> maybe they should get flagged as plumbing and get removed from
> the completion.

OK.

-- 
Jonas Fonseca
