From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Cloning speed comparison
Date: Fri, 12 Aug 2005 22:16:20 -0700
Message-ID: <42FD8224.9020700@zytor.com>
References: <20050813015402.GC20812@pasky.ji.cz> <Pine.LNX.4.58.0508121908180.3295@g5.osdl.org> <20050813031025.GE20812@pasky.ji.cz> <Pine.LNX.4.58.0508122021490.19049@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 07:17:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3oOO-0001eB-00
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 07:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVHMFQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 01:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVHMFQz
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 01:16:55 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:53149 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751292AbVHMFQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 01:16:54 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j7D5GVJv020367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Aug 2005 22:16:35 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508122021490.19049@g5.osdl.org>
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
>>BTW, is the pack protocol flexible enough to be extended to support
>>pushing?
> 
> The _protocol_ could handle it, but you obviously need some kind of secure 
> authentication, and quite frankly, one of the selling points on git-daemon 
> right now is that it's all read-only and very simple and there should be 
> no security issues because it will never write anything at all.
> 

Running it over ssh would be a good way to do authentication...

	-hpa
