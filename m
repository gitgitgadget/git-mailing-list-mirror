From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Fix git-svn to handle svn not reporting the md5sum of a file, and test.
Date: Sun, 27 May 2007 10:23:51 -0700
Message-ID: <20070527172351.GA27309@muzzle>
References: <1179981426176-git-send-email-foom@fuhm.net> <4659703B.8070101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Y Knight <foom@fuhm.net>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 19:24:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsMTT-0000rC-Kq
	for gcvg-git@gmane.org; Sun, 27 May 2007 19:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbXE0RYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 13:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXE0RYH
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 13:24:07 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42367 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbXE0RYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 13:24:06 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 07B702DC032;
	Sun, 27 May 2007 10:23:52 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 27 May 2007 10:23:51 -0700
Content-Disposition: inline
In-Reply-To: <4659703B.8070101@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48569>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> James Y Knight wrote:
> >---
> > git-svn.perl                    |    2 +-
> > t/t9112-git-svn-md5less-file.sh |   45 
> > +++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 46 insertions(+), 1 deletions(-)
> > create mode 100755 t/t9112-git-svn-md5less-file.sh
> [...]
> 
> The new test fails here (Suse 9.3 fully patched) w/ the following:
> 
> *** t9112-git-svn-md5less-file.sh ***
> *   ok 1: load svn dumpfile
> *   ok 2: initialize git-svn
> * FAIL 3: fetch revisions from svn
>         git-svn fetch
> * failed 1 among 3 test(s)
> make[1]: *** [t9112-git-svn-md5less-file.sh] Error 1

I can't reproduce it here (on Debian Etch, SVN 1.4.2).  Can you run with
the test with the -v switch?  Thanks.

-- 
Eric Wong
