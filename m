From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sun, 25 Sep 2005 21:59:42 +0200
Message-ID: <1o29so2d1zd0i$.1d0cf386vluxi.dlg@40tude.net>
References: <ud5mznc1x.fsf@peter-b.co.uk> <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org> <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org> <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain> <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org> <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain> <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain> <Pine.LNX.4.58.0509241524270.3308@g5.osdl.org> <Pine.LNX.4.63.0509241540170.16554@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 26 06:52:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJkxd-0007Wi-2C
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 06:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVIZEvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 00:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVIZEvZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 00:51:25 -0400
Received: from main.gmane.org ([80.91.229.2]:5014 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932375AbVIZEvY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 00:51:24 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EJkwU-0007Ks-6Z
	for git@vger.kernel.org; Mon, 26 Sep 2005 06:50:18 +0200
Received: from host-84-221-19-69.cust-adsl.tiscali.it ([84.221.19.69])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2005 06:50:18 +0200
Received: from bilotta78 by host-84-221-19-69.cust-adsl.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2005 06:50:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-19-69.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9300>

On Sat, 24 Sep 2005 15:41:27 -0700 (PDT), Davide Libenzi wrote:

> On Sat, 24 Sep 2005, Linus Torvalds wrote:
> 
>>
>>
>> On Sat, 24 Sep 2005, Davide Libenzi wrote:
>>>
>>> http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/createhardlink.asp
>>
>> Don't you mean
>>
>> 	http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/createsymboliclink.asp
>>
>> rather?
>>
>> It mentions longhorn.
> 
> Hah, didn't know this one. Requiring LongHorn is pretty strict though ;)

However, it might be possible to use .lnk files, which would work on
both NTFS and FAT32, and even under Win9x.

-- 
Giuseppe "Oblomov" Bilotta

"I weep for our generation" -- Charlie Brown
