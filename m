From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFD] minor frustration in 'git add' pathname completion
Date: Thu, 24 Mar 2016 17:38:10 -0700
Message-ID: <CA+P7+xo1vKNwLt9JazAGZR1=Wu4qe8OsuxTVUYV_TgbUkRBHVA@mail.gmail.com>
References: <xmqqr3ez7dqw.fsf@gitster.mtv.corp.google.com> <CAGZ79kaUPf=kBCuH__8BahjM3WjSGaijiQr05pMKe+TNdg3W9w@mail.gmail.com>
 <xmqqbn637cpe.fsf@gitster.mtv.corp.google.com> <CAGZ79kYDWJDDJ+doy3NcZH_dqbbFE8U2UHZjnYYTo5R9GTsghQ@mail.gmail.com>
 <xmqqy4975vv7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 01:38:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajFls-0007PW-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 01:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbcCYAic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 20:38:32 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35767 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcCYAia (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 20:38:30 -0400
Received: by mail-io0-f178.google.com with SMTP id v187so70480814ioe.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 17:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dPKEXDejAZJilywFi8+6Wd90pR7G5ijEr8E9tUfs1iI=;
        b=qk7B8v+85pLIcLe6BmWGj5mv5dqMBCtQ5i30+Nr9UlQrNjwJX5PtHKgRDjuDhHW/Yx
         +qso+Ds6wjXKQcIoHK3o8QfQugOF23fgHR9Re1YEEOL0t5C279viz0mVC1AnAwN+dlfy
         /SAhobmWVYV3cCykrd5vmX4pI2kOrCOggeYZp8hbklLYIJxS9JqiaCVKhH97IcbiKaYS
         YsQyAHbv3t6vg3mod5iRWpazB01Mz+aQAWWyswdu3HuA9GqjHhD1w1ErvrI2vgyxZw/f
         OzMXm+2WCMJD6M8o+bwvGHiqSEhD0Fu4TzhBiPee/Hebths0m+5RpghQo1xC7twcsfVJ
         XspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dPKEXDejAZJilywFi8+6Wd90pR7G5ijEr8E9tUfs1iI=;
        b=Fv7ywbRiIa+H0/t+lRZWECiBsxQDM3AGHYyL7GmcTuLjzxuHY+7GmUa/C1u93yYD2X
         psW5vqx2Ij87+3Zmh6PXV/cOeKI4qURsr1rvs9778mhrP3JxBtGHgG/aexNBKZ2ahkrV
         wQ8jK/RVIjKnaWs8NUgnEJKAaUcPG0nSWpCiheVk13HFvf1U61OCGQa83iRrgdPk6Pxs
         r4uYlibF0elqb9+rrCvo8+7BSTpMwC7rXAzAqJUhMoTAi2FEXAEWy97y8vEDdvq/EOIh
         h4svyapJYCGtV6O6/LRN7G9OwpHSzMf1bCQBbXpHH8v6pov8mT48SNJ0+YcjFxqeOFGN
         iSQg==
X-Gm-Message-State: AD7BkJLm1KX5N3VA/EfePbrtwVlYodyOT1vZEB/w9beo0pQdCtIJwkSkPmJYa+H1H6NqHWsa8nQDHxlFQBKpHA==
X-Received: by 10.107.136.77 with SMTP id k74mr12937624iod.0.1458866309683;
 Thu, 24 Mar 2016 17:38:29 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Thu, 24 Mar 2016 17:38:10 -0700 (PDT)
In-Reply-To: <xmqqy4975vv7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289837>

On Thu, Mar 24, 2016 at 3:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> If I were to explicitly ignore that file, then even though I know
>>> whats-cooking.txt is not ignored,
>>>
>>>    $ git add whats-coo<HT>
>>>
>>> would not offer anything.  I'd be left scratching my head, wondering
>>> if I mistyped the early part of the filename (e.g. "wahts-coo<HT>"?).
>>
>> Well, git add cannot do anything with either of the files, so why would
>> it offer to complete to one of them?
>>
>> In an ideal world it would tell you whats-cooking.txt doesn't need
>> adding and whats-cooking.txt+ is ignored locally so excluded from
>> being added.
>
> Exactly my point that you omitted from your quoting ;-)
>
> Because the completion cannot give such an explanation, the
> behaviour gives an unnecessary confusion to the user.  If it offered
> whats-cooking.txt as a candidate, at least the behaviour would make
> sense to the user.  "Doesn't need adding" is quite different from
> "must not be added". In other words, "git add A && git add A" does
> not hurt, but "git add A~" would because the latter would only makes
> you see unnecessary error message ("You need -f if you really mean
> it").
>
>

I use this feature every day such that I can just do:

git add <tab>

and it cycles through all the available files which differ (thus could
be added). If it didn't do (3) then this would tab complete to every
file, every time, which is not what I expect it to do. It is
definitely something one has to get used to, but I know I prefer it
the way that it is.

For your case, I think local ignore is the right solution. Narrowing
the list is really a useful feature of add's tab completion.

Thanks,
Jake
