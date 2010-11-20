From: tom fogal <tfogal@sci.utah.edu>
Subject: rebuild repo from data, packfiles?
Date: Sat, 20 Nov 2010 15:54:16 -0700
Message-ID: <auto-000024044659@sci.utah.edu>
Reply-To: tfogal@sci.utah.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 21 00:25:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJwo2-0007xO-8S
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 00:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab0KTXZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 18:25:12 -0500
Received: from mail.sci.utah.edu ([155.98.58.80]:28514 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755402Ab0KTXZL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 18:25:11 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Nov 2010 18:25:11 EST
Received: from dummy.name; Sat, 20 Nov 2010 15:55:11 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161849>

Long story short, I lost some metadata in a repo I've got.  However,
my entire .git/objects/ && subdirs is intact, so I'm hopeful my data's
still accessible in some form.

I'm trying to piece together the git metadata that goes in .git (no
subdirs) based on what I've got in other repos && what fails when I
strace git, in hopes I can rebuild my reflog to grab all the work
I only had locally.  Currently I can't `log' or `reflog' or really
anything, because git thinks this directory isn't a git repo.

I'm curious if there's ideas out there for rebuilding my repo based on
the repo's data.  Is there a command I could point at .git/objects and
have it repopulate the repo?

Thanks,

-tom
