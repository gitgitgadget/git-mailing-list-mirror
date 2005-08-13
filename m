From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Cloning speed comparison
Date: Sat, 13 Aug 2005 16:25:19 -0700
Message-ID: <42FE815F.8050201@zytor.com>
References: <20050813015402.GC20812@pasky.ji.cz> <Pine.LNX.4.58.0508121908180.3295@g5.osdl.org> <20050813031025.GE20812@pasky.ji.cz> <Pine.LNX.4.58.0508122021490.19049@g5.osdl.org> <42FD8224.9020700@zytor.com> <Pine.LNX.4.58.0508122223280.19049@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 01:28:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E45Pg-0006xN-Eh
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 01:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVHMXZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 19:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVHMXZx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 19:25:53 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:7329 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932405AbVHMXZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 19:25:52 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j7DNPYJv027674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 13 Aug 2005 16:25:35 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508122223280.19049@g5.osdl.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 12 Aug 2005, H. Peter Anvin wrote:
> 
>>Running it over ssh would be a good way to do authentication...
> 
> 
> Well, if you have ssh as an option, you don't need git-daemon any more, 
> since the protocol that git-daemon does runs quite well over ssh on its 
> own...
> 
> The only point of git-daemon really is when you don't have ssh access (ie
> you may want to give people a limited interface, but not full ssh). Ie
> as-is, it's only for anonymous reads of a git archive, but it obviously
> _could_ do more.
> 

Okay.  So use git-daemon for the anonymous users, and run the git 
protocol over ssh for writing.  Seems easy enough for me.

	-hpa
