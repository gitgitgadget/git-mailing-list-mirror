From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: Solaris cloning woes partly diagnosed
Date: Sun, 02 Apr 2006 12:10:22 -0700
Message-ID: <29336.1144005022@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.64.0604021118210.3050@g5.osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 02 21:10:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ7xx-00028q-V2
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 21:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWDBTKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 15:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWDBTKX
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 15:10:23 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:64409 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751283AbWDBTKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 15:10:22 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k32JAMgH029338
	for <git@vger.kernel.org>; Sun, 2 Apr 2006 12:10:22 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k32JAMqK029337
	for <git@vger.kernel.org>; Sun, 2 Apr 2006 12:10:22 -0700 (PDT)
To: git@vger.kernel.org
In-reply-to: <Pine.LNX.4.64.0604021118210.3050@g5.osdl.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18277>

And Linus Torvalds writes:
 - 
 - I'd be willing to bet that it's the fact that we take signals.

Unfortunately, I'm too busy to check into this, but I've
run into similar problems in the past.  Just takes a busy 
file server.

 - We do, for example, expect that regular file writing not do that. At least 
 - "write_sha1_from_fd()" will just do a "write()" without testing the error 
 - return, [...]

There is an xwrite in git-compat-util.h...

Jason
