From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 0/4] ld/push-porcelain
Date: Fri, 26 Feb 2010 22:59:47 -0500
Message-ID: <cover.1267242789.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 05:00:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlDqk-0003aU-9X
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967783Ab0B0D7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 22:59:55 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:59108 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967762Ab0B0D7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 22:59:53 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 01457822014; Fri, 26 Feb 2010 22:59:52 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141174>

Changes since last version:

* instead of messing with the exit status git push --porcelain will now print
  "Done" if nothing untowrd happned (ie all the error messages are in the ref
  status lines)

* added tests for git push --porcelain 

Larry D'Anna (4):
  git-push: fix an advice message so it goes to stderr
  git-push: send "To <remoteurl>" messages to the standard output in
    --porcelain mode
  git-push: make git push --porcelain print "Done"
  git-push: add tests for git push --porcelain

 builtin-push.c        |    6 +++---
 builtin-send-pack.c   |    4 ++++
 send-pack.h           |    1 +
 t/t5516-fetch-push.sh |   35 +++++++++++++++++++++++++++++++++++
 transport.c           |   17 +++++++++++------
 5 files changed, 54 insertions(+), 9 deletions(-)
