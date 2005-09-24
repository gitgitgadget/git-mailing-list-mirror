From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sat, 24 Sep 2005 14:47:35 -0700
Message-ID: <7vd5myuoi0.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 23:48:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJHrx-0001xK-Q4
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 23:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVIXVrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 17:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVIXVrj
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 17:47:39 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1197 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750765AbVIXVri (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 17:47:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050924214738.LJNJ29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Sep 2005 17:47:38 -0400
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain> (Davide
	Libenzi's message of "Sat, 24 Sep 2005 14:28:29 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9249>

Davide Libenzi <davidel@xmailserver.org> writes:

> On Sat, 24 Sep 2005, Junio C Hamano wrote:
>
>> Making really really core part usable on Windows would not need
>> this, but there is another thing: .git/HEAD symlink.
>
> Starting from Win2k, they *finally* added:
>
> http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/createhardlink.asp

It talks about "a hard link".  Can we readlink it?
