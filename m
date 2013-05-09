From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 4/4] fast-export: trivial cleanup
Date: Thu, 9 May 2013 05:04:55 -0400
Message-ID: <CAEBDL5Ww6g8G-eM93ZFji3ZNEbKrpsTuibHkOk=aSnFapV0EEA@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-5-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5VotNSZC_xHc3r49bBFtNwU+drWa_Pj=skC3xzk-CGpKA@mail.gmail.com>
	<CAMP44s1DPwfiEDuUqUSBN1ShsgLDy9_2E0OD6nnwT7kJeJUCyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 11:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaMmb-0002iG-3x
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 11:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab3EIJE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 05:04:57 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59383 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3EIJE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 05:04:56 -0400
Received: by mail-wg0-f50.google.com with SMTP id m15so2701432wgh.17
        for <git@vger.kernel.org>; Thu, 09 May 2013 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=UW83pg8zmhX+oLhOZWeHw28sJaU7pMxhrJiEh62GRuQ=;
        b=XOrvW8OhwIB+qb2Azd7usmNUozDoeCHj8G5vPKq1YNAnFyu2U/7k84I5jw2gq2xuGo
         L7TU8NISvAnCAO1L3eGxmdJ2MID/JYaJIknswcJfYI3GmSvq49sQXzheaxpemcLjXZNk
         vXZWtEbtp5eyWRu9BTJOA3YcPKif3V8FagCLpOMeqf+qYmO+KSkF32PPK8ZgEzr5wa2a
         iLTHXWfgJMAwLMZ74m2H5o4tJFeuwRBIsQTrpRDS+JSZGEtaAXTfiydYn56MXDZzFsLy
         4nEOpyIOczvXdgGnSL1U6cVlvYWUg4NWcP2y1usVc/0WgRUYAvahkjprU+bYo6xBMAU+
         4eLg==
X-Received: by 10.180.21.167 with SMTP id w7mr15930270wie.2.1368090295115;
 Thu, 09 May 2013 02:04:55 -0700 (PDT)
Received: by 10.180.78.69 with HTTP; Thu, 9 May 2013 02:04:55 -0700 (PDT)
In-Reply-To: <CAMP44s1DPwfiEDuUqUSBN1ShsgLDy9_2E0OD6nnwT7kJeJUCyg@mail.gmail.com>
X-Google-Sender-Auth: kBX9wxLWo4GLBTLngveTUFyhTCo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223719>

On Thu, May 9, 2013 at 4:53 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
[snip]
>>> @@ -562,9 +561,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
>>>                         break;
>>>                 case OBJ_COMMIT:
>>>                         /* create refs pointing to already seen commits */
>>> -                       commit = (struct commit *)object;
>>> -                       printf("reset %s\nfrom :%d\n\n", name,
>>> -                              get_object_mark(&commit->object));
>>> +                       printf("reset %s\nfrom :%d\n\n", name, get_object_mark(object));
>>
>> FWIW, this line is now too long (exceeds 80 columns).  Good catch on
>> the casting though.
>>
>> -John
>>
>> PS  Sorry for the duplicate Felipe... I still need to get used to
>> hitting "Reply All". :-)
>
> The guideline is:
>
>  - We try to keep to at most 80 characters per line.
>
> The key word being *try*.

I saw that, but you actively joined the lines, and there was no need
to.  It didn't even require trying to keep it within 80 columns. :-)

-John
