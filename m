From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 1/5] string list: improve comment
Date: Thu, 19 May 2016 11:12:36 -0700
Message-ID: <CAGZ79kZ9bsuBU+CKuw+kZ+f6JZEPHvYFM3R0rre51jChVxHAfQ@mail.gmail.com>
References: <20160519010935.27856-1-sbeller@google.com> <20160519010935.27856-2-sbeller@google.com>
 <xmqq60u9kjjh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 20:13:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3SRV-0006vk-A2
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 20:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbcESSM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 14:12:58 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36076 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933253AbcESSMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 14:12:37 -0400
Received: by mail-io0-f179.google.com with SMTP id b78so954262ioj.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=23JPAE0sXBFoP4/InemLYBREnybeXowsMJzh2O1/ats=;
        b=KnpTu7NKF0oqRwuWoUV8Afej2W0iktWSyte94P13tNdovdWEy3KeEV8JwgF8octepD
         dqK11x4Ex1g1R67913oK3PeRFoRZGtIhi2A6BveSSvXQqMRHec8cz68b/1ngrCRscFBk
         MjTe0iDW5ylg7pBQek9pcDyziR2FN1+Xm4BKuvlnR/xlxK+4FiSWYh9ekkGBlp442vx1
         5nyiAH6lc2nNyjmbENeKsUcGPcfhDUy/I7LW0faHCIBZA2XLrAqrEZ67+RyoZZOa00kK
         rmyAXp1x/4OY4fCkBCt+2ssflLCA11zH5lI3E6PZ+d19ZmOG+nVkexAF8Gu5aZzFZzQ0
         iRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=23JPAE0sXBFoP4/InemLYBREnybeXowsMJzh2O1/ats=;
        b=mbYxWORk/Rk3KI355rTg9rYSnIvvhicRcOu18PKsEpBzG+YUezXE2xcSxmgzWHyMhk
         E1v54uapfgMlpNXrRn5wEwk21iuwxvAidomZWzMS6YAMI0AurCjpTVheCOOi1RD9KFgp
         eMN2/eVyJArbatQ7nyBZTRFK9PfkWud3WcyHL2WCyRW46QMbGoKKGZLeeZKieBiVARs8
         Qk0qchb81EMS1YeJ8dxg3kg7cP94NWP428TomrB10JMG5UVmclNL6WsrRdCkk4E633wy
         8Qj6CLRagInvOayGaNMyJvKlbTUsxV3Yw2ZAxV2L6F0j5Dk5V7Ybhl+UJVnoLsuCBDT5
         AQ7A==
X-Gm-Message-State: AOPr4FV1UluvRGE7UODpAOMZe+SeC+YZQ0chpi4rQCBbRBMvqjyvS9LW6QxiXY1pMh803daszyqVnVWsg2mWGedf
X-Received: by 10.36.62.133 with SMTP id s127mr4104447its.98.1463681556746;
 Thu, 19 May 2016 11:12:36 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 19 May 2016 11:12:36 -0700 (PDT)
In-Reply-To: <xmqq60u9kjjh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295086>

On Thu, May 19, 2016 at 11:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  string-list.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/string-list.h b/string-list.h
>> index d3809a1..465a1f0 100644
>> --- a/string-list.h
>> +++ b/string-list.h
>> @@ -106,7 +106,7 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
>>   * list->strdup_strings must be set, as new memory needs to be
>>   * allocated to hold the substrings.  If maxsplit is non-negative,
>>   * then split at most maxsplit times.  Return the number of substrings
>> - * appended to list.
>> + * appended to list. The list may be non-empty already.
>
> I personally find that the original comment is clear enough, though.
>
> When somebody says "resulting elements of the split are appended to
> the list" without saying either:
>
>   a. "the list MUST be empty in the beginning", or
>   b. "the list will be emptied first before the split result are appended",
>
> wouldn't it be natural to take it as "you can append them to any
> list, be it empty or not, and they are _appended_, not replaced"?

That is true. I missed that though when reading the documentation and
read the source code to be clear.

>
> So while this is not incorrect per-se, I am not sure if it adds much
> value.  If somebody needs this additional clarification, because the
> original did not say a. above, she would certainly need more
> clarification because the original did not say b. above, either.
>
> "The list may be non-empty already", but she would keep wondering if
> the existing contents would be discarded before the result gets
> appended to it.
>
> You may say "No, there won't be such a confusion, because we say
> 'append'; empty and then append is 'replace'".  But then the same
> logic would say "There cannot be a requirement for the list to be
> empty in the first place, because we say 'append'".
>
> So...

So, please drop?

I do not feel strongly about this patch. I basically wrote to for myself
after I consulted the source.
