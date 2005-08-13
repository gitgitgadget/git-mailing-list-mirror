From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Cloning speed comparison
Date: Fri, 12 Aug 2005 22:16:39 -0700
Message-ID: <42FD8237.8080400@zytor.com>
References: <20050813015402.GC20812@pasky.ji.cz> <Pine.LNX.4.58.0508121908180.3295@g5.osdl.org> <20050813031025.GE20812@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 07:17:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3oON-0001eB-D2
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 07:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVHMFRD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 01:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVHMFRD
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 01:17:03 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:55453 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751303AbVHMFRA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 01:17:00 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j7D5GpJv020376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Aug 2005 22:16:53 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050813031025.GE20812@pasky.ji.cz>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
>>>
>>In my tests, the git daemon was noticeably faster than ssh, if only 
>>because the authentication actually tends to be a big part of the overhead 
>>in small pulls.
> 
> Oh. Sounds nice, are there plans to run this on kernel.org too? (So far,
> 90% of my GIT network activity happens with kernel.org; the rest is with
> my notebook, and I want to keep that ssh.)
> 

Yes, when I get some time...

	-hpa
