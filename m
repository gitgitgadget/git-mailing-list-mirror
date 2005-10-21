From: Ben Lau <benlau@ust.hk>
Subject: Re: How to create a new branch based on a tag?
Date: Sat, 22 Oct 2005 00:15:29 +0800
Message-ID: <43591421.9030400@ust.hk>
References: <435901F7.9020509@ust.hk> <46a038f90510202037l7dd40271qcc0634295e092068@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 06:17:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESoJU-0008A8-H2
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 06:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVJUEPZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 00:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVJUEPZ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 00:15:25 -0400
Received: from mx3.ust.hk ([143.89.13.11]:525 "EHLO mx3.ust.hk")
	by vger.kernel.org with ESMTP id S964818AbVJUEPZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 00:15:25 -0400
Received: from [143.89.135.159] (atz113.rd.ust.hk [143.89.135.159])
	by mx3.ust.hk (8.12.11/8.12.11) with ESMTP id j9L4EsND096329;
	Fri, 21 Oct 2005 12:14:55 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510202037l7dd40271qcc0634295e092068@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10416>

Martin Langhoff wrote:

>On 10/22/05, Ben Lau <benlau@ust.hk> wrote:
>  
>
>>Hi,
>>
>>   I would like to create a branch of my own work based on a specific
>>kernel version(i.e
>>v2.6.11). I tried with:
>>
>> > git-branch my2.6.11 v2.6.11
>>error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a
>>commit
>>fatal: Needed a single revision
>>    
>>
>
>What you're after is
>
>   git-rev-parse --verify <tagname>^0  > .refs/heads/mynewbranch
>
>"branches" are very lightweight -- it's a ref containing the SHA1 of
>the commit you want it to be at. So if you find the SHA1 of the commit
>in gitk or wherever, just
>
>  echo SHA1 > .refs/heads/mynewbranch
>
>and you're sorted. Do git-checkout to switch to it.
>
>cheers,
>
>
>martin
>  
>
The command complains:

   >git-rev-parse --verify v2.6.11^
   error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not 
a commit
   fatal: Needed a single revision

I think it need another way to convert a tag/tree object into a commit ?
