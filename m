From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Fri, 6 Nov 2009 17:35:46 +0000 (UTC)
Message-ID: <loom.20091106T180313-750@post.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 18:36:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6SjY-0000P3-IY
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 18:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606AbZKFRgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 12:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756983AbZKFRgM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 12:36:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:59225 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756223AbZKFRgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 12:36:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N6SjK-0000Gu-Uf
	for git@vger.kernel.org; Fri, 06 Nov 2009 18:36:10 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 18:36:10 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 18:36:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132313>

> > Here is the wish list for the VCS I would prefer:
> > 1. Atomit commits
> > 2. The possibility to get any slice of the code repository with the 
possibility
> > to commit my changes on tip or on separate branch.
> > 3. The minimum footprint of the same code on my local machine.
> > 4. No code/history on my machine untill I really need it.
> > 5. Easy mirroring and replication
> >
> > I would say, ClearCase might be my favorite if it is not commercial. 
> 
> #1 and #5 are features of any DVCS, so git already has them.  #2, 3,
> and 4 are all just saying the same thing:

No, #2 is about the repository slicing, branching, merging (SCM in other words). 
Let's suppose I have the product that have 2 directories: component1 and 
component2. They were developing together for  previous product (on the same 
branch, for example). Now, I would like to have component1 and replace 
component2 with some 3rd party component. What should I do with Git to get this? 
Or maybe I wish to stick with some version of component2 and provide only bug 
fixes for this product...
Or let's take a look at GDB. They are using binutils which are in separate 
repository (they use CVS, but let's imagine they use Git). How many effors they 
will need for SCM? For example, they would prefer to stick to some stable 
version/branch of the binutils but should be able to commit bug fixes.

Once again, perhaps there is some way to do this with Git? I did not yet find 
it.

> "I can't afford the disk
> space to store the entire repo."  Are you sure this is true, or is it
> a preconception?  Even a 1GB repository is tiny by modern disk
> standards.

oh, yes, since we have big drives and fast internet, we do not have to worry 
about space and download time... :-)

> My (limited) experience with ClearCase is that it's so slow that you'd
> do *anything* to track fewer files in your working copy, so they put a
> lot of work into exactly that, and no work into performance.

This probably true. Thought I did not have a lot of problems with it unless I 
use GUI.

>  This
> lousy performance isn't the case in git (except in Windows).  Are you
> using Windows, by chance?

yes. I did not yet noticed any performance problems with Git on windows, except 
a sync/download time (for android, mostly)
