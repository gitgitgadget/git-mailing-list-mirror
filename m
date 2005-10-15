From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: SVN import
Date: Sat, 15 Oct 2005 23:32:50 +0300
Message-ID: <878xwuldvx.fsf@litku.valo.iki.fi>
References: <pan.2005.08.19.10.00.49.401829@smurf.noris.de>
	<pan.2005.10.10.09.45.00.468989@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 22:33:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQsiN-0007Wc-3f
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 22:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVJOUc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 16:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVJOUc4
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 16:32:56 -0400
Received: from fep31-0.kolumbus.fi ([193.229.0.35]:25032 "EHLO
	fep31-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751217AbVJOUcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 16:32:55 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep31-app.kolumbus.fi
          with ESMTP
          id <20051015203251.DIEA14657.fep31-app.kolumbus.fi@litku.valo.iki.fi>;
          Sat, 15 Oct 2005 23:32:51 +0300
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.10.10.09.45.00.468989@smurf.noris.de> (Matthias
	Urlichs's message of "Mon, 10 Oct 2005 11:45:05 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10143>

Matthias Urlichs <smurf@smurf.noris.de> writes:

>> Quick note: I'm working on importing from SVN.
>
> The first version seems to be finished.
>
> http:/netz/smurf.noris.de/git/git.git, branch "svn".
>
> Should be ready for merging, though I wouldn't say no to a few testers
> before that happens.  ;-)

After fixing a conflict and a typo in Makefile (patch coming soon) I
tested this with the bcm43xx driver from
svn://svn.berlios.de/bcm43xx/trunk. It seems to work fine. 

Only a minor problem was that I immediately didn't realize the 100
commit limit was intentional. Maybe the error message could improved a
bit. Now it says:

        Exiting due to a memory leak. Repeat, please.

Maybe something like this would be more informative:

        Subversion commit limit reached (to avoid SVN library memory
        leaks). Exiting, but please repeat the command and it will
        continue safely.

But in overall this is a really useful addition to git, I hope it will
be merged soon.

-- 
Kalle Valo
