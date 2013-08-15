From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Git access to Bzr repository fails for enwc
Date: Thu, 15 Aug 2013 12:31:56 -0400
Message-ID: <jwvbo4ygbo8.fsf-monnier+emacs@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 18:41:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA0cH-0007tS-FD
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 18:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758753Ab3HOQlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 12:41:37 -0400
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:39584 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757869Ab3HOQlg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Aug 2013 12:41:36 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2013 12:41:36 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsoGABK/CFFLd/Nq/2dsb2JhbABEtyKHbBdzgkwvciYYDYhIoAuhIo1hgykDpHqBXoMT
X-IPAS-Result: AsoGABK/CFFLd/Nq/2dsb2JhbABEtyKHbBdzgkwvciYYDYhIoAuhIo1hgykDpHqBXoMT
X-IronPort-AV: E=Sophos;i="4.84,565,1355115600"; 
   d="scan'208";a="21950377"
Received: from 75-119-243-106.dsl.teksavvy.com (HELO pastel.home) ([75.119.243.106])
  by ironport2-out.teksavvy.com with ESMTP/TLS/ADH-AES256-SHA; 15 Aug 2013 12:31:50 -0400
Received: by pastel.home (Postfix, from userid 20848)
	id 0328E66215; Thu, 15 Aug 2013 12:31:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232351>

I've had good success recently with the git->bzr bridge, but the
following still fails.  This is on Debian with the git from "unstable".


        Stefan


% git clone bzr::bzr://bzr.savannah.nongnu.org/enwc/trunk
Cloning into 'trunk'...
Note: checking out 'e8fa1a2339729de62d0ad85e44b8993bf25b7996'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b new_branch_name

error: unable to find b8c01407a3e9f69bdfa5b8ab195a2680caa5d3d5
error: unable to read sha1 file of COPYING (b8c01407a3e9f69bdfa5b8ab195a2680caa5d3d5)
error: unable to find 4cdecd08dd6cc2f196949b60b6daf6d4456840a1
error: unable to read sha1 file of Makefile (4cdecd08dd6cc2f196949b60b6daf6d4456840a1)
error: unable to find 81a14bd73e6c11ae0fb78071c93dce5c80a7e8a3
error: unable to read sha1 file of doc/connman.txt (81a14bd73e6c11ae0fb78071c93dce5c80a7e8a3)
error: unable to find 15a6ad4dc0c9d48bebc20cb267ae47ad66d1ccf9
error: unable to read sha1 file of doc/enwc.texi (15a6ad4dc0c9d48bebc20cb267ae47ad66d1ccf9)
error: unable to find c34c35a3a641358b95d3c4fd34b6ac2f5268b291
error: unable to read sha1 file of doc/fdl.texi (c34c35a3a641358b95d3c4fd34b6ac2f5268b291)
error: unable to find 1920a86cbab296d01763f975d004f4338f51269b
error: unable to read sha1 file of doc/nm-dbus.txt (1920a86cbab296d01763f975d004f4338f51269b)
error: unable to find 7fd9428f0bc56e0e5c132cdfc03f35a07a516160
error: unable to read sha1 file of doc/settings.txt (7fd9428f0bc56e0e5c132cdfc03f35a07a516160)
error: unable to find b2f5df78313374b87d97996d72053cc5fd875fba
error: unable to read sha1 file of doc/version.texi (b2f5df78313374b87d97996d72053cc5fd875fba)
error: unable to find 26c50c2600457c8ae4c492496b6217d79a96da75
error: unable to read sha1 file of lisp/Makefile (26c50c2600457c8ae4c492496b6217d79a96da75)
error: unable to find 3c3170e4fc62b68f05d4017e4bb88632527317e1
error: unable to read sha1 file of lisp/enwc-cm.el (3c3170e4fc62b68f05d4017e4bb88632527317e1)
error: unable to find e7e64d3bd3af3bdbebfcf077c52363b2eec06b0d
error: unable to read sha1 file of lisp/enwc-nm.el (e7e64d3bd3af3bdbebfcf077c52363b2eec06b0d)
error: unable to find f4401ec703b96b34edee06b5f015f8a6d73e9a55
error: unable to read sha1 file of lisp/enwc-setup.el (f4401ec703b96b34edee06b5f015f8a6d73e9a55)
error: unable to find fb83160d3352633558786e73e2d8c6f466e1967f
error: unable to read sha1 file of lisp/enwc-wicd.el (fb83160d3352633558786e73e2d8c6f466e1967f)
error: unable to find f765245c1cfb93c645be53dc56772cabc90cdb24
error: unable to read sha1 file of lisp/enwc.el (f765245c1cfb93c645be53dc56772cabc90cdb24)
% git --version                                     
git version 1.7.10.4
%
