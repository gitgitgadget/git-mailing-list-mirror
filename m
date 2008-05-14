From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: [PATCH] Rephrased git-describe description
Date: Wed, 14 May 2008 22:01:42 +0200
Message-ID: <482B4526.9020905@dirk.my1.cc>
References: <1210789855-29413-1-git-send-email-ian.hilt@gmail.com> <7v7idwoh9m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ian Hilt <ian.hilt@gmail.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 22:03:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwNBz-0004Rf-Kd
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 22:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbYENUCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 16:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761118AbYENUCA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 16:02:00 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:48580 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758608AbYENUB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 16:01:58 -0400
Received: from [84.176.107.100] (helo=[192.168.2.100])
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JwNAW-0006w7-28; Wed, 14 May 2008 22:01:44 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7v7idwoh9m.fsf@gitster.siamese.dyndns.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82141>

While we're talking about 'git-describe': I always wondered what the '-g'
in front of the sha1 stands for when I issue 'git describe'. Is it for 
'generation'
or what? Actually I'd appreciate if that '-g' would be dropped as it is of
no use but I also recognize that git-describe is one of the plumbing tools.
I'm just curious.
  Dirk

Junio C Hamano schrieb:
> Ian Hilt <ian.hilt@gmail.com> writes:
>
>   
>> git-describe: Make description more readable.
>>     
>
> Thanks, both.  I think the above is meant to be on the Subject: line, and
> the text certainly is more readable.
>
>   
>> Signed-off-by: Ian Hilt <ian.hilt@gmail.com>
>> ---
>>  Documentation/git-describe.txt |    7 ++++---
>>  1 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
>> index d9aa2f2..69e1ab7 100644
>> --- a/Documentation/git-describe.txt
>> +++ b/Documentation/git-describe.txt
>> @@ -13,9 +13,10 @@ SYNOPSIS
>>  DESCRIPTION
>>  -----------
>>  The command finds the most recent tag that is reachable from a
>> -commit, and if the commit itself is pointed at by the tag, shows
>> -the tag.  Otherwise, it suffixes the tag name with the number of
>> -additional commits and the abbreviated object name of the commit.
>> +commit.  If the tag points to the commit, then only the tag is
>> +shown.  Otherwise, it suffixes the tag name with the number of
>> +additional commits on top of the tagged object and the
>> +abbreviated object name of the most recent commit.
>>     
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
