From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Mon, 26 Sep 2005 13:00:18 +0200
Message-ID: <11uvm3it7p3tu.1wbs1o8fvs02r.dlg@40tude.net>
References: <ud5mznc1x.fsf@peter-b.co.uk> <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org> <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org> <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain> <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org> <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain> <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain> <Pine.LNX.4.58.0509241524270.3308@g5.osdl.org> <Pine.LNX.4.63.0509241540170.16554@localhost.localdomain> <1o29so2d1zd0i$.1d0cf386vluxi.dlg@40tude.net> <Pine.LNX.4.63.0509252203510.817@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 26 13:05:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJqlj-0000C0-Ft
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 13:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVIZLDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 07:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbVIZLDa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 07:03:30 -0400
Received: from main.gmane.org ([80.91.229.2]:53663 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750787AbVIZLD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 07:03:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EJqjW-00081o-L6
	for git@vger.kernel.org; Mon, 26 Sep 2005 13:01:18 +0200
Received: from oblomov.dmi.unict.it ([151.97.252.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2005 13:01:18 +0200
Received: from bilotta78 by oblomov.dmi.unict.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2005 13:01:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oblomov.dmi.unict.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9304>

On Sun, 25 Sep 2005 22:05:29 -0700 (PDT), Davide Libenzi wrote:

> On Sun, 25 Sep 2005, Giuseppe Bilotta wrote:
> 
>> However, it might be possible to use .lnk files, which would work on
>> both NTFS and FAT32, and even under Win9x.
> 
> The .lnk files are a shell thing, not an OS one. Try to open()+read() a 
> .lnk file and look at what you get ...

Well, sure. I wasn't thinking about just substituting .lnk files for
symlinks, but that's the closest thing you can get on Windows,
currently, so maybe supporting this kind of thing would be the best
approach.

-- 
Giuseppe "Oblomov" Bilotta

[W]hat country can preserve its liberties, if its rulers are not
warned from time to time that [the] people preserve the spirit of
resistance? Let them take arms...The tree of liberty must be
refreshed from time to time, with the blood of patriots and
tyrants.
	-- Thomas Jefferson, letter to Col. William S. Smith, 1787
