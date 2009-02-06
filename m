From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 0/2] completion: Fixes GIT_PS1_SHOWDIRTYSTATE problems
Date: Fri,  6 Feb 2009 10:46:48 -0500
Message-ID: <1233935210-4941-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Feb 06 16:48:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSwZ-0004Z0-SB
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbZBFPrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbZBFPrJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:47:09 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:42951 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753978AbZBFPrE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 10:47:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 2E66F80D8069;
	Fri,  6 Feb 2009 10:40:40 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ju39T5RPRaWN; Fri,  6 Feb 2009 10:40:40 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 02E2E80D8063;
	Fri,  6 Feb 2009 10:40:40 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108741>

These two patches correct some problems introduced by the recent
GIT_PS1_SHOWDIRTYSTATE fixes.

The first changes $VAR to ${VAR-} to
prevent the unbound variable errors that were discussed earlier on the
list.

The second changes the GIT_PS1_SHOWDIRTYSTATE documentation from

#(Tab)Text

to

#(7 spaces)Text

to be consistent with the surrounding text.

Ted Pavlic (2):
  completion: Fix GIT_PS1_SHOWDIRTYSTATE to prevent unbound variable
    errors.
  completion: Get rid of tabbed indentation in comments. Replace with
    spaces.

 contrib/completion/git-completion.bash |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
