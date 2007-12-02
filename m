From: "Ed S. Peschko" <esp5@pge.com>
Subject: problems with importing from cvs archive
Date: Sat, 1 Dec 2007 22:46:13 -0800
Message-ID: <20071202064613.GB25351@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 08:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyjRJ-00038m-6H
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 08:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbXLBHbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 02:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXLBHbJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 02:31:09 -0500
Received: from mta06.pge.com ([131.90.0.76]:57302 "EHLO mta06.pge.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbXLBHbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 02:31:09 -0500
X-Greylist: delayed 2693 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Dec 2007 02:31:08 EST
Received: from mta11.comp.pge.com (mta11.comp.pge.com [10.245.211.126])
	by mta06.pge.com (Switch-3.3.0/Switch-3.2.4) with ESMTP id lB26kDVg024692
	for <git@vger.kernel.org>; Sat, 1 Dec 2007 22:46:13 -0800 (PST)
Received: from mdssdr01.utility.pge.com (mdssdr01.utility.pge.com [10.244.52.48])
	by mta11.comp.pge.com (Switch-3.3.0/Switch-3.3.0) with ESMTP id lB26kCR6022805
	for <git@vger.kernel.org>; Sat, 1 Dec 2007 22:46:12 -0800 (PST)
Received: (from esp5@localhost)
	by mdssdr01.utility.pge.com (8.11.7p3+Sun/8.11.7) id lB26kDT05619
	for git@vger.kernel.org; Sat, 1 Dec 2007 22:46:13 -0800 (PST)
X-Authentication-Warning: mdssdr01.utility.pge.com: esp5 set sender to esp5@pge.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66766>

All,

I'm trying to use git-cvsimport to import from a CVS archive, using:

git-cvsimport -d $CVSROOT

and am getting the following error:

	fatal: refs/heads/origin: not a valid SHA1
	fatal: master: not a valid SHA1
	warning: You appear to be on a branch yet to be born
	warning: Forcing checkout of HEAD
	fatal: just how do you expect me to merge 0 trees?
	checkout failed: 256

Is git-cvsimport meant to be universal - ie: work on any given CVS worktree - or do 
you need to prep the CVS worktree in any way in order for it to be used?

Or is this just a plain vanilla bug? 

Thanks,

Ed

 
