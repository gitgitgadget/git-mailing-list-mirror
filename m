Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD162022A
	for <e@80x24.org>; Tue, 25 Oct 2016 11:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965913AbcJYLMN (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 07:12:13 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34575 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965836AbcJYLMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 07:12:12 -0400
Received: by mail-oi0-f46.google.com with SMTP id t73so92153829oie.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P1kxTtVh+MBey8tNcUSkILQ4NB4LkTn3fjgf7wXm/Ho=;
        b=Fy41b8VlIbDrA75auGUbgL9sKK3RacOVW1iLIwJ2iyVw37MZPxlnXqKtdjRuCZssN7
         LrirdB+Hcq6wHvLB8kBRtNX/rkLWTO84DGyoAMlRAiaDVJRJsV20lPvvSrjzyRcqNf9T
         pDkegnOihrJZGKExduzYUPD2ESpMGw65dc4JTzkDHO9poNoJDhqcntRJyOn1FVB3XfKF
         tBokQ3TIysPnf/6FdKGiuRO1yAYHZ1mh65P593XaguKCsYOcPfQYhYZuIZpS3SHbBk87
         n+zr70NROffbXsl8OpRLHEYnMlgfALF6AurGddCc5Sc5tUmXzdTBbSuLLtr7SgNQWT0A
         G83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P1kxTtVh+MBey8tNcUSkILQ4NB4LkTn3fjgf7wXm/Ho=;
        b=Lef6TphharPJlcYH+8fZuGiR2giH0otzxxIuU7g0vpmxKp783dK3/UGLzNaCAUjG+W
         cTdvqGsy/76tTVazN+qNS53Xbjx5QT5+BcC89Sr/brJLR0QxTx/64JF2BMGzh07W20UF
         NzyCd1RZPAoxwiUp3T/dJOGDJE0i1E8iY/1HxTLD745qS0qJ8jnXj46zBRPibr6HZNX5
         exR/5F4JeNZLKL8f1NlANOyFfZvjIH7tHwP8Cy3ruUEeI/FBworqLNSz9cN8+0FLr5R5
         N3Trjhh62T+E0nMiByBblJbER+0apTasKBco9A/kYle3BEQGdFPCEo5bU6FkmrhmkDSh
         iosg==
X-Gm-Message-State: ABUngvdcYMa9tanwmkv1hwpKskm3fWDgu0QdN2ZGaEUvEIN4Ye3sqOiETWbFQWV+Hw9lD0oL4OsoZ6wWN/5DrQ==
X-Received: by 10.107.59.6 with SMTP id i6mr17040128ioa.176.1477393932034;
 Tue, 25 Oct 2016 04:12:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 04:11:41 -0700 (PDT)
In-Reply-To: <CACsJy8B-GcMNv7pYYLpaUXc2kKnvyYEYm6w=fiaHy7rt4aug1Q@mail.gmail.com>
References: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com> <CACsJy8B-GcMNv7pYYLpaUXc2kKnvyYEYm6w=fiaHy7rt4aug1Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 18:11:41 +0700
Message-ID: <CACsJy8D4cT2EV_t6=+XTHxLmjV+NtAE+KgiN3ZiP7JQzvu29oQ@mail.gmail.com>
Subject: Re: [PATCH] reset: --unmerge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 6:06 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Oct 25, 2016 at 6:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The procedure to resolve a merge conflict typically goes like this:
>>
>>  - first open the file in the editor, and with the help of conflict
>>    markers come up with a resolution.
>>
>>  - save the file.
>>
>>  - look at the output from "git diff" to see the combined diff to
>>    double check if the resolution makes sense.
>>
>>  - perform other tests, like trying to build the result with "make".
>>
>>  - finally "git add file" to mark that you are done.

BTW making git-add (and "git commit -a") refuse files with conflict
markers present could prevent this mistake earlier and is probably a
better option because the user won't have to discover 'reset
--unmerge'. If the user likes to add the file with conflict markers
anyway (because those look like conflict markers but are in fact not)
then they can go with "git add -f" or similar.
-- 
Duy
