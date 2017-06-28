Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F541FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 13:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdF1NOd (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 09:14:33 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34730 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdF1NOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 09:14:31 -0400
Received: by mail-qk0-f174.google.com with SMTP id d78so49934934qkb.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ivg4RTu9US8N2iEaxtUzTc6Xfi4vpR8/QxgqPY21bus=;
        b=An5ifKew/OFObxmzfSg1ywgfZQ9fZTGJR0Ngi6CaUwJSR2RrdEuDKsiuK4DI8EgHMe
         95ghUIo4qz9DyCqx9Y0A2qLQWpBC/09g+YCev5Ko+ITEUZiyVBDxG91Gog5Ctlb2tOak
         w6dNuWA1ONxkEG7ZUK23xl+CnSSL8IFL7WuAkhriqzPwowcqksNpr9Ts5X0STU/susMq
         PZVNx+pad07WtU2ZFvdVETqJOa1mbfNiJh5Anh+IXhfbPs00Ax84a/2AInaoQ+49qWwA
         LpVhL9ACqMDHrVlyt4a/wDzSRJ+aEd1EDw7iOeiTbTa+GP+j0WhdzhKVi82YwrcfWWzO
         lC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ivg4RTu9US8N2iEaxtUzTc6Xfi4vpR8/QxgqPY21bus=;
        b=I7c674N5vaEce3dVovUFJHkKAQCZH01n+DPE+rUVB5LBR/wMv8SQ10DN+KDRRT5hM2
         c/nF6nNIWPQ6GfqH58D92eaXHeyFgqvTN6P5rWRVZ5YjZV9qW4K9IX0yuJZAKkHW1ezz
         9S6oKRXG4CRXvuqLjjIthF0MoQSfkQ3kgIAp8ZgkfnRleDRn47H8ZTTUdnShqSkhZneh
         /G3TZCzQ1/fbPDOiScaCalyP5pDk2YZGqRZ8ZXKG+EyCcU5/2UQa+B0xO0jtIwMSaa44
         pe0wGvZ8j91uKgHuJDT457GMyqo8rn7WwHJap2+mi8Ug9Hf1mN0IEqWfYwjdzKaTcYco
         Uyqg==
X-Gm-Message-State: AKS2vOwm/KI6GhprRhtkQqa49qWHsLYdHdMA6scRY2/NEDvEkGJcYbii
        mlqS5ac/sr6FsulyQDW8OrxmkqO/rA==
X-Received: by 10.55.19.142 with SMTP id 14mr12409079qkt.78.1498655670398;
 Wed, 28 Jun 2017 06:14:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Wed, 28 Jun 2017 06:14:29 -0700 (PDT)
In-Reply-To: <CAE5ih78VwBVT+XHnwgnt-JcLB-c4d_Gf+9Wfb_bL=LcgkjDrUQ@mail.gmail.com>
References: <CAKYtbVY_=aMjcS=r2YyhcxKiUAaJUJA=OELTvXfau4GGz7Lz4Q@mail.gmail.com>
 <20170627191704.4446-1-miguel.torroja@gmail.com> <xmqqk23wycso.fsf@gitster.mtv.corp.google.com>
 <CAE5ih78VwBVT+XHnwgnt-JcLB-c4d_Gf+9Wfb_bL=LcgkjDrUQ@mail.gmail.com>
From:   miguel torroja <miguel.torroja@gmail.com>
Date:   Wed, 28 Jun 2017 15:14:29 +0200
X-Google-Sender-Auth: XdsJiovkN7G55MvparvLdZ_n6_M
Message-ID: <CAKYtbVaLkt6_rFgehgSsrLzo-oO3sEVoMLBtS5XX59ymYYS7=w@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Luke,

regarding the error in t9800 (not ok 18 - unresolvable host in P4PORT
should display error), for me it's very weird too as it doesn't seem
to be related to this particular change, as the patch changes are not
exercised with that test.

The test 21 in t9807 was precisely the new test added to test the
change (it was passing with local setup), the test log is truncated
before the output of test 21 in t9807 but I'm afraid I'm not very
familiar with Travis, so maybe I'm missing something. Is there a way
to have the full logs or they are always truncated after some number
of lines?

I think you get an error with git diff --check because I added spaces
after a tab, but those spaces are intentional, the tabs are for the
"<<-EOF" and spaces are for the "p4 triggers" specificiation.

Thanks,


On Wed, Jun 28, 2017 at 11:54 AM, Luke Diamand <luke@diamand.org> wrote:
> On 28 June 2017 at 05:08, Junio C Hamano <gitster@pobox.com> wrote:
>> Miguel Torroja <miguel.torroja@gmail.com> writes:
>>
>>> The option -G of p4 (python marshal output) gives more context about the
>>> data being output. That's useful when using the command "change -o" as
>>> we can distinguish between warning/error line and real change description.
>>>
>>> Some p4 triggers in the server side generate some warnings when
>>> executed. Unfortunately those messages are mixed with the output of
>>> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
>>> in python marshal output (-G). The real change output is reported as
>>> {'code':'stat'}
>>>
>>> A new test has been created to t9807-git-p4-submit.sh adding a p4 trigger
>>> that outputs extra lines with "p4 change -o" and "p4 changes"
>>>
>>> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
>>> ---
>>
>> It appears that https://travis-ci.org/git/git/builds/247724639
>> does not like this change.  For example:
>>
>>     https://travis-ci.org/git/git/jobs/247724642#L1848
>>
>> indicates that not just 9807 (new tests added by this patch) but
>> also 9800 starts to fail.
>>
>> I'd wait for git-p4 experts to comment and help guiding this change
>> forward.
>
> I only see a (very weird) failure in t9800. I wonder if there are some
> P4 version differences.
>
> Client: Rev. P4/LINUX26X86_64/2015.1/1024208 (2015/03/16).
> Server: P4D/LINUX26X86_64/2015.1/1028542 (2015/03/20)
>
> There's also a whitespace error according to "git diff --check".
> :
> Sadly I don't think there's any way to do this and yet keep the "#
> edit" comments. It looks like "p4 change -o" outputs lines with "'#
> edit" on the end, but the (supposedly semantically equivalent) "p4 -G
> change -o" command does not. I think that's a P4 bug.
>
> So we have a choice of fixing a garbled message in the face of scripts
> in the backend, or keeping the comments, or writing some extra Python
> to infer them. I vote for fixing the garbled message.
>
> Luke
