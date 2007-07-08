From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn failed on apr
Date: Sat, 7 Jul 2007 20:35:22 -0700
Message-ID: <20070708033522.GA12818@mayonaise>
References: <4b3406f0707030205g3521cff5p1d5150b6a81af51b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dongsheng Song <dongsheng.song@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 05:35:38 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7NYf-0000XQ-0n
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 05:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbXGHDfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 23:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbXGHDfZ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 23:35:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35538 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755002AbXGHDfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 23:35:25 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 061402DC032;
	Sat,  7 Jul 2007 20:35:22 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 07 Jul 2007 20:35:22 -0700
Content-Disposition: inline
In-Reply-To: <4b3406f0707030205g3521cff5p1d5150b6a81af51b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51859>

Dongsheng Song <dongsheng.song@gmail.com> wrote:
> [ ~/wc/git-svn]$ mkdir apr
> [ ~/wc/git-svn]$ cd apr/
> [ ~/wc/git-svn/apr]$ ls
> [ ~/wc/git-svn/apr]$ git-svn init -T trunk -b branches -t tags
> http://svn.apache.org/repos/asf/apr/apr
> Initialized empty Git repository in .git/
> Using higher level of URL: http://svn.apache.org/repos/asf/apr/apr =>
> http://svn.apache.org/repos/asf
> [ ~/wc/git-svn/apr]$ git-svn fetch
> W: Ignoring error from SVN, path probably does not exist: (175002): RA
> layer request failed: REPORT request failed on
> '/repos/asf/!svn/bc/2200': REPORT of '/repos/asf/!svn/bc/2200': 200 OK
> (http://svn.apache.org)
> 
> What's wrong?

Nothing.

The "W:" there means it's just a warning.  git-svn looks into the
beginning of history in an attempt to fetch all history, and if
the directory you're tracking doesn't exist, it'll spit out that
warning message once (it used to spit it out a lot more).

-- 
Eric Wong
