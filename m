From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: use binmode(STDOUT) in git-status
Date: Tue, 29 Nov 2005 23:12:21 +0100
Message-ID: <20051129221221.GC3033@steel.home>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com> <438B2859.6060109@zytor.com> <Pine.LNX.4.63.0511281700100.11362@wbgn013.biozentrum.uni-wuerzburg.de> <438B2B90.9010500@zytor.com> <Pine.LNX.4.63.0511281756001.11697@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 23:17:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDiG-0008VS-PW
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVK2WMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVK2WMe
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:12:34 -0500
Received: from devrace.com ([198.63.210.113]:1034 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964781AbVK2WMd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:12:33 -0500
Received: from tigra.home (p54A0CEB2.dip.t-dialin.net [84.160.206.178])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jATMCN2P022119;
	Tue, 29 Nov 2005 16:12:23 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EhDi1-0002js-00; Tue, 29 Nov 2005 23:12:21 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EhDi1-00037C-J6; Tue, 29 Nov 2005 23:12:21 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511281756001.11697@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12967>

Johannes Schindelin, Mon, Nov 28, 2005 17:56:58 +0100:
> > if you're running Cygwin, wouldn't Cygwin's Perl make a lot more sense?
> 
> I thought so, too, but I guess there's a reason that Activision's perl was 
> used.

the reason were incompatible scripts (notably, the ones expecting crlf).
