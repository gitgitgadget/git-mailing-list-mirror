Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B33DE1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 19:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeDTTcM (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 15:32:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37326 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeDTTcM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 15:32:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id r14so4426683pgq.4
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aASssJKMiUjN0Mi7E4kcJ4ESk3BNnjZHEnM/cTJscPQ=;
        b=DpeOQj9ba33ysGtrFf3/JZr2LgUOXMbmTxv6GjvUKd3bwcY2sp6SLfRZy/uQ8wAvpI
         +3SNM3Z74g/sk4bIv4rNOes7MsddTlQkXn//Ghe5gkCa5Y8z5twAraBvi8ky4Q7X8kKW
         MrF40LUqkBaY+n6JmnA8mN38xt0S0Hxib1C0fVHUhrn4yKDHbX1M++LxVlfdru5zqj5I
         6IC7C4hxWrqG+bsgzhVjsOnVB0G6F4hJ2H26ZYJQhwmY21aB1gvR5jKZMaqGBS9vpP+S
         ZACTGZQIB0rV4atGVxV5QeAAn8QJo0RBWVj5AjU4cb0AfPbM1/kPSjPjKdaKjrKMvJ9C
         K1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aASssJKMiUjN0Mi7E4kcJ4ESk3BNnjZHEnM/cTJscPQ=;
        b=WuELPxcYAVTWC2hOXZCFA6NSfOtSQzbT1ZXEUbvbIrVeYQrFjakHh5UyXpK29TJDpU
         WmrDUALOPmvoOs3543gAbf3toeC+MbGRhMScbjChtou84ldRZjcgSPxMBUkHiPKe6RJE
         oRjL7a3SVfrPs44PeyzjAzmDwtMb+FbErlnzvX2qRMYCFzb8s1AAgqrSrviKO7TFnwYa
         l+7fpZ4bPHALbsIPXATDWcOblCNCO+J+B+8l9P8bWMRXWcR6pvFIEOATsg/rD7ftCDFN
         dXw4VPRaSQEvhBWoBmsSZrpdo/Qs+QEPXalsOZBXU9sBG6LSpm7AqXKW8viizYc/0IV3
         esRQ==
X-Gm-Message-State: ALQs6tB36VtOJLCh/08Jq8zCi9iYbECSbK9+tdDeeAeFXrr0Qumgszcq
        xvJFUMyfF2n4Z1sjVfvuCHUJdBKCrnTlF19WDGE=
X-Google-Smtp-Source: AIpwx4+59FFYFivXwvUdDd1qwbCtfBmCye62HFNVsZpRnV1LbOk40bOoyxYO4rmFEF8lXdEY97wIHkYU0D2z/+JEMNs=
X-Received: by 10.98.237.17 with SMTP id u17mr10828837pfh.78.1524252731547;
 Fri, 20 Apr 2018 12:32:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Fri, 20 Apr 2018 12:32:10 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804202041400.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <MW2PR18MB228432C95C18DE786957DE70E5B40@MW2PR18MB2284.namprd18.prod.outlook.com>
 <20180420181248.2015922-1-martin.agren@gmail.com> <nycvar.QRO.7.76.6.1804202041400.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 20 Apr 2018 21:32:10 +0200
Message-ID: <CAN0heSreFmd_0QnTjgYdpOZ8y7iNc3J+dYcpo5oKJBF2ff5-jQ@mail.gmail.com>
Subject: Re: [PATCH] fast-export: fix regression skipping some merge-commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Isaac Chou <Isaac.Chou@microfocus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 20 April 2018 at 21:07, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 20 Apr 2018, Martin =C3=85gren wrote:
>
>> Reintroduce the pattern of first grabbing the last object (using a new
>> function `object_array_peek()`), then later poping it. Using
>> `..._peek()` and `..._pop()` makes it clear that we are referring to the
>> same item, i.e., we do not grab one element, then remove another one.
>
> Instead of using _peek() and _pop() and having to reason about the
> correctness, maybe we should simply re-push? See below for my suggested
> alternative.

>> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
>> index 866ddf6058..2b46a83a49 100755
>> --- a/t/t9350-fast-export.sh
>> +++ b/t/t9350-fast-export.sh
>> @@ -540,4 +540,26 @@ test_expect_success 'when using -C, do not declare =
copy when source of copy is a
>>       test_cmp expected actual
>>  '
>>
>> +test_expect_success 'todo' '
>> +     test_create_repo merging &&
>> +     git -C merging commit --allow-empty -m initial &&
>
> I see that you copied the style of the latest test case, but I have to
> admit that I would find it much easier to read if it said:
>
>         (
>                 cd merging &&
>                 test_commit initial &&
>                 git checkout -b topic &&
>                 test_commit on-branch &&
>                 git checkout master &&
>                 test_commit on-master &&
>                 test_tick &&
>                 git merge --no-ff -m Yeah topic &&
>
>                 echo ":1 $(git rev-parse HEAD^^)" >marks &&
>                 git fast-export --import-marks=3Dmarks master >out &&
>                 grep Yeah out
>         )

This looks much more succinct and much less noisy. I was perhaps too
focused on "subshells are bad" and less on "let's make a decent
trade-off here".

>> +/*
>> + * Returns NULL if the array is empty. Otherwise, returns the last obje=
ct.
>> + * That is, the returned value is what `object_array_pop()` would have =
returned.
>> + */
>> +inline struct object *object_array_peek(const struct object_array *arra=
y)
>
> I looked, and this would be the first use of `inline` without `static`...

Hm.

>> +{
>> +     return array->nr ? array->objects[array->nr - 1].item : NULL;
>> +}
>> +
>>  typedef int (*object_array_each_func_t)(struct object_array_entry *, vo=
id *);
>>
>>  /*
>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index 27b2cc138e..8377d27b46 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -650,9 +650,10 @@ static void handle_tail(struct object_array *commit=
s, struct rev_info *revs,
>>  {
>>       struct commit *commit;
>>       while (commits->nr) {
>> -             commit =3D (struct commit *)object_array_pop(commits);
>> +             commit =3D (struct commit *)object_array_peek(commits);
>>               if (has_unshown_parent(commit))
>>                       return;
>> +             (void)object_array_pop(commits);
>>               handle_commit(commit, revs, paths_of_changed_objects);
>>       }
>>  }
>
> As I stated above, I think we can make this a bit easier to reason about
> (and less easy to break by future additions) if we avoided the _peek()
> function altogether, like this:
>
>  {
>         struct commit *commit;
>         while (commits->nr) {
>                 commit =3D (struct commit *)object_array_pop(commits);
> -               if (has_unshown_parent(commit))
> +               if (has_unshown_parent(commit)) {
> +                       /* Queue again, to be handled later */
> +                       add_object_array(commits, NULL, commit);
>                         return;
> +               }
>                 handle_commit(commit, revs, paths_of_changed_objects);
>         }
>  }
>
> (I did not test this, and I was honestly surprised that there is no
> object_array_push() counterpart to _pop() ;-) So this might be all wrong.=
)

I was initially torn 50-50 between these two approaches, but now that I
see it, sure it's more verbose and a bit more "back and forth", but most
likely it's less error-prone going forwards.

Thanks a lot for your comments. I will give this some testing, check
that your proposed test fails and succeeds as it should, and so on, then
try to wrap this up. Between you cleaning up the test and providing a
different implementation, there's not much left for me to take credit
for. Can I forge your From: and Signed-off-by: on this?

Thanks a lot for the review.

Martin
