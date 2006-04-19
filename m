From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Tue, 18 Apr 2006 23:53:38 -0700
Message-ID: <7vd5feawel.fsf@assigned-by-dhcp.cox.net>
References: <20060419053640.GA16334@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 08:53:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW6ZL-0001St-JP
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 08:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDSGxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 02:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWDSGxk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 02:53:40 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30915 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750809AbWDSGxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 02:53:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419065339.TSTA20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 02:53:39 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20060419053640.GA16334@tumblerings.org> (Zack Brown's message of
	"Tue, 18 Apr 2006 22:36:40 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18911>

Zack Brown <zbrown@tumblerings.org> writes:

> What is going on? I'm completely unable to clone a repository.

I have no idea how cg-* is broken, so I'll let Pasky answer
that, but I suspect your git installation is broken.

> If I try
> "git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git",
> I get this error: "git: 'clone' is not a git-command", and it prints a usage
> page, but "clone" is listed on that usage page.

That sounds intersting.  Although rsync is deprecated for a long
time and git:// is the preferred transport, I do not get "is not
a git-command" error.  Are you installing things correctly?

For example, as the first paragraph of INSTALL says, if you
override prefix= from the make command line, you need to do so
consistently when you build and when you install.

What do these command say?

	$ git --exec-path
	$ ls -l "`git --exec-path`/git-clone"
