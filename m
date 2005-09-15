From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Wed, 14 Sep 2005 22:20:06 -0700
Message-ID: <43290486.5020301@zytor.com>
References: <7255.1126583985@kao2.melbourne.sgi.com>  <1126674993.5681.9.camel@localhost.localdomain> <1126745323.7199.3.camel@localhost.localdomain> <Pine.LNX.4.58.0509142018410.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 07:20:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFmAa-0000fA-0d
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 07:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbVIOFUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 01:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVIOFUV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 01:20:21 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:6117 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S965159AbVIOFUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 01:20:20 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8F5K6Jv024260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Sep 2005 22:20:08 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509142018410.26803@g5.osdl.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8585>

Linus Torvalds wrote:
> 
> On Wed, 14 Sep 2005, Alejandro Bonilla Beeche wrote:
> 
>>debian:~# cd linux-2.6/
>>debian:~/linux-2.6# git log
>>/usr/local/bin/git-log-script: line 4: less: command not found
> 
> 
> A very strange Linux installation that doesn't come with "less"...
> 
> What a strange box. Anyway, that does point out that maybe the git RPM 
> spec should have "less" as a dependency. 
> 

Generally you want to honour $PAGER if it is defined.

	-hpa
