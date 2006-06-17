From: Michael Somos <somos@grail.cba.csuohio.edu>
Subject: Re: git-1.4.0 make problems
Date: Sat, 17 Jun 2006 06:16:26 -0400
Message-ID: <200606171016.k5HAGQ1D005560@grail.cba.csuohio.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 12:23:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrXxJ-0004pZ-25
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 12:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWFQKW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 06:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWFQKW6
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 06:22:58 -0400
Received: from grail.cba.csuohio.edu ([137.148.216.15]:57293 "EHLO
	grail.cba.csuohio.edu") by vger.kernel.org with ESMTP
	id S1751449AbWFQKW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 06:22:57 -0400
Received: from grail.cba.csuohio.edu (localhost [127.0.0.1])
	by grail.cba.csuohio.edu (8.12.11/8.12.10) with ESMTP id k5HAGQF5005562;
	Sat, 17 Jun 2006 06:16:26 -0400
Received: (from somos@localhost)
	by grail.cba.csuohio.edu (8.12.11/8.12.11/Submit) id k5HAGQ1D005560;
	Sat, 17 Jun 2006 06:16:26 -0400
To: rene.scharfe@lsrfire.ath.cx
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22011>

Rene Scharfe wrote :

> | tar: pax_global_header: Unknown file type 'g', extracted as normal

> You can ignore or delete that file.  It is a pax extended global header,

Yes, I knew I could ignore the file right away. I figured it was due
to some new feature of GNU tar.

> was released on 2001-08-29, by the way.  May I ask what operating system
> and version you are using?

Mandrake 8,1 for i586. I had not encountered problems with GNU tar 1.13.22
before. A quick google showed this was not a rare problem, but nothing in
the tarball for git-1.4.0 mentioned this problem. I understand that it may
be a rare or nonexistant problem for the target audience of "git", but just
a sentence or two would be enough clue to help out those who may need it.

> It took me a while to realize that your diffs are reversed.  It's too

Yes, unfortunately, I did reverse it, but even patch can handle that.

> A good first exercise would be to fetch the git repository, edit Makefile
> and commit your change, and then send a patch to this list -- all using

A good suggestion, but I am a newbie as you can tell, and would prefer to
play in a sandbox for some time before I would attempt it. Of more concern
to me now is a failed test :

> * FAIL 12: apply diff between 3 and 2
>        git-apply <diff.3-2 && diff frotz.2 frotz
> * failed 2 among 12 test(s)
> make[1]: *** [t4101-apply-nonl.sh] Error 1

All the other tests worked which is great. Thanks for your reply. Shalom,
Michael
