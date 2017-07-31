Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50691F991
	for <e@80x24.org>; Mon, 31 Jul 2017 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbdGaRCS (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 13:02:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38541 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdGaRCR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 13:02:17 -0400
Received: by mail-pf0-f195.google.com with SMTP id e3so9350767pfc.5
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XoXJ9TBkcR9hdaIs4EnX+qZPvwfCnHPyTChpW+1t5nQ=;
        b=fCHDvJY6iIVOw0bIUJMYDxhFy4wCW4MeD3QjIg9njHZ5zhUIp9Ms7e+GUmEDZi37bF
         VTNAiafRIYrkIHjDn5SOR34Sohz9FW+UoLuxR/L4VD7kM3juLfgeP/Yvzf5ZzNm2DCTa
         xCMsI6rLKb2vyt73B9HY06t4n3pE16rR+WHOrlPiXguHoW0PW63WHkZg2ckA48kvHYDK
         SLT6afVZUc85BOr390THIwwR+PCaFkkEyhau98LaOZWv8kF7JDtfeVjuYD+qlww9YO35
         tlZAMKbP6GvgW0TyHN0W7lXr1SVxkt0RB12ofMDxRAyYGi7jw6x1Msnfiz3KsPskzyOz
         2DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XoXJ9TBkcR9hdaIs4EnX+qZPvwfCnHPyTChpW+1t5nQ=;
        b=kvSYYZvhpAHM8vF7MuC/mP2esIdhqGkGF/0Guc1oYjFvwKqeVwgSA2FSCniNO4SB1c
         qKgPodHJRuXlaNECENr8vN8B9hVXThs+6fYgfoNg0N8yQJEPrhfiXf61Oby1r+PcXy1s
         1TOouPE62bBq9rJedMRqWfakdfEtKaN+PvTo/Gs3u4u/73+oe+asQCvtvp/9KKOzh3ah
         FEmltUhs+oFgAJpjTB8R9H+lg2ksKClO7tfHtiGCt1UfPf3UwDmQxM/4yr9F63avZlY2
         AvzE4ZhqzQwnYMcBq0YwIHx3JIaLRBOsLmzB/whysq/IdTi+IepW794xLGo4jEYrFo4l
         biFg==
X-Gm-Message-State: AIVw1126Bk0vB+ZwjVjstMzX3ZIGO94Xt5msJamG7SaPEoqr+xdsH4f7
        BEfbtAdPP2aCBD+KQ+Y4h0/OOQNAO30N
X-Received: by 10.84.212.150 with SMTP id e22mr17637677pli.398.1501520536710;
 Mon, 31 Jul 2017 10:02:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.132.193 with HTTP; Mon, 31 Jul 2017 10:02:16 -0700 (PDT)
In-Reply-To: <xmqqtw1silu3.fsf@gitster.mtv.corp.google.com>
References: <CA+dzEB=cDvp7ZS8x+p+U-5NbK3SNd0FPyj_wP=gvi8mJi6D2ag@mail.gmail.com>
 <xmqqtw1silu3.fsf@gitster.mtv.corp.google.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 31 Jul 2017 10:02:16 -0700
Message-ID: <CA+dzEB=EV+wR-ETvm9wrR6cYGFZQbtdxsPHMTkfz6EOgah_AnQ@mail.gmail.com>
Subject: Re: [PATCH] Fix minor typo in git-diff docs.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks!

I'll keep this in mind next time I send a patch.

Anthony

On Mon, Jul 31, 2017 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Anthony Sottile <asottile@umich.edu> writes:
>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index 89cc0f4..43d18a4 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -392,7 +392,7 @@ endif::git-log[]
>>         the diff between the preimage and `/dev/null`. The resulting patch
>>         is not meant to be applied with `patch` or `git apply`; this is
>>         solely for people who want to just concentrate on reviewing the
>> -       text after the change. In addition, the output obviously lack
>> +       text after the change. In addition, the output obviously lacks
>>         enough information to apply such a patch in reverse, even manually,
>>         hence the name of the option.
>>  +
>
> Another thing that is more severe.  You seem to have replaced all
> leading tabs with whitespaces, which makes the patch unusable.  For
> this single character patch, I can pretend as if I applied your
> patch while making the fix myself in my editor, so there is no need
> to resend, but please make sure your e-mail client does not do that
> the next time.
>
> Thanks.  Queued.
