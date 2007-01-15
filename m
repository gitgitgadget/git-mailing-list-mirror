From: Josef Sipek <jsipek@cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.18
Date: Sun, 14 Jan 2007 20:02:39 -0500
Message-ID: <20070115010239.GB9484@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751771AbXAOBCn@vger.kernel.org Mon Jan 15 19:13:49 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751771AbXAOBCn@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vbk-0003BJ-Ds
	for glk-linux-kernel-3@m.gmane.org; Mon, 15 Jan 2007 18:26:56 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8h-0003eK-3M
	for glk-linux-kernel-3@m.gmane.org; Mon, 15 Jan 2007 17:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbXAOBCn (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 14 Jan 2007 20:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXAOBCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 20:02:43 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50599 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbXAOBCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 20:02:42 -0500
Received: from filer.fsl.cs.sunysb.edu (IDENT:AK7ZcEitXiQssrMLje2XctiNdpAoSwFS@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l0F12egl013351;
	Sun, 14 Jan 2007 20:02:40 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l0F12dKr013349;
	Sun, 14 Jan 2007 20:02:39 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36820>

Guilt v0.18 is available for download.

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


The majority of changes is in greater sanity checking - before a patch is
pushed/popped/refreshed, we check the HEAD hash with that in the status file.
guilt-pop now does only one git-reset instead of n (n == number of patches
to pop). This should greatly increase the speed of popping patches.

Josef "Jeff" Sipek.

----------

Josef 'Jeff' Sipek (10):
      push_patch should be more careful when applying patches
      pop_patch should be quieter
      Removed debug line out of push_patch
      guilt-pop is now less brain damaged
      Add -m & -s args to guilt-new
      push_patch: look at diff stats instead of number of lines in patch
      Check HEAD hash against what we expect before push/pop/refresh
      Small cleanup in push_patch
      TODO moved to a separate branch
      Guilt v0.18

-- 
All science is either physics or stamp collecting.
		- Ernest Rutherford
