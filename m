From: Anand Kumria <wildfire@progsoc.uts.edu.au>
Subject: ~/.git/config ?
Date: Sat, 27 May 2006 01:28:37 +1000
Message-ID: <20060526152837.GQ23852@progsoc.uts.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 26 17:28:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjeF0-00032O-KJ
	for gcvg-git@gmane.org; Fri, 26 May 2006 17:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWEZP2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 11:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWEZP2j
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 11:28:39 -0400
Received: from incubus.progsoc.uts.edu.au ([138.25.6.7]:31423 "EHLO
	incubus.progsoc.uts.edu.au") by vger.kernel.org with ESMTP
	id S1750909AbWEZP2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 11:28:39 -0400
Received: from wildfire by incubus.progsoc.uts.edu.au with local (Exim 4.50)
	id 1FjeEv-0002Vz-R5
	for git@vger.kernel.org; Sat, 27 May 2006 01:28:37 +1000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: wildfire@progsoc.uts.edu.au
X-SA-Exim-Scanned: No (on incubus.progsoc.uts.edu.au); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20814>

Hi,

git is unable to construct a reasonable default email address in my
current environment.  So, I use GIT_AUTHOR_EMAIL and GIT_COMMITTER_EMAIL
to override things.

This has worked well but, now, I need to vary the email address for some
repositories.  Unfortunately the environment variables override
.git/config.

It would be good if things were like:
	- try to construct one automagically
	- use ~/.git/config (if available)
	- use .git/config
	- use environment variables

That way I could set my default email address in ~/.git/config and
override it as required for those repositories that need it.

Thanks,
Anand

-- 
 `When any government, or any church for that matter, undertakes to say to
  its subjects, "This you may not read, this you must not see, this you are
  forbidden to know," the end result is tyranny and oppression no matter how
  holy the motives' -- Robert A Heinlein, "If this goes on --"
