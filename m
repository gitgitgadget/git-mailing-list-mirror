From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 23:01:48 +0100
Message-ID: <20060131220148.GA19411@steel.home>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home> <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 23:02:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F43Zk-0003Lt-AV
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 23:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWAaWCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 17:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWAaWCJ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 17:02:09 -0500
Received: from devrace.com ([198.63.210.113]:64516 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751567AbWAaWCH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 17:02:07 -0500
Received: from tigra.home (p54A07FD9.dip.t-dialin.net [84.160.127.217])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0VM1o9h078789;
	Tue, 31 Jan 2006 16:01:51 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F43ZM-0004N9-00; Tue, 31 Jan 2006 23:01:48 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F43ZM-00056w-0p; Tue, 31 Jan 2006 23:01:48 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15354>

Linus Torvalds, Tue, Jan 31, 2006 22:25:08 +0100:
> > I use git in cygwin for a project with more then 17k files (almost
> > 6M lines).  It's real slow on ntfs (on 3.2Mhz PIV!)
> ...
> So we could speed it up on cygwin (and yes, it would speed git up a lot 
> even on Linux, but since the cached lstat() case is so fast anyway, I 
> doubt a lot of Linux users care - the biggest win would be on a cold-cache 
> tree).  But it would require that you explicitly _mark_ the files you edit 
> some way.

I'd hate to have to do that. The project in question is just stuffed
up beyond all reason, windows' VFS is a sorry piece of junk, and I
care much more about how comfortable the tool is.

> ...
> For small projects (or big projects with fairly few files), it really 
> shouldn't matter. Your 17k files example is hopefully fairly rare..

I'd say it is fairly common. It's what driven by paranoia and
suffering from chronic undereducation projects in big companies
usually end up with. Frequently right from the start...
