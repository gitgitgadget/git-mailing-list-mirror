From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: should core.autocrlf=true be the default on Windows?
Date: Sun, 12 Aug 2007 11:36:35 +0200
Message-ID: <F5024D9F-B008-4C14-B36B-A2E8BEFD0FE4@zib.de>
References: <7816DAAF-53CB-468C-9597-36AA94AC6476@zib.de> <84CFEBB5D7FE48FF86FEF3289C8DDAA8@ntdev.corp.microsoft.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 11:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK9rj-0002tQ-DF
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 11:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757755AbXHLJfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 05:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756436AbXHLJfv
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 05:35:51 -0400
Received: from mailer.zib.de ([130.73.108.11]:37111 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274AbXHLJfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 05:35:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7C9Zl0p020205;
	Sun, 12 Aug 2007 11:35:48 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1ff88.pool.einsundeins.de [77.177.255.136])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7C9ZkUV015480
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 12 Aug 2007 11:35:47 +0200 (MEST)
In-Reply-To: <84CFEBB5D7FE48FF86FEF3289C8DDAA8@ntdev.corp.microsoft.com>
X-Priority: 3
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55668>


On Aug 12, 2007, at 7:36 AM, Dmitry Kakurin wrote:

> Please keep in mind that msysgit is targeting developers who want  
> to contribute to MinGW port of git.

Why that?. In my opinion msysgit is already the best git you can
get on Windows. It's a one click, self-contained installation,
with the most up-to-date git. The installation is kept separate
from cygwin, which saves a lot of trouble with textmode/binmode.
It's easy to get started, easy to contribute fixes, easy to upgrade
to a new version. It should be polished a bit, but then I would
announce it as _the_ default way of installing git on Windows.


> Since building and editing happens in MinGW environment the LF-only  
> default seems reasonable.

I have my msysgit set to autocrlf=true and have no problems.
It's even better now, because I can open files in Windows
programs without problems.


> On the other hand, setup for end-users should have it as default, I  
> agree.

But our end-users are developers! We should leverage on that and make
msysgit the 'end-user' installation. Developers tend to be interested
in fixing problems with their working environment. We should provide
them a _very_ easy way of submitting their fixes and improvements
back to msysgit, e.g. via mob branch. This could speed up the Windows
porting effort tremendously.

I also think we should work in the same environment that we propose
to our end-users. If we believe end-users should work with  
autocrlf=true,
we should do so as well, just to be sure that our recommendation is
the right one.


> Please report this issue here: http://code.google.com/p/msysgit/ 
> issues/list

done.

	Steffen
