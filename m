From: "mattjackets" <mattlist@fastmail.fm>
Subject: Stash missing, but not.  Can apply, but not drop or list the stash.
Date: Tue, 23 Sep 2008 17:23:01 -0400
Message-ID: <1222204981.28575.1275592473@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 23:25:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFNw-0001y0-6C
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbYIWVXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbYIWVXF
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:23:05 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46225 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755709AbYIWVXE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2008 17:23:04 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6747116564C
	for <git@vger.kernel.org>; Tue, 23 Sep 2008 17:23:01 -0400 (EDT)
Received: from web6.messagingengine.com ([10.202.2.215])
  by compute1.internal (MEProxy); Tue, 23 Sep 2008 17:23:01 -0400
Received: by web6.messagingengine.com (Postfix, from userid 99)
	id 4CD91BB1F5; Tue, 23 Sep 2008 17:23:01 -0400 (EDT)
X-Sasl-Enc: FqGwRUQfjqxZY/YHrNTKwENTAAKwS7Z3HV2HcPRmAm0H 1222204981
Content-Disposition: inline
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96603>

I have a strange stash problem.  There is a single stash in the repo.

git stash apply 0  --  works, but results in a conflict.  Lets just go
ahead and drop the stash...

git stash list  --  shows nothing.  huh?  Lets go ahead with the drop
anyway and hope it works...

$ git stash drop stash@{0}
fatal: Log .git/logs/refs/stash is empty.
stash@{0}: not a valid stashed state

sure enough, .git/logs/refs/stash is empty

git stash clear  --  does nothing

I'm at a loss.  I can apply the stash cleanly to older revisions, and
gitk still shows the stash branch.  How can I fix this?  is it safe to
simply delete the stash branch as if it was any other branch?

Thanks,
Matt
-- 
  matt
  mattlist@fastmail.fm

-- 
http://www.fastmail.fm - Access all of your messages and folders
                          wherever you are
