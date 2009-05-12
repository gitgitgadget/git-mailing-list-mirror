From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: how to make "pull" always pulling the matching branch?
Date: Tue, 12 May 2009 20:21:40 +0100
Message-ID: <20090512192140.GK31826@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 22:04:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3yDR-0008Ey-Bn
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 22:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbZELUEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 16:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbZELUEE
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 16:04:04 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:52689 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbZELUEB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 16:04:01 -0400
X-Greylist: delayed 2539 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2009 16:04:01 EDT
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1M3xXp-0006JV-GL; Tue, 12 May 2009 20:21:41 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id E0588DB080;
	Tue, 12 May 2009 20:21:40 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id C3D46741E6; Tue, 12 May 2009 20:21:40 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118949>

Hello,

until some time ago,

git pull remote-repo

worked like that; alright, at some time
warning messages appeared, so I used

git pull remote-repo master

I attempted several times to understand the
strange message issued by pull:
--------------------
You asked me to pull without telling me which branch you
want to merge with, and 'branch.master.merge' in
your configuration file does not tell me either.        Please
specify which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch.master.remote = <nickname>
    branch.master.merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details.
--------------------
but neither do I understand what could be meant here, nor
do I understand the details of git-pull or git-config w.r.t.
this issue (the above doesn't give a hint about the meaning
of the possible actions).

So well, now the same thing happened with "git push", but here
the message actually is better and tells the reader what to do
(nearly); so I specified "matching" for the config-variable 
push.default, and that's fine.

I was hoping that there would also be a pull.default, which I could
set to matching, but apparently there is nothing like that? How
do I achieve this?

It seems rather sensible to me to have this as the default: just
pull a matching branch, not more, not less --- what else could/should
it be if nothing else is specified?

Oliver

P.S. I'm using version 1.6.3.
