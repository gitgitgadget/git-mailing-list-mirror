Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCA431F51C
	for <e@80x24.org>; Thu, 17 May 2018 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeEQSVA (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 14:21:00 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38855 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeEQSU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 14:20:58 -0400
Received: by mail-yb0-f195.google.com with SMTP id w14-v6so1787852ybm.5
        for <git@vger.kernel.org>; Thu, 17 May 2018 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J9gbsm9djcD2AWCpdk1+9JYDrWh4LahGZ/8OZeAsT68=;
        b=gFSqZ8uxd0m2vsktSmC0N8hp+QgIhWYhZc3k8NtllpYN3yvJCGt3kjKAXHvyM3vItn
         zB02VVoSrEvZAOA000Vutk12sWWbBRxLfIykd+SsJUB0Htf4a03iKgSXkfs4pl+W/Tyw
         lXjnlamtqbnPdlYN6MYVvd0PHoixIavzi864MvTDtjpTXkp+MVNiTiKRbCclQUTWse64
         KfJAaLdJxYn+SG7OF2Y6H10V6CxeG8wxYM61hzniT/aEBni/oRW3Y3VR5BTIdInhgmYt
         jkQvIJrHq9ZcA4C+GMS1RV6nMekI/1WHWFz9RaEOjG5FaPAghWV6tBHSi0rToqAQhyJb
         m8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J9gbsm9djcD2AWCpdk1+9JYDrWh4LahGZ/8OZeAsT68=;
        b=ZH3E2gp+1KIVFWjUwP8AMGcrbLu3DU9pufIuqLmc/4Z8PmI9T3Hwp5MrSXGNBrTmVz
         TBr63HCz7WqrPFYaeJ30i2kf3XKilFPhVouNTfdaJIQOs110Lhxb4jZvvCv4n1CO4uZt
         MdnNOAD1jRjxsnakb918tQJ1IsYu8/oWO2QSQ2rGX+XadvTk36p5LX3BY18Xwcn4HL/J
         /t60FwhfZqHjvNmPZbs453vYXt6UA584kB974q3Jh8WWOc/Z4H/cRhsIvZQnL2uspZ/x
         jn//5bRM2pJVNMp/XJGrW+UnMePsVyXnizKB6vSNWn0GE7I7ss9lmcxSyrrvvYXbSdQM
         KuOA==
X-Gm-Message-State: ALKqPwfVUKuBKZzjIkGYj8cnMLLGt1E3IvRN+NNV0Y9Iys+Isfq4d8rV
        krOd1qv6LSLyZgh36A/SMkWwd4DZ9MK6fODWEyT4fg==
X-Google-Smtp-Source: AB8JxZpJxcKAagZsN2Xw7lyIPC9r/fua0U/38a2Kh0WExvk3JJllYouCSsjSG5yv+hCD/Iaar+t2pcD7HG/AUYWziTo=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr3460463ybc.307.1526581257706;
 Thu, 17 May 2018 11:20:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 17 May 2018 11:20:57
 -0700 (PDT)
In-Reply-To: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 May 2018 11:20:57 -0700
Message-ID: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #02; Thu, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/object-store-replace (2018-05-10) 2 commits
>   (merged to 'next' on 2018-05-16 at 41bbedcc81)
>  + replace-object.c: remove the_repository from prepare_replace_object
>  + object.c: free replace map in raw_object_store_clear
>
>  Hotfix.
>
>  Will merge to 'master'.

Please do not.
(Or do, but then be prepared for another hotfix.)

The commit sb/object-store-replace^ needs more free'ing and shall be
replaced with
https://public-inbox.org/git/20180510195849.28023-4-sbeller@google.com/
I'll resend shortly.

>
> * sb/submodule-merge-in-merge-recursive (2018-05-16) 3 commits
>  - merge-recursive: give notice when submodule commit gets fast-forwarded
>  - merge-recursive: i18n submodule merge output and respect verbosity
>  - submodule.c: move submodule merging to merge-recursive.c
>
>  By code restructuring of submodule merge in merge-recursive,
>  informational messages from the codepath are now given using the
>  same mechanism as other output, and honor the merge.verbosity
>  configuration.  The code also learned to give a few new messages
>  when a submodule three-way merge resolves cleanly when one side
>  records a descendant of the commit chosen by the other side.
>
>  Will merge to 'next'.

Merging would be ok, but I would rather not.
A resend will be only for cosmetic effect, as I messed up the last commit

So, please hold in pu.

> * sb/diff-color-move-more (2018-04-25) 7 commits
>  - diff.c: add --color-moved-ignore-space-delta option
>  - diff.c: decouple white space treatment from move detection algorithm
>  - diff.c: add a blocks mode for moved code detection
>  - diff.c: adjust hash function signature to match hashmap expectation
>  - diff.c: do not pass diff options as keydata to hashmap
>  - xdiff/xdiffi.c: remove unneeded function declarations
>  - xdiff/xdiff.h: remove unused flags
>
>  "git diff --color-moved" feature has further been tweaked.
>
>  Will merge to 'next'.

I did not get around to fix it up, there are still review
comments outstanding. (The test is broken in the last commit.)

Please hold in pu;

Thanks,
Stefan
