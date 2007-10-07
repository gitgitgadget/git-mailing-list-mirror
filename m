From: Marko Macek <Marko.Macek@gmx.net>
Subject: Re: Question about "git commit -a"
Date: Sun, 07 Oct 2007 08:12:27 +0200
Message-ID: <470878CB.2010609@gmx.net>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com> <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com> <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com> <Pine.LNX.4.64.0710042209410.4174@racer.site> <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com> <4705FB52.3030208@op5.se> <1191599763.7117.18.camel@hinata.boston.redhat.com> <20071005211011.GB25125@potapov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Andreas Ericsson <ae@op5.se>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	andyparkins@gmail.com, torvalds@linux-foundation.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 08:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IePPc-0005hq-8w
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 08:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbXJGGOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 02:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXJGGOk
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 02:14:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:60979 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751121AbXJGGOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 02:14:39 -0400
Received: (qmail invoked by alias); 07 Oct 2007 06:14:37 -0000
Received: from BSN-210-250-102.dial-up.dsl.siol.net (EHLO [192.168.2.7]) [195.210.250.102]
  by mail.gmx.net (mp050) with SMTP; 07 Oct 2007 08:14:37 +0200
X-Authenticated: #420190
X-Provags-ID: V01U2FsdGVkX1+vI/AhUHev0+2CMpctWHPrLE/QVFZJwXlHY+Sx/C
	hNwyEyRkKXXMb3
User-Agent: Thunderbird 2.0.0.5 (X11/20070716)
In-Reply-To: <20071005211011.GB25125@potapov>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60171>

Dmitry Potapov wrote:
> You don't. Even with 'commit -a' there is no guarantee that the
> result will compile, because you can forget to add a new file.

Actually, it would be a good idea for commit to report an error if there
are any new files that have not been 'added' or 'ignored' (or even 
if there are missing files that have not been 'deleted'.

Perhaps I'll add this to my git wrapper scripts.

Even for normal git-commit it might be nice to report an error if there are any
unstaged files unless -a or -i option is specified.

Mark
