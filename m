From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 06/16] shortlog: add missing declaration
Date: Thu, 31 Oct 2013 15:17:23 -0600
Message-ID: <CAMP44s2xYRP9rmpoQzDcdSWiYpU31FXEPW32Yqsn2DZjP4kD_A@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-7-git-send-email-felipe.contreras@gmail.com>
	<xmqqk3gt5kht.fsf@gitster.dls.corp.google.com>
	<CAMP44s2zTFKeHxp0G1imLXdHfzao_DSY+mkm7awYedwYafFZ+w@mail.gmail.com>
	<xmqqvc0d432e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 22:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbzcO-0000gT-JG
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 22:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab3JaVRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 17:17:24 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:40228 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab3JaVRY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 17:17:24 -0400
Received: by mail-wg0-f52.google.com with SMTP id k14so3301402wgh.31
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xJ2WQX9PXACRee/q5HE+tex6/gRMmghkSsXqFOWAKnk=;
        b=SfMPkmZCDGYZma9GgcU7R8JtWaPFk0SNTfo5EXahVF9bJ5lnCCMcm8FF3ucbH3rI9o
         HSGeLoCYOus8quIfDd5xHuV2fIkWxrGWBZVbRMSLf3QihnxhNaXpedA17ZxwIfajElPj
         bNmFDeke1sIwRLcUAS9AeNJcLPrp6Edm+9Nadcc9u/S0BNSPCkrTg/N/qvyg3fkB3+h7
         avD+Tjm9cMyVq1pZ1lnQPwOm9UiRN0R6caB9KmWeeQ06/S1aTzCCJVGJ1YIto28lT6xQ
         sg2z0h/j4isBM6CtfTCzn2XO4sRErozjnuCut3AH0ph4PQU7frJgK8owdvc79bZGJJxu
         I1mg==
X-Received: by 10.180.39.212 with SMTP id r20mr14119wik.13.1383254243141; Thu,
 31 Oct 2013 14:17:23 -0700 (PDT)
Received: by 10.194.242.167 with HTTP; Thu, 31 Oct 2013 14:17:23 -0700 (PDT)
In-Reply-To: <xmqqvc0d432e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237186>

On Thu, Oct 31, 2013 at 2:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Oct 31, 2013 at 1:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Otherwise we would have to include commit.h.
>>>
>>> Was there a reason why commit.h is not included here, just like
>>> revision.h would include diff.h, so that users of shortlog.h do not
>>> have to worry about including commit.h themselves?
>>
>> Because you can't do:
>>
>> struct diff_options;
>> struct diff_options diffopt;
>>
>> The storage size is not known, but you can do:
>>
>> struct diff_options;
>> struct diff_options *diffopt;
>
> But so can you do
>
>         struct diff_options *diffopt;
>
> without the declaration, no?  That is:

Yes.

-- 
Felipe Contreras
