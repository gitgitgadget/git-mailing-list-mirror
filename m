From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Pull is Mostly Evil
Date: Fri, 02 May 2014 11:37:03 -0400
Message-ID: <5363BB9F.40102@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 02 17:36:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgFVv-0004Ff-MQ
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 17:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbaEBPgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 11:36:35 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:53358 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbaEBPge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 11:36:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp29.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id A1C021087FE;
	Fri,  2 May 2014 11:36:33 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp29.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8D5EF10872C;
	Fri,  2 May 2014 11:36:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247939>


(Apologies for not CCing all the folks who've participated in the "Pull is
Evil" thread -- I couldn't find a good branch of that thread for this message.)

OK, so maybe "git pull" is just Mostly Evil.  People seem to have found many
different ways to make it work for them.

But in reality "git pull" has become a chimera that confuses a large number
of new users, and that experienced users either avoid entirely or customize
to give them a convenient shorthand for working in their particular
environment.  As a tool for new git users, it just doesn't seem to be
achieving its goals.

I think the git project as a whole would benefit if it started to treat "git
pull" as an advanced command, in the sense that it needs to be configured by
an experienced user in order to make it correctly follow a project's
workflow.  Once it's configured properly, "git pull" is a powerful tool that
gives users an easy way to do complex things.  In that sense, it may be
appropriate for a project to tailor "git pull" as it likes, then teach its
own users to use the command.

However, when it comes to teaching people how to use git qua git, "git pull"
should be the last thing they learn about, because it's only after you
understand various basic git concepts that you can configure "git pull" to do
the right thing.

To that end, I suggest that pull's default behaviour should be to do
*nothing*.  It should just print out a message to the effect that it hasn't
been configured, and that the user should run "git help pull" for guidance.

It'll take quite a bit of time, but I think that if we change our attitude
towards "git pull" and take this unconfigured-by-default approach, then in a
few years the entire git ecosystem will be in a better place.

		M.
