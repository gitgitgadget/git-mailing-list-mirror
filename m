From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Initial AIX portability fixes.
Date: Tue, 06 Dec 2005 16:07:16 -0800
Message-ID: <21075.1133914036@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.63.0512070055430.5888@wbgn013.biozentrum.uni-wuerzburg.de>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 01:08:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjmqB-00067m-Ut
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 01:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVLGAHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 19:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVLGAHV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 19:07:21 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:62617 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932665AbVLGAHU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 19:07:20 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB707H6d021077;
	Tue, 6 Dec 2005 16:07:17 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB707GAD021076;
	Tue, 6 Dec 2005 16:07:17 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-reply-to: <Pine.LNX.4.63.0512070055430.5888@wbgn013.biozentrum.uni-wuerzburg.de> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13306>

And Johannes Schindelin writes:
 - Why not enclose the #define in #ifndef/#endif, and do the real magic in 
 - the Makefile? Within the AIX clause:
 - 	ALL_CFLAGS += -D_XOPEN_SOURCE=500 -XOPEN_SOURCE_EXTENDED=1

Because other files do _not_ compile when given those options.
I'm going for minimal changes to the existing structure; the
#define for glibc2 has been there a long, long time.  Yes, it
probably can be done better, but these are 1.0rc versions...

Jason
