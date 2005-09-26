From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sun, 25 Sep 2005 21:57:55 -0700
Message-ID: <7vwtl4jui4.fsf@assigned-by-dhcp.cox.net>
References: <ud5mznc1x.fsf@peter-b.co.uk>
	<Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
	<Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
	<Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
	<Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
	<Pine.LNX.4.63.0509241129300.31327@localhost.localdomain>
	<7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509241426240.16554@localhost.localdomain>
	<Pine.LNX.4.58.0509241524270.3308@g5.osdl.org>
	<Pine.LNX.4.63.0509241540170.16554@localhost.localdomain>
	<1o29so2d1zd0i$.1d0cf386vluxi.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 06:58:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJl45-0000gx-Q7
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 06:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVIZE57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 00:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVIZE57
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 00:57:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8145 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932376AbVIZE56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 00:57:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926045758.WWLW9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 00:57:58 -0400
To: Giuseppe Bilotta <bilotta78@hotpop.com>
In-Reply-To: <1o29so2d1zd0i$.1d0cf386vluxi.dlg@40tude.net> (Giuseppe Bilotta's
	message of "Sun, 25 Sep 2005 21:59:42 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9301>

Giuseppe Bilotta <bilotta78@hotpop.com> writes:

>> Hah, didn't know this one. Requiring LongHorn is pretty strict though ;)
>
> However, it might be possible to use .lnk files, which would work on
> both NTFS and FAT32, and even under Win9x.

Possibly, but it is a moot point now.

When textual "symbolic refs" support becomes mature, we will use
it on boxes without symbolic links to express .git/HEAD.
