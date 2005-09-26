From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Mon, 26 Sep 2005 15:03:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0509261502080.1716@localhost.localdomain>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
 <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain>
 <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain>
 <Pine.LNX.4.58.0509241524270.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509241540170.16554@localhost.localdomain>
 <1o29so2d1zd0i$.1d0cf386vluxi.dlg@40tude.net> <Pine.LNX.4.63.0509252203510.817@localhost.localdomain>
 <43386E0A.6010607@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:04:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK13i-0000ml-51
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVIZWCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVIZWCq
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:02:46 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:917 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932339AbVIZWCq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 18:02:46 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by xmailserver.org with [XMail 1.22 ESMTP Server]
	id <S1A1495> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 26 Sep 2005 15:02:15 -0700
X-X-Sender: davide@localhost.localdomain
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43386E0A.6010607@zytor.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9341>

On Mon, 26 Sep 2005, H. Peter Anvin wrote:

> Davide Libenzi wrote:
>> On Sun, 25 Sep 2005, Giuseppe Bilotta wrote:
>> 
>>> However, it might be possible to use .lnk files, which would work on
>>> both NTFS and FAT32, and even under Win9x.
>> 
>> 
>> The .lnk files are a shell thing, not an OS one. Try to open()+read() a 
>> .lnk file and look at what you get ...
>> 
>
> Except that Cygwin uses them transparently, so if you do open() and read() 
> under Cygwin they work as expected.

With Cygwin you don't even need .lnk files, since it already supports all 
the Unix symlinks APIs/cmds. The discussion born thinking about a native 
Win32 interface, w/out the Cygwin crud in it.


- Davide
