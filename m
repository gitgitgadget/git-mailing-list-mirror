From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Add a bugzilla website
Date: Fri, 15 Nov 2013 13:51:32 +0400
Message-ID: <20131115135132.431d3e344dadee64e2be5127@domain007.com>
References: <20131115085326.GA2401@brouette>
	<551223703.314994127.1384508447263.JavaMail.root@zimbra35-e6.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: ycollette.nospam@free.fr
X-From: git-owner@vger.kernel.org Fri Nov 15 10:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhG46-0005iT-5N
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 10:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029Ab3KOJvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 04:51:45 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:46449 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab3KOJvg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 04:51:36 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rAF9pWUO021798;
	Fri, 15 Nov 2013 13:51:33 +0400
In-Reply-To: <551223703.314994127.1384508447263.JavaMail.root@zimbra35-e6.priv.proxad.net>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237896>

On Fri, 15 Nov 2013 10:40:47 +0100 (CET)
ycollette.nospam@free.fr wrote:

> And the conclusion is ? No bugzilla tool installed because somebody
> want to build a gitbased bugzilla thing ?

Well, no, the real answer is that for those who actually write code and
apply patches, an e-mail based workflow is simpler: Git has tools to
apply patches right from Unix mailboxes, so one is able to just save a
thread with the final patch series to a file and apply it.  Some people
also prefer discussing patches inline -- in the same e-mail thread
the patch series being discussed had started.

I'm aware of at least one big project sporting the same approach
to handling bugs -- PostgreSQL.

But there was an announcement that an experimental JIRA instance has
been set up for Git [1].  I'm not sure what its current status is, but
you could look at it.

Also Git's mirror on github [2] supposedly provides for pull requests.
Again, not sure whether/how they're handled.

1. http://git-blame.blogspot.ru/2012/02/experimental-git-bug-tracker.html
2. https://github.com/git/git/
