From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 0/4] completion fixes: Acks, whitespace, and r=""
Date: Wed, 11 Feb 2009 13:54:35 -0500
Message-ID: <1234378479-29304-1-git-send-email-ted@tedpavlic.com>
References: <7v63jgg7st.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 19:56:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKFy-0002sJ-Ik
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874AbZBKSyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756426AbZBKSyw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:54:52 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:44554 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755718AbZBKSyv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 13:54:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 1900580D808D;
	Wed, 11 Feb 2009 13:48:20 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKGR34VbXGlv; Wed, 11 Feb 2009 13:48:20 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id EBA9E80D8088;
	Wed, 11 Feb 2009 13:48:19 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
In-Reply-To: <7v63jgg7st.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109500>

* Added Shawn O. Pearce acks
* Fixed whitespace problem in second patch (vim:expandtabs was on)
* When in GIT_DIR, set r="" in __git_ps1 as well

Ted Pavlic (4):
  completion: For consistency, changed "git rev-parse" to __gitdir
    calls.
  completion: Use consistent if [...] convention. No test.
  completion: Better __git_ps1 support when not in working directory
  completion: More fixes to prevent unbound variable errors.

 contrib/completion/git-completion.bash |   76 ++++++++++++++++----------------
 1 files changed, 38 insertions(+), 38 deletions(-)
