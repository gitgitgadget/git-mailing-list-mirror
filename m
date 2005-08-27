From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: cvsimport error: need a valid pathname
Date: Sat, 27 Aug 2005 17:48:26 +0300
Message-ID: <874q9bcu6d.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 27 16:47:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E91xA-0002cE-OT
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 16:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbVH0Oqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 10:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbVH0Oqh
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 10:46:37 -0400
Received: from fep06-0.kolumbus.fi ([193.229.0.57]:35293 "EHLO
	fep06-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S965192AbVH0Oqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2005 10:46:36 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep06-app.kolumbus.fi
          with ESMTP
          id <20050827144632.HHKF27547.fep06-app.kolumbus.fi@litku.valo.iki.fi>
          for <git@vger.kernel.org>; Sat, 27 Aug 2005 17:46:32 +0300
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7849>

I have already imported a full CVS repository using this command:

git cvsimport -v -d :pserver:anonymous@hostap.epitest.fi:/cvs hostap

It completed without errors and I could use git to access the hostap
history, just like I wanted. But now, when I was trying to get updates
from the CVS repository, I got an error running the command in the
same directory:

$ git cvsimport -v -d :pserver:anonymous@hostap.epitest.fi:/cvs hostap
fileparse(): need a valid pathname at /usr/bin/git-cvsimport-script line 435
$

The documentation says that it should be possible to update
incrementally from the CVS repository. Am I doing something wrong or
is this a bug?

I'm using git updated today from the master branch on Debian unstable.

-- 
Kalle Valo
