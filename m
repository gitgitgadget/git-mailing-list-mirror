From: Olga Pshenichnikova <olga@ip-5.ru>
Subject: Re: How to include just some subdirectory excluding all envelop tree
Date: Tue, 8 Mar 2016 00:14:07 +0300
Message-ID: <56DDEF1F.7040604@ip-5.ru>
References: <56DDD020.2050101@ip-5.ru> <20160307210608.GA29312@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Mon Mar 07 22:14:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad2To-0003Sb-Jy
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 22:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbcCGVON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 16:14:13 -0500
Received: from [178.62.228.239] ([178.62.228.239]:59880 "EHLO server.ip-5.ru"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbcCGVOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 16:14:12 -0500
Received: from [10.143.26.93] (unknown [31.40.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by server.ip-5.ru (Postfix) with ESMTPSA id 230A310169E;
	Tue,  8 Mar 2016 00:14:08 +0300 (MSK)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160307210608.GA29312@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288402>

Thank you very much!
The exclamation mark solves my problem.
I can not create repository inside /a, because I need control /b also )

On 03/08/2016 12:06 AM, Kevin Daudt wrote:
> On Mon, Mar 07, 2016 at 10:01:52PM +0300, Olga Pshenichnikova wrote:
>> I have some tree structure:
>>
>> /a
>> /a/a
>> /a/b
>> ..
>> /a/z
>> /b
>> .. (thousands of folders)
>> /z
>>
>> How can I control just /a/a folder?
>> What exclude file should be?
>>
>> The way we use now is:
>>
>> /a/*
>> /b/
>> .. (thousands of folders)
>> /z/
>> !/a/a
>>
>> But it is very not nice looking and hard for maintenance...
> Don't know your usecase, but isn't it easier to just create the repository
> in /a/a? Then you won't have to exlude anything.
>
> If you must, you can just use something like:
>
>   *
>   !/a
>   /a/*
>   !/a/a
