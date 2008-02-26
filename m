From: Alex Chiang <achiang@hp.com>
Subject: stgit - continue rebase after merge conflict?
Date: Tue, 26 Feb 2008 07:57:25 -0700
Message-ID: <20080226145725.GA24987@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 26 15:59:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU1Fq-0000rI-Pw
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 15:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbYBZO51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 09:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYBZO50
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 09:57:26 -0500
Received: from g1t0029.austin.hp.com ([15.216.28.36]:45733 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYBZO50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 09:57:26 -0500
Received: from g1t0029.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id B729E38B6A;
	Tue, 26 Feb 2008 14:57:25 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by g1t0029.austin.hp.com (Postfix) with ESMTP id A5D0138B66;
	Tue, 26 Feb 2008 14:57:25 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 77D8E1E6474;
	Tue, 26 Feb 2008 14:57:25 +0000 (UTC)
Received: by ldl.fc.hp.com (Postfix, from userid 17609)
	id 641C3134006; Tue, 26 Feb 2008 07:57:25 -0700 (MST)
Mail-Followup-To: Alex Chiang <achiang@hp.com>,
	catalin.marinas@gmail.com, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75143>

Hi Catalin,

How does one do a stg rebase if there are merge conflicts?

I see:

-------------------------------------------------------
achiang@blender:~/kernels/linux-2.6$ stg rebase origin
Upgraded branch stg-pci-slots to format version 2
Checking for changes in the working directory ... done
Popping all applied patches ... done
Rebasing to "origin" ... done
Pushing patch "0001-Remove-path-attribute-from-sgi_hotplug.patch" ... done
Pushing patch "0002-Construct-one-fakephp-slot-per-pci-slot.patch" ... 
  CONFLICT (content): Merge conflict in drivers/pci/hotplug/fakephp.c
  Error: The merge failed during "push".
         Revert the operation with "push --undo".
  stg rebase: 1 conflict(s)
-------------------------------------------------------

This output tells you how to undo the rebase, but doesn't give
any clues on how to continue it, like git would:

-------------------------------------------------------
When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".
-------------------------------------------------------

Doing an 'stg help rebase' isn't so helpful.

My *guess* is that I want to:

	- manually resolve the merge conflicts
	- stg refresh
	- ???

Any hints are appreciated.

Thanks.

/ac
