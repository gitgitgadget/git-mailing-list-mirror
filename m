From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tracking files across tree reorganizations
Date: Wed, 14 Dec 2005 15:47:53 -0800
Message-ID: <43A0AF29.6020009@zytor.com>
References: <43A08B8F.1000901@zytor.com> <20051214223656.GJ22159@pasky.or.cz> <43A0A6E1.9070903@zytor.com> <20051214234504.GL22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:50:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmgLw-0005DI-Iv
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 00:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVLNXsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 18:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVLNXsF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 18:48:05 -0500
Received: from terminus.zytor.com ([192.83.249.54]:15016 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965118AbVLNXsE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 18:48:04 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBENlwba019711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Dec 2005 15:47:59 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051214234504.GL22159@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13662>

Petr Baudis wrote:
>>>
>>>(b) If there are no notes for the given commit, we do the rename
>>>autodetection already implemented in GIT. If it yields something,
>>>we follow it.
>>
>>I don't see anything in Linus' posts that says (b) is unacceptable.
> 
>   If we do it at the walk time, not commit time - I didn't emphasize
> that in my previous mail while I should have.

Exactly.  This is the right thing to do, because it means that just 
because you made the checkin with version foo, you're forever limited to 
the capabilities of version foo.

	-hpa
