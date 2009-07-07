From: Yann Dirson <ydirson@altern.org>
Subject: [PATCHv3 0/4] First set of improvements to git-svn user doc
Date: Tue,  7 Jul 2009 22:22:18 +0200
Message-ID: <cover.1246997775.git.ydirson@altern.org>
References: <20090706222028.GB11043@dcvr.yhbt.net>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 22:22:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOHBQ-0002yV-4w
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 22:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719AbZGGUWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 16:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbZGGUWK
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 16:22:10 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42591 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755940AbZGGUWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 16:22:09 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 24A29940190;
	Tue,  7 Jul 2009 22:22:01 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 45F6F940149;
	Tue,  7 Jul 2009 22:21:59 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 3C3081F0A6; Tue,  7 Jul 2009 22:22:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <20090706222028.GB11043@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122869>

Yet another small improvement wrt the "make formatting more
consistent" patch, related to the formatting of flags for the
recently-introduced 'reset' command, as well as those of 'log' I had
missed.

Yann Dirson (4):
  git-svn.txt: stop using dash-form of commands.
  git-svn.txt: make formatting more consistent.
  git-svn.txt: fix fetch flags incorrectly documented as init flags.
  git-svn.txt: fix description of fetch flags accepted by clone.

 Documentation/git-svn.txt |  350 ++++++++++++++++++++++-----------------------
 1 files changed, 171 insertions(+), 179 deletions(-)
