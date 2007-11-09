From: Bill Lear <rael@zopyra.com>
Subject: git 1.5.3.5 error over NFS
Date: Fri, 9 Nov 2007 09:31:39 -0600
Message-ID: <18228.32091.865519.312011@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 16:32:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqVq2-000872-Su
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762227AbXKIPbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760130AbXKIPbv
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:31:51 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61395 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761697AbXKIPbu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:31:50 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lA9FVnP18527;
	Fri, 9 Nov 2007 09:31:49 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64201>

I've brought this up before, but I don't recall a resolution to it.

We have an NFS-mounted filesystem, and git pull is choking on it.

% uname -a
Linux uhlr.zopyra.com 2.6.9-42.0.2.ELsmp #1 SMP Wed Aug 23 13:38:27 BST 2006 x86_64 x86_64 x86_64 GNU/Linux

% git --version
git version 1.5.3.5

% git pull
remote: Generating pack...
remote: Done counting 998 objects.
remote: Result has 836 objects.
remote: Deltifying 836 objects.
remote:  100% (836/836) done
Indexing 836 objects...
remote: Total 836 (delta 526), reused 688 (delta 380)
  100% (836/836) done
Resolving 526 deltas...
fatal: cannot pread pack file: No such file or directory
fatal: index-pack died with error code 128
fatal: Fetch failure: git://source/repo

I looked through the archives of this list and did not see a final
resolution, other than a suspected bug in the OS NFS code.

Do we just need to update our OS?


Bill
