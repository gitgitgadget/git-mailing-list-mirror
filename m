Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F1C1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 03:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeDSD4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 23:56:40 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36791 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeDSD4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 23:56:39 -0400
Received: by mail-ua0-f179.google.com with SMTP id v4so2573403uaj.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 20:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/YN2K9+WwxOfS2Dg+qUEL8i3DzpeKbgNrjWWz3L4u0c=;
        b=du6VLwn9wUB3WKnVIhf3h0BHYlG4CC+93478zN4dYJzghXM4z8h+JCmDyf/M3RSnwA
         OwXD2Tmr7W+Do3IChRTQtOiVH9gIK/bj1mbcAZdsyMIkFrevWAcpXQODMAP3jfQnT0dT
         a7H09BvYAIDgAQV1TC6p54IIo+C0fV3EXY7E7B3rdz4AWss9nDONu6w7zRGLzEkHjNr2
         fwiVts5ZfCY82Dtc/5LDfvPMV4Lo+ZZNw22vcEc/1kUNJ0TFjAf+aFpM/lg/GFGBIoY+
         aKpARQI/X2Tr816h2rBn+6sHxWp3jK5du5IpqEg8KvOzXFgeyXtqgF01jGXKIQ84DbhN
         hSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/YN2K9+WwxOfS2Dg+qUEL8i3DzpeKbgNrjWWz3L4u0c=;
        b=fWjPCpxsO6S1XQH5Bf8I2DPyL7gAyBkofbt4k8mrJf32xlx9zyl0LJdDEaPoTYrS8B
         VZpha/IGvrVXW0osaRQSk+NZ670y36fT3FGmPqI11C9XSuSElF3oTnZCKCzQtKWVgPcl
         ukystFMtyWQGr0BEDWIJ9D7sUDsIur2PklFIjWbsILk0bRSvqbfAfFpv53joaGoOcojw
         9BV4YIeOrh0LOQKPbIzSfU+KiiurlavFm+ovOuXtCUBxGD7P0NctoFbSOGzrZKqwF0n1
         Ss9hE7rH9PdFoy4aInczMKt622/WI0hnONEY9tJCtvcC2VnX3NawxQIDvUXZv8HWRYFN
         AqLg==
X-Gm-Message-State: ALQs6tBUgL0CfAKZYEJ7YTFKZL5zf8cnAFlm3s7Zqw6VvbVOVoYHaBFJ
        e1VSMohgaPiFyvEzlO2BgVv8A7KHFR+VK4OwzTE=
X-Google-Smtp-Source: AIpwx49pOu7YO4pED52QpPxagkRdx23GzeTxcFEkPm7jusVjaywJI2qHi7p5ao5q+edd7xWjYsgGwmAjMLwlby19hxI=
X-Received: by 10.176.112.26 with SMTP id k26mr3418657ual.111.1524110197776;
 Wed, 18 Apr 2018 20:56:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.3.236 with HTTP; Wed, 18 Apr 2018 20:55:57 -0700 (PDT)
In-Reply-To: <CAJZjrdW3X8eaSit85otKV2HvHmu0NDGcnnnrtxHME03q=eWW-Q@mail.gmail.com>
References: <20180418030655.19378-1-sxlijin@gmail.com> <20180418030655.19378-2-sxlijin@gmail.com>
 <CAN0heSqXwVR5cdMwipUdPrnbUyCU8v2GzWK=2-0_ZWoWw3SO2w@mail.gmail.com> <CAJZjrdW3X8eaSit85otKV2HvHmu0NDGcnnnrtxHME03q=eWW-Q@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 18 Apr 2018 20:55:57 -0700
Message-ID: <CAJZjrdXci_vAj2LMJOMJstR0ggEpvjROJX2OwMQ1qmkwAEb4TA@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit: fix --short and --porcelain
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 8:55 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> Thanks for the quick review!
>
> On Wed, Apr 18, 2018 at 11:38 AM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>> Hi Samuel,
>>
>> Welcome back. :-)
>>
>> On 18 April 2018 at 05:06, Samuel Lijin <sxlijin@gmail.com> wrote:
>>> Make invoking `git commit` with `--short` or `--porcelain` return statu=
s
>>> code zero when there is something to commit.
>>>
>>> Mark the commitable flag in the wt_status object in the call to
>>> `wt_status_collect()`, instead of in `wt_longstatus_print_updated()`,
>>> and simplify the logic in the latter function to take advantage of the
>>> logic shifted to the former.
>>
>> The subject is sort of vague about what is being fixed. Maybe "commit:
>> fix return code of ...", or "wt-status: set `commitable` when
>> collecting, not when printing". Or something... I can't come up with
>> something brilliant off the top of my head.
>>
>> I did not understand the first paragraph until I had read the second and
>> peaked at the code. Maybe tell the story the other way around? Something
>> like this:
>>
>>   Mark the `commitable` flag in the wt_status object in
>>   `wt_status_collect()`, instead of in `wt_longstatus_print_updated()`,
>>   and simplify the logic in the latter function to take advantage of the
>>   logic shifted to the former.
>>
>>   This means that callers do need to actually use the printer function
>>   to collect the `commitable` flag -- it is sufficient to call
>>   `wt_status_collect()`.
>>
>>   As a result, invoking `git commit` with `--short` or `--porcelain`
>>   results in return status code zero when there is something to commit.
>>   This fixes two bugs documented in our test suite.
>
> That definitely works better. Will fix when I reroll.
>
>>>  t/t7501-commit.sh |  4 ++--
>>>  wt-status.c       | 39 +++++++++++++++++++++++++++------------
>>>  2 files changed, 29 insertions(+), 14 deletions(-)
>>
>> I tried to find somewhere in the documentation where this bug was
>> described (git-commit.txt or git-status.txt), but failed. So there
>> should be nothing to update there.
>>
>>> +static void wt_status_mark_commitable(struct wt_status *s) {
>>> +       int i;
>>> +
>>> +       for (i =3D 0; i < s->change.nr; i++) {
>>> +               struct wt_status_change_data *d =3D (s->change.items[i]=
).util;
>>> +
>>> +               if (d->index_status && d->index_status !=3D DIFF_STATUS=
_UNMERGED) {
>>> +                       s->commitable =3D 1;
>>> +                       return;
>>> +               }
>>> +       }
>>> +}
>>
>> This helper does exactly what the old code did inside
>> `wt_longstatus_print_updated()` with regards to `commitable`. Ok.
>>
>> This function does not reset `commitable` to 0, so reusing a `struct
>> wt_status` won't necessarily work out. I have not thought about whether
>> such a caller would be horribly broken for other reasons...
>>
>>>  void wt_status_collect(struct wt_status *s)
>>>  {
>>>         wt_status_collect_changes_worktree(s);
>>> @@ -726,7 +739,10 @@ void wt_status_collect(struct wt_status *s)
>>>                 wt_status_collect_changes_initial(s);
>>>         else
>>>                 wt_status_collect_changes_index(s);
>>> +
>>>         wt_status_collect_untracked(s);
>>> +
>>> +       wt_status_mark_commitable(s);
>>>  }
>>
>> So whenever we `..._collect()`, `commitable` is set for us. This is the
>> only caller of the new helper, so in order to be able to trust
>> `commitable`, one needs to call `wt_status_collect()`. Seems a
>> reasonable assumption to make that the caller will remember to do so
>> before printing. (And all current users do, so we're not regressing in
>> some user.)
>>
>>>  static void wt_longstatus_print_unmerged(struct wt_status *s)
>>> @@ -754,26 +770,25 @@ static void wt_longstatus_print_unmerged(struct w=
t_status *s)
>>>
>>>  static void wt_longstatus_print_updated(struct wt_status *s)
>>>  {
>>> -       int shown_header =3D 0;
>>> -       int i;
>>> +       if (!s->commitable) {
>>> +               return;
>>> +       }
>>
>> Regarding my comment above: If you forget to `..._collect()` first, this
>> function is a no-op.
>>
>>> +
>>> +       wt_longstatus_print_cached_header(s);
>>>
>>> +       int i;
>>
>> You should leave this variable declaration at the top of the function.
>>
>>>         for (i =3D 0; i < s->change.nr; i++) {
>>>                 struct wt_status_change_data *d;
>>>                 struct string_list_item *it;
>>>                 it =3D &(s->change.items[i]);
>>>                 d =3D it->util;
>>> -               if (!d->index_status ||
>>> -                   d->index_status =3D=3D DIFF_STATUS_UNMERGED)
>>> -                       continue;
>>> -               if (!shown_header) {
>>> -                       wt_longstatus_print_cached_header(s);
>>> -                       s->commitable =3D 1;
>>> -                       shown_header =3D 1;
>>> +               if (d->index_status &&
>>> +                   d->index_status !=3D DIFF_STATUS_UNMERGED) {
>>> +                       wt_longstatus_print_change_data(s, WT_STATUS_UP=
DATED, it);
>>>                 }
>>> -               wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, i=
t);
>>>         }
>>> -       if (shown_header)
>>> -               wt_longstatus_print_trailer(s);
>>> +
>>> +       wt_longstatus_print_trailer(s);
>>>  }
>>
>> This rewrite matches the original logic, assuming we can trust
>> `commitable`. The result is a function called `print()` which does not
>> modify the struct it is given for printing. Nice. So you can make the
>> argument a `const struct wt_status *`. Except this function uses helpers
>> that are missing the `const`.
>>
>> You fix that in patch 2/2. I would probably have made that patch as 1/2,
>> then done this patch as 2/2 ending the commit message with something
>> like "As a result, we can mark the argument as `const`.", or even just
>> silently inserting the `const` for this one function. Just a thought.
>
> I originally ordered it the way I did because in the constify-first
> scenario, "fix t7501" and "const-ify wt_longstatus_print_updated"
> seemed like two logically separate patches to me (which would have
> made the patch series three patches instead of two). I'm happy to
> reroll in whichever fashion if people care strongly though.
>
>> Martin
