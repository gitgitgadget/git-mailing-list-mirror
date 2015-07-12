From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 06/10] Documentation/tag: remove double occurance of "<pattern>"
Date: Sun, 12 Jul 2015 18:09:59 +0530
Message-ID: <CAOLa=ZRnmccZq9ZKmMOKNQ+HU8hWoHwvRQFL0MY_Di=B_jz4Vw@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <1436437671-25600-6-git-send-email-karthik.188@gmail.com>
 <CAP8UFD0mSZ_FyPcaMoWRbrR=i9vFJvVYyqM+0B-3L3dQpA6SsA@mail.gmail.com> <xmqqbnfkklmp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 14:40:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEGYm-0001Qx-Fz
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 14:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbbGLMka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 08:40:30 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34413 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbbGLMk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 08:40:29 -0400
Received: by oiab3 with SMTP id b3so119757182oia.1
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=frrZLP9nUDYXncsNDBRkxZY5nGJQo8QH6OyiIngYvmI=;
        b=S0e+Ejb4TshS7AhVhW2stY6Yv0BGpsBe1mtd8ilsxgho5KcyKP+FIlFc8qXpXhu5Fs
         akcIMkjnPTUs7w2bK0ngDf6SqeZXlxLXECsZ8j+OQLREF9eti9eAFvO8G0aspbQ5UEZA
         VwmXwtJP327zQpho23ALVtRn2s3Y42weiVbk6mwO8Igpavn8qQA7GJsAQedOWaczyEj+
         X6qErXacirkEmj0OkehC/6D3x3LmKa3O5YB2QFprYZLO40d1jUYA9v6i3Ol/tqlsuwT4
         N5runsXK/WGbeDDbXyU6oXxFqyfT89sQGfp79660yKQaD1OP1BvKMXkkk5T7RwpZve0Q
         HRnw==
X-Received: by 10.182.236.7 with SMTP id uq7mr26181823obc.42.1436704829028;
 Sun, 12 Jul 2015 05:40:29 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sun, 12 Jul 2015 05:39:59 -0700 (PDT)
In-Reply-To: <xmqqbnfkklmp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273893>

On Fri, Jul 10, 2015 at 10:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Thu, Jul 9, 2015 at 12:27 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>> ---
>>>  Documentation/git-tag.txt | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>>> index 034d10d..4b04c2b 100644
>>> --- a/Documentation/git-tag.txt
>>> +++ b/Documentation/git-tag.txt
>>> @@ -14,7 +14,6 @@ SYNOPSIS
>>>  'git tag' -d <tagname>...
>>>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>>>         [--column[=<options>] | --no-column] [<pattern>...]
>>> -       [<pattern>...]
>>>  'git tag' -v <tagname>...
>>
>> As this patch could be applied directly to master and to maint maybe
>> you could send it at the top of this patch series or alone outside of
>> this patch series.
>
> Thanks. I'll pick this patch from the remainder of the series and
> queue it on a separate topic.

That'll be awesome :)

-- 
Regards,
Karthik Nayak
