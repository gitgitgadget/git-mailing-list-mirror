From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Thu, 27 Oct 2005 22:38:33 -0400
Message-ID: <20051028023833.GA19939@pe.Belkin>
References: <20051027203945.GC1622@pe.Belkin> <20051028015642.GA31822@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 04:39:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVK8c-000728-QO
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVJ1Cif (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVJ1Cif
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:38:35 -0400
Received: from eastrmmtao06.cox.net ([68.230.240.33]:7613 "EHLO
	eastrmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965058AbVJ1Cif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:38:35 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051028023748.XIGR21663.eastrmmtao06.cox.net@localhost>;
          Thu, 27 Oct 2005 22:37:48 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVK8Y-0005Lg-0J; Thu, 27 Oct 2005 22:38:34 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20051028015642.GA31822@vrfy.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10739>

On Fri, Oct 28, 2005 at 03:56:42AM +0200, Kay Sievers wrote:
> On Thu, Oct 27, 2005 at 04:39:45PM -0400, Chris Shoemaker wrote:
> > 
> > I really like gitweb (thanks Kay!), but I thought it would be nice to
> > have a visual indication of patch size.  I found this helpful when
> > scanning though the shortlogs.
> 
> This looks nice, but if the patch size tells you something important,
> your commit subjects are probably too short or wrong. :)

Yeah, some people write lousy commit subjects.  But me?  Nooo,
/never/.  :)

> You may try to use CSS instead of an embedded picture to draw the bar,
> just like the RSS logo in the footer, which is simple CSS rendered in the
> browser.

I'll look into that, but the cost wasn't in the image; it was in the
width calculation.

Here's a side-by-side comparison.  Open two browser tabs and flip between them:

http://www.codesifter.com/cgi-bin/gitweb-difftreeP.cgi?p=git.git;a=shortlog
http://www.codesifter.com/cgi-bin/gitweb-difftreeNames.cgi?p=git.git;a=shortlog

I've used a project you all are familar with, and that has more than
two files.  The first page uses 'git-diff-tree -p $hash|wc -l'.  The
second page uses 'git-diff-tree -r --name-only|wc -l'.  (Oh and I have
a merge indicator now.)

How do they compare for showing damage-potential?  I think they both
do a reasonable job.  I think the full patch diff is a bit better, but
it does cost.

-chris
