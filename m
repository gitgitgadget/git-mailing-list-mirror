Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C5A2036B
	for <e@80x24.org>; Fri,  6 Oct 2017 11:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbdJFLCb (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 07:02:31 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:52069 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdJFLCa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 07:02:30 -0400
Received: by mail-pf0-f173.google.com with SMTP id n14so7494872pfh.8
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3M4KVTGXREj2go/KKA/oE6dTTIQ4VVCJL/yLhibGeE8=;
        b=sT2gk9VlEFpYv0LgQNtNYBo0ZVUl/Ll8Myn5K4gvEq72IavrklJqQFmixhwBNCcH5y
         TOqNeSuXsBqIOJ9Hl0zSNMY8NvHXn5G5F1asKyL62vpuCFKyuRDPF9ZirKkHZQ6JrCcA
         hzIIo1UxX3rzz5AnO5AIvetP//9XQAx3xjZuGNbYiJFhrzTj4EMe0h8eZUuuy8ceAi94
         +D9cvlZl++J/OOTlKUt37TpCe0sqiWfEwnd8Lqpkp81IM4k7twdPmtFoLEMNFO+RIhoD
         a2N+2DK6taHZZGl/Wfh/Wvf2wtcM8/nTM297vw94+CVj1gIHYnVQhZ3s4QwgGnqRepVE
         9scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3M4KVTGXREj2go/KKA/oE6dTTIQ4VVCJL/yLhibGeE8=;
        b=IttQhPslR6QOzdBX3sypYTfQAzlpg0+5JmEPoKI882PZeaKTMa6km0+U8MrNaLBKXs
         PEDKgSi9glQQbuxeyPgPDOwmvXT38AwTAeCowFimR2m5xF1I8PcRLHRGyAcgK3Ack8bg
         ytTOAVOlfyIx0aY1Po3rebQthsRHL0HpGTC9H+HzDiZLV0fSIRo6q3HpojTrjv5awe30
         G8cay/lWXDfaIywbRmf3+8/V27+Y2clDrGooZjbwHRtp46HNijAEHAs9P0U0DUA7nR8J
         Pw4z+SUKDjLP0/Q+sk8vrY1OFq3I7HeGIvwfuoeR78VsP/Z6A7DYu36KaCHkcg5owWfj
         X2jg==
X-Gm-Message-State: AMCzsaU2VAZZN5PxJafHWEwLfZURPrAD4Waze/TEm+e+HtfLQeL42gBh
        mpBu8o7eyYGh3ayv5X33Vvf6HkKHu7bBG+FUNZc=
X-Google-Smtp-Source: AOwi7QDnNyPV/123wUt8BkqEAH22fbgDSaBVBzsVQ/gY8M4k65ARdytA6dOnsr6FRaqxB//txfLg0A+TFXQz0SKZIro=
X-Received: by 10.101.73.79 with SMTP id q15mr1532539pgs.236.1507287749810;
 Fri, 06 Oct 2017 04:02:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Fri, 6 Oct 2017 04:02:28 -0700 (PDT)
In-Reply-To: <xmqqinftyryw.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
 <db82bb7dc0828a415e48e654031b3b0d0ed763a5.1507228170.git.martin.agren@gmail.com>
 <xmqqinftyryw.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 6 Oct 2017 13:02:28 +0200
Message-ID: <CAN0heSrB4e4tNcuydztXHB9zg=y8poVSPLk_xNZssdGW3zYcxQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] read-cache: drop explicit `CLOSE_LOCK`-flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 October 2017 at 03:39, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> diff --git a/read-cache.c b/read-cache.c
>> index 65f4fe837..1c917eba9 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -2343,14 +2343,13 @@ static int do_write_locked_index(struct index_st=
ate *istate, struct lock_file *l
>>       int ret =3D do_write_index(istate, lock->tempfile, 0);
>>       if (ret)
>>               return ret;
>> -     assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=3D
>> -            (COMMIT_LOCK | CLOSE_LOCK));
>>       if (flags & COMMIT_LOCK)
>>               return commit_locked_index(lock);
>> -     else if (flags & CLOSE_LOCK)
>> -             return close_lock_file_gently(lock);
>> -     else
>> -             return ret;
>> +     /*
>> +      * The lockfile already happens to have
>> +      * been closed, but let's be specific.
>> +      */
>> +     return close_lock_file_gently(lock);
>
> "already happens to have been" is quite a mouthful, and is not quite
> truthful, as we do not foresee ever wanting to change that (because
> of that stat(2) issue you mentioned).  It might be better to declare
> that do_write_index() closes the lockfile after successfully writing
> the data out to it.  I dunno if that reasoning is strong enough to
> remove this (extra) close, though.
>
> When any of the ce_write() calls in do_write_index() fails, the
> function returns -1 without hitting the close/stat (obviously).
> Somebody very high in the callchain (e.g. write_locked_index())
> would clean it up by calling rollback_lock_file() eventually, so
> that would not be a problem ;-)

When I wrote this, I was too stuck in the "it gets closed accidentally"
world view. It would indeed be cleaner to specify that the close happens
in `do_write_index()`. As you say, because of the stat-ing, we simply
have to close.

It's still an implementation detail that closing the temporary file is
the same as closing the lock. We might want to refactor to hand over the
lock instead of its tempfile. Except the other caller has no suitable
lock, only a temporary file. I guess that caller could use a lock
instead, but it feels like the wrong solution to the wrong problem.

I'm sure that something could be done here to improve the cleanliness.
For this series, I think I'll document better that `do_write_index()`
closes the temporary file on success, that this might mean that it
actually closes a *lock*file, but that the latter should not be relied
upon. I'll get to this later today.

Thanks.

Martin
