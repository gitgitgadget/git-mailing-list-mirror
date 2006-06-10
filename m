From: fork0@t-online.de (Alex Riesen)
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Sat, 10 Jun 2006 23:30:51 +0200
Message-ID: <20060610213051.GB5825@steel.home>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 23:31:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpB35-0002et-Dr
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 23:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWFJVbM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 17:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWFJVbM
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 17:31:12 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:12427 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030508AbWFJVbL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 17:31:11 -0400
Received: from fwd35.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1FpB2o-00027N-02; Sat, 10 Jun 2006 23:30:58 +0200
Received: from tigra.home (bLHwVqZ-QeFfUe11E3lyZx1RvzjzNwQ5HmjK3M-eCcM+m3pxwBK2Zx@[84.160.94.32]) by fwd35.sul.t-online.de
	with esmtp id 1FpB2n-0QT5sW0; Sat, 10 Jun 2006 23:30:57 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E87D9277B5;
	Sat, 10 Jun 2006 23:30:51 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FpB2h-0002wh-D7; Sat, 10 Jun 2006 23:30:51 +0200
To: "Post, Mark K" <mark.post@eds.com>
Content-Disposition: inline
In-Reply-To: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
User-Agent: Mutt/1.5.6i
X-ID: bLHwVqZ-QeFfUe11E3lyZx1RvzjzNwQ5HmjK3M-eCcM+m3pxwBK2Zx
X-TOI-MSGID: 08913657-7e3f-4c6c-9e07-85a52b490f21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21621>

Post, Mark K, Fri, Jun 09, 2006 22:52:22 +0200:
> Since umask isn't an environment variable, per se, I'm not sure how this
> will change anything.

$ ssh -V
OpenSSH_4.2p1, OpenSSL 0.9.7i 14 Oct 2005

$ man sshd
     ~/.ssh/rc
             If this file exists, it is run with /bin/sh after reading the
             environment files but before starting the user's shell or com-
             mand.  It must not produce any output on stdout; stderr must be
             used instead.  If X11 forwarding is in use, it will receive the
             "proto cookie" pair in its standard input (and DISPLAY in its
             environment).  The script must call xauth(1) because sshd will
             not run xauth automatically to add X11 cookies.

AFAIK, it was always there.
