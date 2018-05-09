Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C66F1F424
	for <e@80x24.org>; Wed,  9 May 2018 19:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965935AbeEITsA (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 15:48:00 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:54063 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965773AbeEITqw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 15:46:52 -0400
Received: by mail-wm0-f51.google.com with SMTP id a67-v6so399909wmf.3
        for <git@vger.kernel.org>; Wed, 09 May 2018 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Aod4EONr6LA3nRYRg3acPnEi0SEXPoWnGx7XtTiOOwo=;
        b=btDGbmBMS01YZB+Weed4BFTUWbr8sRNPgGN5o3ts1UnMRG8JAvZKiwJfe3hTv2F4yf
         TH0ZiccgP2Y4Nc8suTJ1WRA9pBkJHtgqBGYqAH67+3CgtFJYojsn1ih5PghCIs7mgeaQ
         Hrx8QFjxAeLigCrkatKeSwTXE+fX032LQGwPUeMsXxxo50FuE4Cbs1YDxqa2SGbp61hy
         2LYcGMGLGjpxyqhypQ8VdMSUtbIktLUqiBkl0mUewyKfwzBTgwwsc8He7cwcVKfDCCT2
         D8IpPeysd8Tx4jPonJZKo/6sseRYh1G3ljnY5q9jR2TyaPu5yr0Qj/OutLcmUeyPUGLo
         QDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Aod4EONr6LA3nRYRg3acPnEi0SEXPoWnGx7XtTiOOwo=;
        b=BPPhj/bQLrvNsVkaCKTnPDKTGJbWN3vCCx7I5kcYiivpEK1B56f3V6sWVTKWQq0qaD
         VyZ2Ka3x7kt8GC6UkgwQ9pWnYoD/ukSK4tXsmYvzTUt8tyTs2e5tWdn9WqYhPRDXXYvq
         z0DcvFzYBvQQ6HOCsPtZhwrf2Dlmvb8E+KkZBc84KLwdsTH3t15O/IC+SF26TGaGSFKP
         hNjr9McDc/RlUW9RqEF7W4pjtostrdUl2iGtkj67BEEr9UqjGphxoVoBdBj6gp4d7TVr
         o6MkRGaAjG+Cx4NfO1n9ohDCjG9MYwdvT+0UK4484Eu9bxV9Orap/adZ5nGK7GbdwrnJ
         oEhw==
X-Gm-Message-State: ALKqPwf/zIe4rWUbpDAfdLoZrwIIok1nFNptE3NmSsw8sRYgi/tP8xg3
        zPSqmAj0f00zRJaiJygtKQsaB6cSFGjRVLeg0ls=
X-Google-Smtp-Source: AB8JxZpor0+aimTFHXLE4O7KVTMczfw1kXNJMSBV+d3Lm0PdAiB4BMv+2AY8j2hjWwQA3KRAoQxLqDTd/v9hTyKLyW8=
X-Received: by 10.28.48.70 with SMTP id w67mr6298874wmw.47.1525895211683; Wed,
 09 May 2018 12:46:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.152.138 with HTTP; Wed, 9 May 2018 12:46:31 -0700 (PDT)
In-Reply-To: <98279912-0f52-969d-44a6-22242039387f@xiplink.com>
References: <CAFU8umjyrJc1m65hu6QMQUiNmsJtbV65tovcWjvmzFpsCr668A@mail.gmail.com>
 <CAGZ79kb05U91_Ku7DKuwQVCrtouYwGWTCPdJFQ=bgWo91inRGA@mail.gmail.com> <98279912-0f52-969d-44a6-22242039387f@xiplink.com>
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Wed, 9 May 2018 22:46:31 +0300
Message-ID: <CAFU8umhPCTTUc=EZYGDhFe=GeW7_GdyrqZU0DVg7xYaE+Ajg2A@mail.gmail.com>
Subject: Re: Is rebase --force-rebase any different from rebase --no-ff?
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried to compare --force-rebase VS --no-ff for the following repository:
http://jmp.sh/E7TRjcL

There's no difference in the resulf of:
git rebase --force-rebase 54a4
git rebase --no-ff 54a4

(rebases all 3 commits of feature)

Also, there's no difference in interactive mode:
git rebase --force-rebase -i 54a4
git rebase --no-ff -i 54a4

(picks all 3 commits of feature)

Is there a case where --no-ff differs from --force-rebase?

---
Best Regards,
Ilya Kantor


On Wed, May 9, 2018 at 10:27 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> On 2018-05-09 02:21 PM, Stefan Beller wrote:
>>
>> +cc Marc and Johannes who know more about rebase.
>>
>> On Wed, May 9, 2018 at 9:01 AM, Ilya Kantor <iliakan@gmail.com> wrote:
>>>
>>> Right now in "git help rebase" for --no-ff:
>>> "Without --interactive, this is a synonym for --force-rebase."
>>>
>>> But *with* --interactive, is there any difference?
>>
>>
>> I found
>>
>> https://code.googlesource.com/git/+/b499549401cb2b1f6c30d09681380fd519938eb0
>> from 2010-03-24
>
>
> In the original discussion around this option [1], at one point I proposed
> teaching rebase--interactive to respect --force-rebase instead of adding a
> new option [2].  Ultimately --no-ff was chosen as the better user interface
> design [3], because an interactive rebase can't be "forced" to run.
>
> At the time, I think rebase--interactive only recognized --no-ff.  That
> might have been muddled a bit in the migration to rebase--helper.c.
>
> Looking at it now, I don't have a strong opinion about keeping both options
> or deprecating one of them.
>
>                 M.
>
> [1] https://public-inbox.org/git/4B9FD9C1.9060200@xiplink.com/t/
> [2]
> https://public-inbox.org/git/1269361187-31291-1-git-send-email-marcnarc@xiplink.com/
> [3] https://public-inbox.org/git/7vzl1yd5j4.fsf@alter.siamese.dyndns.org/
>
>
>>      Teach rebase the --no-ff option.
>>
>>      For git-rebase.sh, --no-ff is a synonym for --force-rebase.
>>
>>      For git-rebase--interactive.sh, --no-ff cherry-picks all the commits
>> in
>>      the rebased branch, instead of fast-forwarding over any unchanged
>> commits.
>>
>>      --no-ff offers an alternative way to deal with reverted merges.
>> Instead of
>>      "reverting the revert" you can use "rebase --no-ff" to recreate the
>> branch
>>      with entirely new commits (they're new because at the very least the
>>      committer time is different).  This obviates the need to revert the
>>      reversion, as you can re-merge the new topic branch directly.  Added
>> an
>>      addendum to revert-a-faulty-merge.txt describing the situation and
>> how to
>>      use --no-ff to handle it.
>>
>> which sounds as if there is?
>>
>> Stefan
>>
>
