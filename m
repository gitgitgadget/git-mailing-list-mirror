From: Jon Loeliger <jdl@jdl.com>
Subject: Setting up Password protected repositories?
Date: Sat, 16 Sep 2006 19:52:53 -0500
Message-ID: <E1GOktx-0005JY-ER@jdl.com>
X-From: git-owner@vger.kernel.org Sun Sep 17 02:53:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOku4-0004MC-2B
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 02:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWIQAw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 20:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWIQAw5
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 20:52:57 -0400
Received: from mail.jdl.com ([66.118.10.122]:51911 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964889AbWIQAw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 20:52:57 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GOktx-0005JY-ER
	for git@vger.kernel.org; Sat, 16 Sep 2006 19:52:54 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27145>

So at the risk of asking a dead-stupid question for which
I should likely be soundly beaten for even asking...

How does one set up a git repository on a public site
but password/ssh protected it so that only a few trusted
people can access and update it?

Clearly, we should be using ssh+git: here somehow, right?
git-daemon has to know where to server out the files from,
but how do we get it to enforce a ssh-based access?  It's
easy to prevent http: from serving out the repository --
just place it outside of the webroot directory structure.

I can already enforce pushes to be password protected,
but the protection on pulls and clones eludes me.  I'd
also like to NOT grant login shell access on the repository
server machine, so I'm envisioning placing pubic keys from
trusted people somewhere too...

I feel like I am being blindly stupid here.

Any help for the weary?

Thanks,
jdl
