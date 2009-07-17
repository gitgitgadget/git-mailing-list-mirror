From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn graft-branches
Date: Fri, 17 Jul 2009 16:21:57 +0200
Message-ID: <4A608905.8070705@drmicha.warpmail.net>
References: <h3pn45$eam$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 16:22:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRoKN-00021Y-FM
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 16:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934690AbZGQOWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 10:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934686AbZGQOWQ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 10:22:16 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58990 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934617AbZGQOWP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 10:22:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id ABE453BC23A;
	Fri, 17 Jul 2009 10:22:14 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 17 Jul 2009 10:22:14 -0400
X-Sasl-enc: +2jr+8zK3RbNlgh6rbF8eCkxDkVLq6GiW99DuN5uDERA 1247840534
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 226B24B1D5;
	Fri, 17 Jul 2009 10:22:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090717 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <h3pn45$eam$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123463>

Graeme Geldenhuys venit, vidit, dixit 17.07.2009 13:25:
> Hi,
> 
> Looking at the history of a cloned SubVersion repository, I noticed that 
> git does track svn merges between the subversion branches.
> 
> Apparently there was a command to help git detect this merge:
> 
>    git-svn graft-branches
> 
> As documented in the URL below
> 
> http://www.kernel.org/pub/software/scm/git/docs/v1.5.0.7/git-svn.html
> 
> 
> Now I have git version 1.6.3.3.363.g725cf7 but if I run the following, 
> git simply shows the help, and graft-branches doesn't seem to be a 
> command anymore. Was 'graft-branches' removed from Git?
> 
>   $ git svn graft-branches
> 
> Above does not work anymore.

$git log -Sgraft-branches
commit a836a0e1729d1758b4085cd07fc79cb9acb64908
Author: Eric Wong <normalperson@yhbt.net>
Date:   Wed Feb 14 19:34:56 2007 -0800

    git-svn: documentation updates for new functionality

    Force the showing of the --minimize flag as an option in the
    'migrate' help.

    Also, fix the usage function to correctly filter out
    the deprecated aliases.

    Signed-off-by: Eric Wong <normalperson@yhbt.net>

commit d05d72e07e49869fe988d4d99e6ac60711570db5
Author: Eric Wong <normalperson@yhbt.net>
Date:   Mon Jan 15 22:59:26 2007 -0800

    git-svn: remove graft-branches command

    It's becoming a maintenance burden.  I've never found it
    particularly useful myself, nor have I heard much feedback about
    it; so I'm assuming it's just as useless to everyone else.

    Signed-off-by: Eric Wong <normalperson@yhbt.net>

...
