X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-fetch not working?
Date: Tue, 24 Oct 2006 14:10:11 -0700
Message-ID: <453E8133.8020707@zytor.com>
References: <200610242100.52671.andyparkins@gmail.com> <20061024205428.GI20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 24 Oct 2006 21:11:15 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	ftpadmin@kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061024205428.GI20017@pasky.or.cz>
X-Virus-Scanned: ClamAV 0.88.4/2092/Tue Oct 24 11:25:03 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30014>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcTXr-0002Hx-3i for gcvg-git@gmane.org; Tue, 24 Oct
 2006 23:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965182AbWJXVKj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWJXVKj
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 17:10:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:36840 "EHLO
 terminus.zytor.com") by vger.kernel.org with ESMTP id S965182AbWJXVKi (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 17:10:38 -0400
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
 (authenticated bits=0) by terminus.zytor.com (8.13.7/8.13.7) with ESMTP id
 k9OLAE6S016116 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Tue, 24 Oct 2006 14:10:15 -0700
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:
>   Hi,
> 
> Dear diary, on Tue, Oct 24, 2006 at 10:00:45PM CEST, I got a letter
> where Andy Parkins <andyparkins@gmail.com> said that...
>> $ cat .git/remotes/origin 
>> URL: git://git.kernel.org/pub/scm/git/git.git
>> Pull: refs/heads/master:refs/heads/up/master
>> Pull: refs/heads/next:refs/heads/up/next
>> Pull: refs/heads/maint:refs/heads/up/maint
>> Pull: +refs/heads/pu:refs/heads/up/pu
>>
>> $ git fetch
>> fatal: unexpected EOF
>> Failed to find remote refs
>>
>> $ ping -c1 git.kernel.org
>> PING zeus-pub.kernel.org (204.152.191.5) 56(84) bytes of data.
>> 64 bytes from zeus-pub1.kernel.org (204.152.191.5): icmp_seq=1 ttl=54 time=182 
>> ms
>>
>> Am I doing something wrong?
> 
>   nope, I'm getting it as well (hey I know about broken git.kernel.org
> in an hour at most now because of the repo.or.cz cronjobs ;) -
> git-daemon at the kernel.org machines seems to be broken.
> 

Nope, just tripping the load limit.  git1.kernel.org has had loads over 
400 today.  Oddly enough, the load on git2.kernel.org is in the low teens.

	-hpa
