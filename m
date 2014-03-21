From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH v3] rev-parse --parseopt: option argument name hints
Date: Thu, 20 Mar 2014 20:38:20 -0700
Message-ID: <532BB42C.5020505@gmail.com>
References: <532AA923.6030409@gmail.com>	<1395305092-1928-1-git-send-email-ilya.bobyr@gmail.com> <CAPig+cTGYufCtVJDxG8RUJgyMbb7c3ZdiYMuoAbhQQaitVWRnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 04:38:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQqI2-0001eF-7D
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 04:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029AbaCUDie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 23:38:34 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:42247 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146AbaCUDid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 23:38:33 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so1812660pdj.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 20:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=x/o7/E4PagtrpCLMaqV/ZWkVz/UGIVeTpNw8nd9RiEs=;
        b=RShkYd/6bK+Yxe0V58qVISN7J3SfoZkzbXZk0wxbmcfof5uSuvLQm5P/An41zoeXxC
         9MMPClIFesTa5DUmng+IuCSmU+qL3aKCsToqLzOpyDetSrt6Kei6eSVAgZdluy+ABnOP
         hAwHycVWVxkvO7jjmS0mRYZfnlS2dyZzVwQ/QbTsq7AJHUft/OS4uqGOwN9lXrD1TSpD
         Ojx8qPCj3ZEJfH8T7k0YOqlqBmYV9zAEbxkvSkR2NdBGkKZYr3PDrn/jqiWeCjFTNAfC
         qOJ8IkNFHS7KxJJonrqpoPT3oMzo3thFNvAUkkBbuIWSkGydamEt6j9Bq78SG1ZmwEGk
         YQag==
X-Received: by 10.66.13.138 with SMTP id h10mr28967594pac.148.1395373112892;
        Thu, 20 Mar 2014 20:38:32 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id yo9sm19015735pab.16.2014.03.20.20.38.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Mar 2014 20:38:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <CAPig+cTGYufCtVJDxG8RUJgyMbb7c3ZdiYMuoAbhQQaitVWRnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244632>

On 3/20/2014 1:18 PM, Eric Sunshine wrote:
> On Thu, Mar 20, 2014 at 4:44 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>> Built-in commands can specify names for option arguments when usage text
>> is generated for a command.  sh based commands should be able to do the
>> same.
>>
>> Option argument name hint is any text that comes after [*=?!] after the
>> argument name up to the first whitespace.  Underscores are replaced with
>> whitespace.  It is unlikely that an underscore would be useful in the
>> hint text.
>>
>> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
>> ---
>>   Changed according to the last comments.  Added "Usage text" paragraph in the
>>   documentation and updated variable names.
> As this is a high-traffic list, it can be difficult for reviewers to
> remember all the comments regarding the previous version. It can help
> a lot if you include a reference to the previous attempt, like this
> [1].

Got it, thanks :)

>> [...]
>>
>> +`<arg_hint>`::
>> +       `<arg_hing>`, if specified, is used as a name of the argument in the
> arg_hing?

Will fix it in the next patch.
