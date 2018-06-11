Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32AE21F403
	for <e@80x24.org>; Mon, 11 Jun 2018 14:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeFKOm3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 10:42:29 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44500 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbeFKOm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 10:42:28 -0400
Received: by mail-ua0-f194.google.com with SMTP id f30-v6so13681166uab.11
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JQKUY4VTZ2g52EzlvotAiggkT147DJeWtgqr0R0cAAc=;
        b=EWHv7dv86oJbgtor+uMfT/7f0u4QylGRpl21IEQCri3vzOSCxvz4Z6o5LV51SsN7wg
         Rxt0U9Q6obMxOvmGuOo3LcER32sN9KlFzYjME1Wt35PDaDxYkxVaAqJDW6GXFZcqkEqR
         OIOxghKmz5Re1y3oVO+f06TQ9f6EGg7j9wd+OESOB7nBCOIA0NslwZC++0G0UQCrpFg4
         9Rgyr4onqVHe+Pyl8ysEPqyJ74WYMmMRrTLr/oeW+Pckcj8LxStKxUdWEDuMAhEHYbUs
         CMMdgeuO/xeLJOJrT71dm3WzAVbBXCxx89AhlkfPjSjRv7yTvhxL43mTjoudRuiykKzh
         /GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JQKUY4VTZ2g52EzlvotAiggkT147DJeWtgqr0R0cAAc=;
        b=Qf237zGbIqD2nJTMnxgjW/cGcIkeax8WAZH7htey3ApaL137DbOxWWPFYVliJ0mUT/
         QJs4LBivJgK6VLVMBvREoC2gR3O/9arI37otY9eH/wg/Uh5KbGGHdmpFdTJlWBMO+Ild
         sHXIpJBxV0mfOd73exsDpHjDx9ANer6XSJmFMm0HgcsMkanLOtikjM7L82VyXGh8oCHT
         HPWVCsb2+2x/OD+RI8lEhqLbkl2UoBGtL29GrFvhU+q6V11SGBb9ux6thh+Gtz2kTD5b
         Am7UO6GVEp34M4sr0lyzICa3WRLSnG0h+1KmjumtLPeT5FBMptP0qVeBCR5/NUcD3rPW
         1qTQ==
X-Gm-Message-State: APt69E0j5gdCUJrOm/SN6Mt6N7NeOSCa2XTFvij0FjReypqeDmZCfrzy
        pVWB8ED4lmipYV/T7Sf7t0l5J2BDZBghJyjejL8=
X-Google-Smtp-Source: ADUXVKLn3j+PgWzK0n4EQbWihM6s4x/cjboMJjYmigXt50oBIIuV7oGiXiH9C0m4ZBM2qd/mN5m3R9+cYJ0eD3gNj9w=
X-Received: by 2002:ab0:596f:: with SMTP id o44-v6mr11519408uad.29.1528728147495;
 Mon, 11 Jun 2018 07:42:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 07:42:26
 -0700 (PDT)
In-Reply-To: <8f19c8c2-d050-2d51-756d-d78b9f2bd335@talktalk.net>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050747.19726-1-newren@gmail.com> <8f19c8c2-d050-2d51-756d-d78b9f2bd335@talktalk.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jun 2018 07:42:26 -0700
Message-ID: <CABPp-BF7POrGTRbVOZ-AGjRHKcpExMQcA4uSPvrRONbnG2CE8w@mail.gmail.com>
Subject: Re: [PATCH] git-rebase.sh: handle keep-empty like all other options
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sun, Jun 10, 2018 at 12:26 PM, Phillip Wood
<phillip.wood@talktalk.net> wrote:
> On 07/06/18 06:07, Elijah Newren wrote:
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>   git-rebase.sh | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 40be59ecc4..a56b286372 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -276,6 +276,7 @@ do
>>                 ;;
>>         --keep-empty)
>>                 keep_empty=yes
>> +               test -z "$interactive_rebase" &&
>> interactive_rebase=implied
>
>
> I think you need to wait until all the options have been parsed before
> setting the implied interactive rebase in case the user specifies has
> '--keep-empty' in an alias and specifies '--no-keep-empty' with some am
> options on the command line.

Ah, indeed you are right.  Let's drop this patch then.

However, we have a bigger problem with empty commits, in that there
are really three modes rather than two:
  * Automatically drop empty commits (default for am-based rebase)
  * Automatically keep empty commits (as done with --keep-empty)
  * Halt the rebase and tell the user how to specify if they want to
keep it (default for interactive rebases)

Currently, only the first option is available to am-based rebases, and
only the second two options are available to interactive-based
rebases.  But if we want to make all three available to
interactive-based rebases, what should the command line option look
like?  --empty={drop,ask,keep}?

(And deprecate but continue to support --[no-]keep-empty?)

And should the two rebase modes really have a different default?  What
should the default be?
