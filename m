From: Paul Mackerras <paulus@samba.org>
Subject: Re: New features in gitk
Date: Sun, 28 Oct 2007 18:11:34 +1100
Message-ID: <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:11:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im2JQ-0003ZO-F6
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbXJ1HLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbXJ1HLo
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:11:44 -0400
Received: from ozlabs.org ([203.10.76.45]:41383 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbXJ1HLn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:11:43 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B82EBDDF44; Sun, 28 Oct 2007 18:11:42 +1100 (EST)
In-Reply-To: <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62526>

Linus Torvalds writes:

> However, that crazy green bar chasing back-and-forth int he "reading" 
> phase is really quite visually distracting. Maybe it looks better in 
> Tk8.5, but it does look pretty annoying in the version I have. Can you 
> tone that down a bit? 

Yeah.  Actually what I'd like is to know how many commits git log is
going to give me, so that I can do a normal progress bar whose length
is proportional to commits_read / total_commits.  With --topo-order
(or --date-order) it has to get to the last commit before it outputs
the first commit, doesn't it?  So could it print the total number of
commits on a line by itself at the start of its output?  (Presumably
it would need a --commit-count flag to enable that behaviour.)

Other than that, I could slow the progress bar down, or do a bar of
moving diagonal stripes, or something.

Paul.
