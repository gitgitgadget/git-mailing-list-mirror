From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to make Cogito use git-fetch-pack?
Date: Mon, 26 Sep 2005 11:10:33 -0700
Message-ID: <43383999.8090508@zytor.com>
References: <43347F98.6020101@zytor.com> <20050924011912.GK10255@pasky.or.cz> <4334B428.7020608@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 20:12:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJxRG-0003jd-Ns
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 20:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVIZSKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 14:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVIZSKu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 14:10:50 -0400
Received: from terminus.zytor.com ([209.128.68.124]:23471 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932454AbVIZSKt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 14:10:49 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8QIAZ0q025186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Sep 2005 11:10:35 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4334B428.7020608@zytor.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9318>

H. Peter Anvin wrote:
> Petr Baudis wrote:
> 
>> Dear diary, on Sat, Sep 24, 2005 at 12:20:08AM CEST, I got a letter
>> where "H. Peter Anvin" <hpa@zytor.com> told me that...
>>
>>> Is there any way to make Cogito use git-fetch-pack instead of 
>>> git-ssh-fetch?  git+ssh:// seems to invoke the latter.
>>
>>
>> I just added git+packed+ssh:// to be used for this purpose.
>>
> 
> Since git tends to use "pack" (e.g. git-fetch-pack) I'd suggest use 
> git+pack+ssh:// instead.  It's shorter, too.
> 

I thought some more about this, and realized that it really doesn't make 
sense for there to be another name for this.  Simply put, git+ssh:// 
requires ssh access and git to be present on the other side, and within 
those parameters it should use whatever access method is most effective. 
Thus, having a separate URL type only makes sense if something is 
fundamentally and user-visibly different between the two.

	-hpa
