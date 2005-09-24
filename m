From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to make Cogito use git-fetch-pack?
Date: Fri, 23 Sep 2005 19:04:24 -0700
Message-ID: <4334B428.7020608@zytor.com>
References: <43347F98.6020101@zytor.com> <20050924011912.GK10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 04:04:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIzOy-0001RY-Hd
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 04:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVIXCE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 22:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVIXCE3
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 22:04:29 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:23234 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751360AbVIXCE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 22:04:28 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8O24OJv010751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2005 19:04:25 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050924011912.GK10255@pasky.or.cz>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9224>

Petr Baudis wrote:
> Dear diary, on Sat, Sep 24, 2005 at 12:20:08AM CEST, I got a letter
> where "H. Peter Anvin" <hpa@zytor.com> told me that...
> 
>>Is there any way to make Cogito use git-fetch-pack instead of 
>>git-ssh-fetch?  git+ssh:// seems to invoke the latter.
> 
> I just added git+packed+ssh:// to be used for this purpose.
> 

Since git tends to use "pack" (e.g. git-fetch-pack) I'd suggest use 
git+pack+ssh:// instead.  It's shorter, too.

	-hpa
