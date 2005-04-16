From: Ingo Molnar <mingo@elte.hu>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 21:18:10 +0200
Message-ID: <20050416191810.GA27748@elte.hu>
References: <20050416131528.GB19908@elte.hu> <20050416133513.GA21678@elte.hu> <42612771.5000705@cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:15:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsl4-0006o5-AM
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVDPTSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVDPTSv
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:18:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59615 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262735AbVDPTSs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 15:18:48 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id C93D131CBA5;
	Sat, 16 Apr 2005 21:17:35 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 8EEC61FC2; Sat, 16 Apr 2005 21:18:13 +0200 (CEST)
To: David Mansfield <david@cobite.com>
Content-Disposition: inline
In-Reply-To: <42612771.5000705@cobite.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* David Mansfield <david@cobite.com> wrote:

> Ingo Molnar wrote:
> >* Ingo Molnar <mingo@elte.hu> wrote:
> >
> >
> >>the patches contain all the existing metadata, dates, log messages and 
> >>revision history. (What i think is missing is the BK tree merge 
> >>information, but i'm not sure we want/need to convert them to GIT.)
> >
> >
> >author names are abbreviated, e.g. 'viro' instead of 
> >viro@parcelfarce.linux.theplanet.co.uk, and no committer information is 
> >included (albeit commiter ought to be Linus in most cases). These are 
> >limitations of the BK->CVS gateway i think.
> >
> 
> Glad to hear cvsps made it through!  I'm curious what the manual 
> fixups required were, except for the binary file issue (logo.gif).

--cvs-direct was needed to speed it up from 'several days to finish' to 
'several hours to finish', but it crashed on a handful of patches [i 
used the latest devel snapshot so this isnt a complaint]. (one of the 
crashes was when generating 1860.patch.) Also, 'cvs rdiff' apparently 
emits an empty patch for diffs that remove a file that end without 
having a newline character - but this isnt cvsps's problem.  (grep for 
+++ in the patchset to find those cases.)

> As to the actual email addresses, for more recent patches, the 
> Signed-off should help.  For earlier ones, isn't their some script 
> which 'knows' a bunch of canonical author->email mappings? (the 
> shortlog script or something)?

yeah, that's not that much of a problem, most of the names are unique, 
and the rest can be fixed up too.

> Is the full committer email address actually in the changeset in BK?  
> If so, given that we have the unique id (immutable I believe) of the 
> changset, could it be extracted directly from BK?

i think it's included in BK.

	Ingo
