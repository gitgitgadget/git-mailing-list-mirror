From: Michael Poole <mdpoole@troilus.org>
Subject: Re: tracking remotes with Git
Date: Fri, 09 Nov 2007 11:37:17 -0500
Message-ID: <87ode31iki.fsf@graviton.dyn.troilus.org>
References: <b1e3a35f0711090444g3c31e862g4ef4ef8139927840@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ivan Shmakov" <oneingray@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWzm-0005gE-4n
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbXKIQp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754581AbXKIQp6
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:45:58 -0500
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:46362
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754512AbXKIQp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 11:45:57 -0500
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2007 11:45:57 EST
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id 84CA689C110; Fri,  9 Nov 2007 11:37:17 -0500 (EST)
In-Reply-To: <b1e3a35f0711090444g3c31e862g4ef4ef8139927840@mail.gmail.com> (Ivan Shmakov's message of "Fri\, 9 Nov 2007 19\:44\:50 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64218>

Ivan Shmakov writes:

>         I'm using Git (1.5.3.5 debian 1) for about a day or so, and I'm
>         quite impressed that it allows tracking remote repositories
>         (I've tried CVS and SVN) so easily with `git-cvsimport' and
>         `git-svn'.  However, I've ran into a couple of problems with
>         them:
>
>         * it looks like `git-cvsimport' uses its own CVS protocol
>           implementation which doesn't support compression; I've tried
>           to clone a repository of a project hosted in CVS since circa
>           1998 and it 20 MiB or so to obtain revisions until 2000 or so;
>           any ways to minimize traffic?

What I do is arguably a horrible kludge, but it works well: rsync to
mirror the CVS repository to my local drive, and cvsimport from that.
When I was tweaking the import process (command-line options and the
author conversion file), having the local copy helped a lot.

Michael Poole
