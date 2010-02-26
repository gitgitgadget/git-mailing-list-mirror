From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 0/4] ld/push-porcelain
Date: Fri, 26 Feb 2010 14:50:06 -0500
Message-ID: <cover.1267211537.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 20:50:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl6Cz-000758-Ef
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 20:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965919Ab0BZTuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 14:50:17 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:37688 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965883Ab0BZTuP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 14:50:15 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 69646822022; Fri, 26 Feb 2010 14:50:11 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141140>


I'm reposing this series to restart discussion on it. It's currently listed as
stalled.  The only change versus what's in pu is that this one doesn't mess with
the semantics of --quiet.  

So, what does it need?


Larry D'Anna (4):
  git-push: fix an error message so it goes to stderr
  git-push: squelch advice message if in --porcelain mode
  git-push: send "To <remoteurl>" messages to the standard output in
    --porcelain mode
  git-push: make git push --dry-run --porcelain exit with status 0 even
    if updates will be rejected

 builtin-push.c      |   11 ++++++++---
 builtin-send-pack.c |    4 ++++
 send-pack.h         |    1 +
 transport.c         |    6 ++++--
 4 files changed, 17 insertions(+), 5 deletions(-)
