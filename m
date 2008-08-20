From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: git-cvsimport - losing changes in subsequent pulls of a CVS branch that I thought I wasn't modifying in the GIT repo.
Date: Wed, 20 Aug 2008 09:52:34 +0200
Message-ID: <20080820075234.GF4047@smurf.noris.de>
References: <48AA6F8E.70807@bluelane.com> <48ABB899.4090608@alum.mit.edu> <48ABC943.20508@bluelane.com> <48ABCBFD.7070503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: piet@bluelane.com, Git Mailing List <git@vger.kernel.org>,
	Piet Delaney <piet.delaney@gmail.com>,
	Piet Delaney <pdelaney@bluelane.com>,
	Avinash Kaul <avinash@bluelane.com>,
	Aravind Srinivasan <aravinds@bluelane.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 20 10:19:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KViuE-0001FH-NO
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 10:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbYHTIR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 04:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYHTIR6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 04:17:58 -0400
Received: from smurf.noris.de ([192.109.102.42]:40392 "EHLO smurf.noris.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbYHTIR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 04:17:56 -0400
X-Greylist: delayed 1499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Aug 2008 04:17:56 EDT
Received: from smurf by smurf.noris.de with local (Exim 4.63)
	(envelope-from <smurf@smurf.noris.de>)
	id 1KViUd-0006Gr-0J; Wed, 20 Aug 2008 09:52:35 +0200
Content-Disposition: inline
In-Reply-To: <48ABCBFD.7070503@alum.mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92972>

Hi,

Michael Haggerty:
> cvs2svn/cvs2git does not support this (called "incremental imports").

git-cvsimport tries to.

> It is quite hard to implement robustly.  In fact, I claim that no tool
> handles incremental imports robustly, despite the fact that some claim
> to do so :-)
> 
As people are habitually mucking with their CVS repositories, your best
way to reliably do an incremental import is to do a regular import,
put the two trees into the same git repository (easily achieved by a
line in .git/objects/info/alternates and strategic copying of the
tip-of-tree references), and git-rebase your non-CVS work.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
When mutilating cattle, avoid the ones with testicles.
		-- The Evil Cultist List
