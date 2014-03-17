From: Justin Lebar <jlebar@google.com>
Subject: Re: [PATCH 3/6] l10n: Fix misuses of "nor"
Date: Sun, 16 Mar 2014 19:43:44 -0700
Message-ID: <CAMuNMfpRve8yQcKa9O-sPBMMY=afcGagkjZSs=FQQTbruVxY0g@mail.gmail.com>
References: <1394872922-2000-1-git-send-email-jlebar@google.com>
 <1394872922-2000-4-git-send-email-jlebar@google.com> <CANYiYbE_WRhCAfDCpAskw4JqEnbZ3xg0MvK2FrYLZrhmkKuKhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 03:44:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPNXJ-0001QB-8E
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 03:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbaCQCoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 22:44:07 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:48626 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbaCQCoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 22:44:05 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so4803819qaq.30
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h6kkSgQ3s8Q7+vkrrsHObExS5xUW+qnZ+9DCkdYozTM=;
        b=J6fca9EReq0tuqvvgqKy0jqLaPIYTZY8Ex+JzU8cpm8cFo2SkOg213o6m7mxKNtsAR
         ibCjq6Z6gcCP9DaEJDaqYTzCHNr9ncz/ixhQTZV0LDPlmZtNGHWdf8KbuOd4FbxgeU+r
         r/OxdameQ5cr4oC0HW0jStamOWCqEOstvpkSgs6TqY0VAR75omL1/MEwvd+1reRe2znM
         2+CJdcrNnadViuLcNoBG33884aOrrMmd51fSI10qQSMLR1bWu4feaj/kzQJL/maz5xT4
         QlRq/1pLaA96gkQIBCAvooHEF9mtyjGNKbjnzbKN+bzMnAFcwEZEi9r0M2P7QCnY2/nh
         Dfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=h6kkSgQ3s8Q7+vkrrsHObExS5xUW+qnZ+9DCkdYozTM=;
        b=ZeLAqT66SadLCxPTCvCQ75uXcOt9AAqrpOD91B/5Asg0EyFQ3wWcTNJnbJSqdIWT2S
         h0zlGMIY2b/J0mf/pEo2mdZSot06phRbzYwwxcupxZHlxU3z8sjMAA3CQreZaV2IqZXj
         VWAkZQr9MFNX3tNCmQKE+pukjU5AO7iI4OQPZ8ttCRWPO3Pda3jck9k5Ww8yRqTZa9t9
         otEjFpCkDdhLopv7K1oO47M5SnW1D7imh87gpmC4Hy5rDUUhEc2vHoAO6EsMaZ6Jn385
         8i9iq5FeNC11+DnOukpRoVgMTWIewFAUDViZWe71NdF+QY1savDFDKMseyrscGvlDqsX
         EjGg==
X-Gm-Message-State: ALoCoQnOGQqJaGYSmH3Gm9U7rlBFoRrCJXNR4R7+xqKDh1Rg3q7AeamabEeriJeA8edUuStXwsDNk6djtAOMlCPTB1y9GggLVhEZwtN1FvhDLvSisV1qOlS7jUWa2o9sVT2V/cT1Kd0aL815mSDDoNIjClQ2AdT4o7f7KCXByBF9zdfynAN+aLz/WUHTyIVmbnT7pGSWeMjy
X-Received: by 10.140.102.2 with SMTP id v2mr24510342qge.27.1395024245013;
 Sun, 16 Mar 2014 19:44:05 -0700 (PDT)
Received: by 10.96.69.36 with HTTP; Sun, 16 Mar 2014 19:43:44 -0700 (PDT)
In-Reply-To: <CANYiYbE_WRhCAfDCpAskw4JqEnbZ3xg0MvK2FrYLZrhmkKuKhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244219>

Thanks.  I'll remove this patch from the queue.

On Sun, Mar 16, 2014 at 6:45 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> 2014-03-15 16:41 GMT+08:00 Justin Lebar <jlebar@google.com>:
>> Signed-off-by: Justin Lebar <jlebar@google.com>
>> ---
>>  po/bg.po    | 6 +++---
>>  po/de.po    | 6 +++---
>>  po/fr.po    | 6 +++---
>>  po/git.pot  | 6 +++---
>>  po/it.po    | 2 +-
>>  po/pt_PT.po | 2 +-
>>  po/sv.po    | 6 +++---
>>  po/vi.po    | 6 +++---
>>  po/zh_CN.po | 6 +++---
>>  9 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/po/bg.po b/po/bg.po
>> index fb450b2..983e575 100644
>> --- a/po/bg.po
>> +++ b/po/bg.po
>> @@ -3699,13 +3699,13 @@ msgstr ""
>>
>>  #: builtin/clean.c:906
>>  msgid ""
>> -"clean.requireForce set to true and neither -i, -n nor -f given; refusing to "
>> +"clean.requireForce set to true and neither -i, -n, nor -f given; refusing to "
>>  "clean"
>>  msgstr ""
>>
>
> Hi Justin,
>
> All the msgids you patched are extracted from Git source code using gettext,
> So please patch the original files where the msgids are came from, such as
> builtin/clean.c.
>
>
> --
> Jiang Xin
