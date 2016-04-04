From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] doc: clarify that notes can be attached to any type of
 stored object
Date: Mon, 4 Apr 2016 10:10:38 +0200
Message-ID: <CAHGBnuPkPqJprOxR4zBuWitXqXt9XtpnjGPQWEv+-pYovh1b+A@mail.gmail.com>
References: <56FE48C6.9050306@gmail.com>
	<xmqqy48xjqg5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 10:10:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amzaw-0000sf-AC
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 10:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbcDDIKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 04:10:41 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32929 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbcDDIKj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 04:10:39 -0400
Received: by mail-vk0-f48.google.com with SMTP id k1so170209519vkb.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hssIKWTEsXUH1eLCd8Inc/VjX9xPUWnkzHju9WU2psY=;
        b=WN9QDpJ7XcdPuevu+r2k4WLuVbruQtWkp7QFHZhHUBWIix6e5BTSVFX1L1nwEgG/s+
         jtjU5mtz2M55yuAdECAYV7zQqm8/22DV0l7EKU6KGMonK+aW50RCqST1V02XisuGcWrL
         kZGAnV18MgG9ZSWwyYEhNISK4rd0rDEuDUJidBO96HZuEeyYWLTxw7BYKbpiB2/wTmLz
         ygu+4eW6rugHseZWTU7gj+0j3FfRGSCNIBjuKvNywAZvq4d9g5VDlZtmRVDTXQ2m5MQx
         GnGqFiGPBlpQ/v7wtV57e7QX4KGfEWf388K7KbWmfNeChxsGotNkiZxSMFCsSSlAEDDS
         /E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hssIKWTEsXUH1eLCd8Inc/VjX9xPUWnkzHju9WU2psY=;
        b=enST+JFHtfw8qaVVQ2frgEduUho8HjdLTFDwEBJHQeqLj1sx63KrYvCgtNNwOmIvGA
         VAWFJIftUHc4e87+BtNToP08DTdUbli0QsNtNgXjVgw/HLKTYujVCK/7SQcXCHWWvvl+
         sj/5+4u8GDvWAJzn5N1be2+VthGhvP3SMeFe/esKmQMh0jdouSrhI6avlAhEqCk0oxit
         gXSdoG8VR/nCfkAFtPLHVP2ehkfjgY/qPotE70fadyNXxQh2dSf7PR59nDIEKtqEjqf2
         f3f4Z6mWABGvBRaO4Res7CkvdPria/oRI+2ZouQUpeIthBuV/XL1SGggeXKiTfrP1oOg
         +53w==
X-Gm-Message-State: AD7BkJJWWUUq8b9q8B5TRYsdxvvVk4zQdUJP95Ck95gGjXfEJB9u0oQEoMYMegPGQ/s1QTXZ+pfc7+fJLcEAeg==
X-Received: by 10.176.6.197 with SMTP id g63mr1300929uag.60.1459757438125;
 Mon, 04 Apr 2016 01:10:38 -0700 (PDT)
Received: by 10.176.68.6 with HTTP; Mon, 4 Apr 2016 01:10:38 -0700 (PDT)
In-Reply-To: <xmqqy48xjqg5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290683>

On Fri, Apr 1, 2016 at 5:31 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
>
>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>> ---
>>  Documentation/git-notes.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
>> index 8de3499..5375d98 100644
>> --- a/Documentation/git-notes.txt
>> +++ b/Documentation/git-notes.txt
>> @@ -234,8 +234,9 @@ which operation triggered the update, and the commit authorship is
>>  determined according to the usual rules (see linkgit:git-commit[1]).
>>  These details may change in the future.
>>
>> -It is also permitted for a notes ref to point directly to a tree
>> -object, in which case the history of the notes can be read with
>> +It is also permitted for a notes ref to point to any other object in
>> +the object store besides commit objects, that is annotated tags, blobs
>> +or trees. For the latter, the history of the notes can be read with
>>  `git log -p -g <refname>`.
>
> I do not think this is correct place to patch.  The original is not
> talking about what objects can have notes attached at all.  What it
> explains is this.

Thanks for the explanation, I was indeed misreading this. I'll try to
clarify this section then, too. In order to do so, I think we should
mention how to actually create a <refname> that directly points to a
tree instead of a commit for the history of notes. Would you have an
example how to do that?

-- 
Sebastian Schuberth
