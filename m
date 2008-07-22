From: Johan Herland <johan@herland.net>
Subject: Re: Git Documentation
Date: Tue, 22 Jul 2008 09:17:57 +0200
Message-ID: <200807220917.57363.johan@herland.net>
References: <d411cc4a0807212035v68c2ed95m93b77c1e61cfec9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:22:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCCb-0006Ia-2X
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbYGVHVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYGVHVa
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:21:30 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35777 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbYGVHV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:21:29 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K4E0030LCFSG900@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 22 Jul 2008 09:21:28 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K4E00GA1C9X5T40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 22 Jul 2008 09:17:57 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K4E00IW1C9X4O83@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 22 Jul 2008 09:17:57 +0200 (CEST)
In-reply-to: <d411cc4a0807212035v68c2ed95m93b77c1e61cfec9e@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89456>

On Tuesday 22 July 2008, Scott Chacon wrote:
> If anyone has any tips on how they think git should be taught, issues
> they are asked a lot, problems newbies tend to have, something they
> wish there were a screencast for or was better documented, etc -
> please do contact me so I can incorporate it.

You should at least take a look at this thread:

http://thread.gmane.org/gmane.comp.version-control.git/88698

(even though it goes off-topic after a while...)

> If anyone has any tips on how they think git should be taught...

It seems there are primarily two ways to teach Git:

1. Top-down: Start with simple use cases and commands. Teach people a 
minimal, but necessary set of porcelain commands to get them started. Stay 
_far_ away from plumbing commands and most of the command options.

2. Bottom-up: Start with how Git structures the data. Talk about blobs, 
trees, commits, refs, how everything is connected, and how various Git 
commands query and manipulate this structure. This _may_ involve a fair 
amount of plumbing commands, especially when discovering how the more 
complicated high-level commands manipulate the structure.

Some people seem to prefer the first approach, other people prefer the other 
approach. Both paths lead to enlightenment ;). In many cases a bit of both 
may be useful. HOWEVER, I think it is _very_ important to keep in mind that 
these are two _different_ approaches, and the contexts in which they are 
taught should be kept separate. I would almost suggest splitting your 
website down the middle and make the difference between top-down and 
bottom-up immediately visible with, say, a different background color, or 
something else that immediately tells the user what "track" they are 
following...


BTW, I think what you're doing is good and important (and I've already 
enjoyed some of your gitcasts). Keep up the good work! :)


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
