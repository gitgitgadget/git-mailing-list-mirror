From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] Documentation/tag: remove double occurance of "<pattern>"
Date: Fri, 10 Jul 2015 09:44:46 -0700
Message-ID: <xmqqbnfkklmp.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<1436437671-25600-6-git-send-email-karthik.188@gmail.com>
	<CAP8UFD0mSZ_FyPcaMoWRbrR=i9vFJvVYyqM+0B-3L3dQpA6SsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 18:44:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDbQ2-0008Sl-9I
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 18:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbbGJQot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 12:44:49 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37390 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbbGJQos (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 12:44:48 -0400
Received: by igpy18 with SMTP id y18so17089559igp.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=r180JeubcgeY1PJokem9NlRlcSv7lq+0qP7qsMsv6EA=;
        b=aLR6Y0Y8gIXiMPzZ3MotaFDAztqndzDQ+cXMrofb/P3w3cAYUTmVkbslvWmsTF2+R+
         JHqK6xHg74owp3rouKT27yX299OmZOO08A6icf04/WZj6KVmNxSuu9fHndh06tu+GiJC
         Ggzv1FgcdVQOOGVAOiBbvBh/Z3vTd6LiVZL32hN2Rjx8L7ot3xbj1vpoIOui+Q7Vvx+X
         HjQXZwkwOVOT0BdvPqgoXwzjTGQNZ6c03xyClttH+Za1Ljua6adRzwMEa70xpv32cQW5
         fkUFVyNSDZuTM5Ba/gVQB4GMENI/F43CNxxeWAdWUWIlUKqASZZRVKdGpKL998etF1sk
         J7kQ==
X-Received: by 10.50.50.175 with SMTP id d15mr4439483igo.18.1436546687992;
        Fri, 10 Jul 2015 09:44:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6de3:8019:a2a4:79ec])
        by smtp.gmail.com with ESMTPSA id j2sm6787295ioo.43.2015.07.10.09.44.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jul 2015 09:44:47 -0700 (PDT)
In-Reply-To: <CAP8UFD0mSZ_FyPcaMoWRbrR=i9vFJvVYyqM+0B-3L3dQpA6SsA@mail.gmail.com>
	(Christian Couder's message of "Thu, 9 Jul 2015 14:19:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273824>

Christian Couder <christian.couder@gmail.com> writes:

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

Thanks. I'll pick this patch from the remainder of the series and
queue it on a separate topic.
