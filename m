From: <esskov@oncable.dk>
Subject: git-svn is "Unable to determine upstream SVN information..."
Date: Fri, 10 Jul 2009 00:53:41 +0200
Message-ID: <ohrc5510bko329be5ugj3n6bgvhcevd2kg@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 00:53:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP2Ut-0003Ew-3S
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 00:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbZGIWxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 18:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbZGIWxi
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 18:53:38 -0400
Received: from mx04.stofanet.dk ([212.10.10.14]:49142 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbZGIWxi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 18:53:38 -0400
Received: from 56344c10.rev.stofanet.dk ([86.52.76.16] helo=eclipse2)
	by mx04.stofanet.dk (envelope-from
	<esskov@oncable.dk>)
	with esmtpa id 1MP2Ui-00014N-3D
	for git@vger.kernel.org; Fri, 10 Jul 2009 00:53:37 +0200
X-Mailer: Forte Agent 4.2/32.1118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123017>

	Hi,

I'm trying to clone the trunk of an svn repo, so that I can work on a set
of patches locally, and then occasionally push some of them back to svn.

The git-svn clone seems to go well, and the resulting git log looks
alright. However, git-svn info and git-svn rebase both say "Unable to
determine upstream SVN information from working tree history".
Also, git-svn log shows nothing.  I'm using the svn:// protocol btw, but I
guess the protocol shouldn't matter?

To test if this was a general problem, I just tried to git-svn clone a
repo on some public svn server which was also using the svn protocol. I
used exactly the same syntax for the svn init and fetch commands. However,
the resulting git repo did NOT suffer from the problem, i.e., git-svn info
reported nicely etc.

At some point I suspected that there might be a problem with the
"git-svn-id ..." lines in the commits for the problematic repo, but they
look just like the ones for the working repo. The .git/config files of the
working and the non-working git-repos are similar as well. 

What could be causing this problem?


Cheers,

	Esben
