From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Best way to generate a git tree containing only a subset of commits
 from another tree?
Date: Wed, 22 Mar 2006 19:28:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Mar 22 20:29:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM911-0004SK-PM
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 20:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWCVT3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 14:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWCVT3B
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 14:29:01 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:27547 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932414AbWCVT3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 14:29:01 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:59293)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:aia21) id 1FM90m-0000w7-TF (Exim 4.54) for git@vger.kernel.org
	(return-path <aia21@hermes.cam.ac.uk>); Wed, 22 Mar 2006 19:28:52 +0000
Received: from aia21 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1FM90m-0006CX-0y (Exim 4.53) for git@vger.kernel.org
	(return-path <aia21@hermes.cam.ac.uk>); Wed, 22 Mar 2006 19:28:52 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17824>

As subject, what is at present the best way to generate a git tree 
containing only a subset of commits from another tree.

So I have /usr/src/my-big-tree and /usr/src/linux-2.6 and now I want to 
add some of the commits in my-big-tree to the tree linux-2.6 so I can push 
out to Linus.

Preferable I would like to do it so that later when Linus has pulled from 
my /usr/src/linux-2.6 tree, I do a "git pull" of Linus' tree from 
/usr/src/my-big-tree and it all works correctly and I don't end up with 
the same commits twice.

Is that possible at all?

If not what can I do to do it cleanly?  Does git help in any way or do I 
literally have to export all my commits from /usr/src/my-big-tree to diff 
style patches and then throw away the tree, clone Linus tree after he has 
pulled my /usr/src/linux-2.6 tree and commit all my generated diff patches 
again?  That would be rather horrible to have to do...

I am happy to be pointed to a FAQ or RTFM if you tell me where to look for 
it...

Thanks a lot in advance!

PS. Please keep me CC:-ed as I am not on the git mailing list any more.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
