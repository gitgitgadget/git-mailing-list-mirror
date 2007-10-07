From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about "git commit -a"
Date: Sun, 7 Oct 2007 17:26:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710071724330.4174@racer.site>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
 <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
 <Pine.LNX.4.64.0710042209410.4174@racer.site>
 <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
 <4705FB52.3030208@op5.se> <1191599763.7117.18.camel@hinata.boston.redhat.com>
 <20071005211011.GB25125@potapov> <470878CB.2010609@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Andreas Ericsson <ae@op5.se>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	andyparkins@gmail.com, torvalds@linux-foundation.org
To: Marko Macek <Marko.Macek@gmx.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:27:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeYyZ-0003qO-Ei
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbXJGQ1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754111AbXJGQ1W
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:27:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:59571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753652AbXJGQ1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:27:22 -0400
Received: (qmail invoked by alias); 07 Oct 2007 16:27:20 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp001) with SMTP; 07 Oct 2007 18:27:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1858PIv59M53Jdz4kVEjXwtd/DyNJZR+zFa4H9sym
	pA+ldc22QSxgHN
X-X-Sender: gene099@racer.site
In-Reply-To: <470878CB.2010609@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60194>

Hi,

On Sun, 7 Oct 2007, Marko Macek wrote:

> Dmitry Potapov wrote:
> > You don't. Even with 'commit -a' there is no guarantee that the
> > result will compile, because you can forget to add a new file.
> 
> Actually, it would be a good idea for commit to report an error if there 
> are any new files that have not been 'added' or 'ignored' (or even if 
> there are missing files that have not been 'deleted'.

It is no error.

And it is reported.  That is the whole _point_ of having git status output 
both changed-but-not-staged and untracked files.

Of course, you only see that when you do not provide the message within 
the editor, but from the command line.  But then chances are that your 
message is too short anyway.

Ciao,
Dscho
