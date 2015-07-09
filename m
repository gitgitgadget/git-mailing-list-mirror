From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 06/10] Documentation/tag: remove double occurance of "<pattern>"
Date: Thu, 9 Jul 2015 18:26:34 +0530
Message-ID: <CAOLa=ZQpjXv3UBnnPpqpgDPw_tUzCQQ4EgdhW46QOfLd+3VGWQ@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <1436437671-25600-6-git-send-email-karthik.188@gmail.com>
 <CAP8UFD0mSZ_FyPcaMoWRbrR=i9vFJvVYyqM+0B-3L3dQpA6SsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 14:57:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDBO5-000559-Up
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 14:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbbGIM5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 08:57:05 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34488 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbbGIM5E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 08:57:04 -0400
Received: by oiab3 with SMTP id b3so70299609oia.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=chSZL7zmTiMIV74ilugoBwctDjHdgfCbj1OXwTZ8zOc=;
        b=huciDyiK2HGe3kdSC2fgDIcE5fw2KFipmk3kXl/g9dyyxMtFvuz/kjdN5EDjaCvU9D
         iQ9VVxbT1LF+nzuEiUWoxmtsnY4MokDBpjDtmetfV0Jx4GzYSFRVJ7x6t1rYrj9RVzsd
         PKRl1VudU4ps2lVPsHQkW8/tf0mNVg9fB0JSxKGt8PMk4U/S7DKtrKTkd+Jog4kPoKhd
         QI7EDcLwBawzXznZ2SS7FljcaIlngAPUxIAJDZCWKduYoDj0m/Jbqdbwi9zxWt4W6PyF
         N58TCxQPmgFuh/Csq9QaK03+CMQnYLF1UxdFxOPAWlWqMgYIeVXygPrjI7vqS4C5/fI+
         js9Q==
X-Received: by 10.202.186.132 with SMTP id k126mr14008442oif.60.1436446623583;
 Thu, 09 Jul 2015 05:57:03 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 9 Jul 2015 05:56:34 -0700 (PDT)
In-Reply-To: <CAP8UFD0mSZ_FyPcaMoWRbrR=i9vFJvVYyqM+0B-3L3dQpA6SsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273747>

On Thu, Jul 9, 2015 at 5:49 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Jul 9, 2015 at 12:27 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-tag.txt | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index 034d10d..4b04c2b 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -14,7 +14,6 @@ SYNOPSIS
>>  'git tag' -d <tagname>...
>>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>>         [--column[=<options>] | --no-column] [<pattern>...]
>> -       [<pattern>...]
>>  'git tag' -v <tagname>...
>
> As this patch could be applied directly to master and to maint maybe
> you could send it at the top of this patch series or alone outside of
> this patch series.

I'll do that :)

-- 
Regards,
Karthik Nayak
