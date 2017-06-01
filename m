Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA3720D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 16:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbdFAQKB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 12:10:01 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34621 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdFAQJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 12:09:59 -0400
Received: by mail-pf0-f171.google.com with SMTP id 9so31193600pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qm4NZTVIQqJMVSSat9B7VtV/S9vh5NHkScICKJccBlI=;
        b=sl7Xy7wO9Fleaclu4Cc7z2CyUDxJfchxHAG9c5mvQQWNt1qSXdQWNYambQB7bPVHFR
         4LlN0Ga5rnFPzd8/u1soZgZN57FaLI+GmX7ph6Q18SeOoKFdZHNoJhSDw7lQ2TMRLSLq
         BHkLqmzu6gY4qcW3lwOojwflM7Ty0lxvces9/NXZJBxjFvQD8ivJUn+qk4waR2rZ8nRS
         zgmeyVJkrSi8455fgU+zFRqqk9ulpwE5BjzAsp+i3ncYmv18HKwDMRs1DUgTd370LZb6
         XI0d8kfBM6occyCVWq/qNIKH75pRxNtUYFE+enpKwdtjXjLZKPYn7hWFX0BxGzEOAX3I
         re4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qm4NZTVIQqJMVSSat9B7VtV/S9vh5NHkScICKJccBlI=;
        b=R9OdHhK59vK9eLeoGDiYscobM5IGOGc/gahntxep9z0Ydaj4nPBv9H1uQEAq6FrMqw
         z4t5lKcUseVRYpQPLnUqk+RaRtEIXefs+tL9Z0eUOzsItFUN6GyzwicPcBiLraokjWMq
         4LRVPND7vdqYh172QzkN6PS9ILbVvohFzC0MyY73wFa/O7UG/mTcbQ7ncRkh+TTacpJV
         gCK4E9NEKPIRWjSmxYCpzGc4LeYe5zd4bQrtwiuDN/FDtdMdM+RQ9XxtnEbpnwK828wm
         wi3lbR9KVQwHZ7qxryAU//nk1h0V4k1Udej2HYVtiLt4tLlQ2kHoBnGJGi8zB0w43hGc
         uSsw==
X-Gm-Message-State: AODbwcDVJuxijttN6hmehDjtd6mEPgklO/ud9EoVp3KwVLB/xK2mXRPE
        1RWFNcipGuGkq1CVlJyrlPEen3xFVA==
X-Received: by 10.98.112.135 with SMTP id l129mr1738413pfc.27.1496333398816;
 Thu, 01 Jun 2017 09:09:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.151.14 with HTTP; Thu, 1 Jun 2017 09:09:36 -0700 (PDT)
In-Reply-To: <xmqqfufk8oik.fsf@gitster.mtv.corp.google.com>
References: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
 <0102015c60dcf680-4a036e9e-c152-41d2-a932-b44c1a5bf68e-000000@eu-west-1.amazonses.com>
 <xmqqfufk8oik.fsf@gitster.mtv.corp.google.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Thu, 1 Jun 2017 18:09:36 +0200
Message-ID: <CALiud+nAvo2fPaDV+aRUCPguvmO+CmpSQVEQZp51NwmyBrBQ2w@mail.gmail.com>
Subject: Re: [PATCH/RFC v2 2/6] branch: add copy branch option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 3:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sahil Dua <sahildua2305@gmail.com> writes:
>
>> Adds copy branch option available using -c or -C (forcefully).
>>
>> Includes a lot of function renames and their signature changes in order
>> to introduce a new function parameter - flag 'copy' which determines
>> whether those functions should do operation copy or move.
>>
>> Additionally, this changes a lot of other files wherever the renamed
>> functions were used. By default copy=0 is passed at all those places so
>> that they keep behaving the way they were, before these changes.
>
> Things like rename_branch() that is narrowly confined inside a
> single program (i.e. builtin/branch.c), if renaming and copying
> shares a lot of logic and there is only a single caller to rename,
> it may be OK to rename the function to rename_or_copy_branch() and
> pass a new "are we doing copy or move?" parameter, but for lower
> level infrastructure like config_rename_section(), I am afraid to
> say that such a change is totally unacceptable.  When the current
> callers are content with rename_section(), and have no need to ever
> copy, why should they be forced tocall copy-or-rename with copy set
> to 0?
>
> When the original code looks like:
>
>
>     == caller (there are many) ==
>
>     rename_it(a, b);
>
>     == implementation (only one) ==
>
>     int rename_it(src, dst) {
>         ... logic to create dst by copying src ...
>         ... logic to remove src ...
>     }
>
> You could introduce a common helper
>
>     == implementation ==
>
>     int rename_or_copy_it(src, dst, copy?) {
>         ... logic to create dst by copying src ...
>         if (!copy?) {
>             ... logic to remove src ...
>         }
>     }
>
> but to help the current code (and possibly code somebody _else_ is
> developing elsewhere), you can also do it in a much less disruptive
> way.
>
>     == implementation ==
>
>     static int rename_or_copy_it(src, dst, copy?) {
>         ... logic to create dst by copying src ...
>         if (!copy?) {
>             ... logic to remove src ...
>         }
>     }
>
>     int rename_it(src, dst) {
>         return rename_or_copy_it(src, dst, 0);
>     }
>
>     int copy_it(src, dst) {
>         return rename_or_copy_it(src, dst, 1);
>     }
>
> Existing callers of "rename" that are not interested in your new
> "copy" thing can be left oblivious to it if you did it that way.
>

Thanks for your comments. I was already a little sceptic about making
changes in all the callers for config_rename_section function. I will
make the changes to have a helper function so that the existing
callers of this method aren't affected at all.
