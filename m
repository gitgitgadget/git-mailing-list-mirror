From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Mon, 26 Sep 2005 15:15:17 -0700
Message-ID: <433872F5.5060807@zytor.com>
References: <ud5mznc1x.fsf@peter-b.co.uk> <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org> <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org> <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain> <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org> <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain> <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain> <Pine.LNX.4.58.0509241524270.3308@g5.osdl.org> <Pine.LNX.4.63.0509241540170.16554@localhost.localdomain> <1o29so2d1zd0i$.1d0cf386vluxi.dlg@40tude.net> <Pine.LNX.4.63.0509252203510.817@localhost.localdomain> <43386E0A.6010607@zytor.com> <Pine.LNX.4.63.0509261502080.1716@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:17:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK1G7-0004hL-J0
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVIZWPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVIZWPe
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:15:34 -0400
Received: from terminus.zytor.com ([209.128.68.124]:22714 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932352AbVIZWPd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 18:15:33 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8QMFKeV002921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Sep 2005 15:15:20 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.63.0509261502080.1716@localhost.localdomain>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9345>

Davide Libenzi wrote:
>>
>> Except that Cygwin uses them transparently, so if you do open() and 
>> read() under Cygwin they work as expected.
> 
> With Cygwin you don't even need .lnk files, since it already supports 
> all the Unix symlinks APIs/cmds. The discussion born thinking about a 
> native Win32 interface, w/out the Cygwin crud in it.
> 

Cygwin symbolic links are implemented as .lnk files on the underlying 
filesystem was my point.

	-hpaa
