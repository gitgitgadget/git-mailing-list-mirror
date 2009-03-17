From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 0/4] Reposting udpated patches
Date: Tue, 17 Mar 2009 11:08:47 +0000
Message-ID: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 12:10:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjXC5-0004eF-Sm
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 12:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361AbZCQLJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 07:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbZCQLJU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 07:09:20 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:47521 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753588AbZCQLJT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 07:09:19 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2HB7UZm019784;
	Tue, 17 Mar 2009 11:07:30 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Mar 2009 11:09:13 +0000
User-Agent: StGit/0.14.3.353.gf255
X-OriginalArrivalTime: 17 Mar 2009 11:09:13.0209 (UTC) FILETIME=[CDCFF690:01C9A6F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113460>

There are three patches which were updated after discussions and the
recommendation for the hidden argument to reorder_patches(). I haven't
reposted the acked patches.


Catalin Marinas (4):
      Use a default "hidden" argument in StackTransaction.reorder_patches
      Convert "float" to the lib infrastructure
      Add automatic git-mergetool invocation to the new infrastructure
      Add mergetool support to the classic StGit infrastructure


 examples/gitconfig         |   21 +-----
 stgit/commands/edit.py     |    2 -
 stgit/commands/float.py    |   80 +++++++++--------------
 stgit/commands/goto.py     |    2 -
 stgit/commands/resolved.py |    5 -
 stgit/commands/sink.py     |   84 +++++++++++--------------
 stgit/config.py            |    1 
 stgit/git.py               |   31 +++++----
 stgit/gitmergeonefile.py   |  150 --------------------------------------------
 stgit/lib/git.py           |   19 +++++-
 stgit/lib/transaction.py   |   11 ++-
 t/t0002-status.sh          |    3 -
 t/t1501-sink.sh            |    2 -
 13 files changed, 114 insertions(+), 297 deletions(-)
 delete mode 100644 stgit/gitmergeonefile.py

-- 
Catalin
