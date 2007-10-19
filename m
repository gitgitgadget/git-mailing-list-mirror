From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Subversion developer: svn is for dumb people
Date: Fri, 19 Oct 2007 13:10:15 +0100
Message-ID: <ffa6r7$223$1@ger.gmane.org>
References: <47176CE0.7030609@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 14:50:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IirJP-0007YW-4m
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 14:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762473AbXJSMuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 08:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763460AbXJSMuJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 08:50:09 -0400
Received: from main.gmane.org ([80.91.229.2]:51453 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758369AbXJSMuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 08:50:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IirIg-0007fI-CE
	for git@vger.kernel.org; Fri, 19 Oct 2007 12:50:02 +0000
Received: from 194.70.53.227 ([194.70.53.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 12:50:02 +0000
Received: from andyparkins by 194.70.53.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 12:50:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.227
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61698>

Steven Grimm wrote:

> find code reviews *harder* in a centralized system because you end up

I think I'd argue that git actually reduces the problems of patchbombs
(which is a code-review problem).

Those who are going to patchbomb will do it whatever their VCS choice (and
I'm not entirely convinced that patchbombs are as bad as is made out in
that article).  With a centralised VCS the patch almost has to be one giant
diff - very hard to read and review.  Git, on the other hand, allows the
patchbomber to work alone crafting not only beautiful code, but a beautiful
patch series.  The bomb can be easy to review, easy to reject, and easy to
modify.  It becomes far more likely that the code can be used in some way.

I guarantee that the only reason I ever contributed anything to git itself
was because the bureaucracy line is so low - and it is low because of git.

Key features for a DVCS from a newbie point of view:
 - Making a fool of yourself can be done in private rather than in public.
   I have loads of branches in my git repository that I will never submit,
   because they were the beginnings of ideas that didn't pan out (and I'm 
   lazy)
 - You don't need _any_ permission to fork/branch.
 - You can work away on your feature without worrying too much that time
   has passed and the main project has moved on and you aren't keeping up
   to date.  I've got a set of patches for git (the REF_PATHS stuff) that I
   started a year ago.  I recently rebased it and brought it up to date.
   It's still not in mainline, but I'm not panicking, nor do I have to
   abandon it because it's so easy to catch up whenever I want to.
 - I can work on two features simultaneously.  If I have two ideas - crazy
   and safe, both independent, I can work on both without having to mix
   them for the day when I submit.  This makes it a lot easier to keep them
   on the go, and a lot easier for the maintainer to decide what goes in and
   what doesn't.
 - The ability to craft a log messages that are kept locally and easily
   edited before submission goes a long way to helping cross the
   brave-enough-to-submit barrier.  Presenting new code as an unknown
   developer on a project is (I think) quite a stressful thing.  Git let's
   you feel as prepared as you want before you take that leap into having
   your code ripped apart.

In short: those pro-centralised arguments are nonsense.  Even if they
weren't the advantages of DVCS heavily outweigh the advantages of CVCS.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
