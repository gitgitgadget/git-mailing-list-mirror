From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 8 May 2007 23:18:04 -0400
Message-ID: <20070509031803.GA27980@fieldses.org>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 05:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlcgw-0006Le-Hv
	for gcvg-git@gmane.org; Wed, 09 May 2007 05:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031642AbXEIDSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 23:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbXEIDSJ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 23:18:09 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48782 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbXEIDSI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 23:18:08 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Hlcgm-000359-2u; Tue, 08 May 2007 23:18:04 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705081709230.4167@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46653>

On Tue, May 08, 2007 at 05:10:47PM +0200, Johannes Schindelin wrote:
> 
> In http://thread.gmane.org/gmane.comp.version-control.git/42479,
> a birdview on the source code was requested.
> 
> J. Bruce Fields suggested that my reply should be included in the
> user manual, and there was nothing of an outcry, so here it is,
> not even 2 months later.

Looks helpful, concise, and to the point.  Neat-o.

Acked-by: J. Bruce Fields <bfields@citi.umich.edu>

Comments, nothing major:

> +If you grasp the ideas in that initial commit (it is really small and you 
> +can get into it really fast, and it will help you recognize things in the 
> +much larger code base we have now), you should go on skimming `cache.h`, 
> +`object.h` and `commit.h`.

Might want to add "in a recent commit"?--it's not clear that you've
transitioned away from talking about the initial commit.

> +This is just to get you into the groove for the most libified part of Git: 
> +the revision walker.

Unless the reader has already been hanging out on the mailing list a
while, "most libified" may not mean much to them yet at this point.

The organization of the next bit is slightly confusing: we're set up to
expect a longer lecture on the revision walker, but instead there's just
the historical note on git-rev-list, a mention of 'revision.c',
'revision.h', and 'struct rev_info', and then it rapidly digresses into
discussing builtins.

Which actually is fine, but just a few small markers of where we are in
the discussion might be reassuring--a section header or two, maybe a
little more emphasis on the pointers you're giving, like: "take a moment
to go read revision.h and revision.c now, paying special attention to
struct rev_info, which ....".

--b.
