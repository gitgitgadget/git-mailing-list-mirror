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
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B8D1FCCA
	for <e@80x24.org>; Tue, 27 Jun 2017 09:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbdF0JU0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 05:20:26 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34839 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbdF0JUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 05:20:24 -0400
Received: by mail-qt0-f169.google.com with SMTP id f92so19729169qtb.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=F2paZU6CsfpYXubZPmWhXvFHOuTkiSM3vA+R7tgJmlg=;
        b=oAVp6emRnUy2zrk0Dy3YVxFr6n/4bJIK+RsnJEdXvOkmEEs4BYVSmjE5jcrQDwSetL
         rYDR2xjHPlpXVA3uzrdHAW7kbyyJCMzEU9V7L9B/pyAYZfbguzjsqjK7NhBrXgMCsRyx
         7tmpN5WdG6plMghQRIhKkYKlRBT/ikKvr+6Q8NPc88b5UMB3lMcGs/gzthiT1FhO9Ofa
         Q71mW4hVllJpdRk/OE5WXOGH/1InQOr8r87GpmOZFmy9Cevp8UeeB0NCYC1dCihRCu1f
         WW34vgN5ZrcnpVWRZmg506wh8qY2bdR9LWdjtmpvkDE4PhpkpOdDYTjO43XhhPwFgXAr
         Hs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=F2paZU6CsfpYXubZPmWhXvFHOuTkiSM3vA+R7tgJmlg=;
        b=TpByZQarwvyQFnVDOTRSzoxYpejUoSyltr2Lr+PktP7xsediok2OhC5eIHgGxxInB1
         QTFhSyeZUyFc+Sw4Hkp3qOj7U97zzQWmLYnUWry5ozn6OJaG3gXiMTCgfKZxBTdvaZoJ
         TScQZoFvJYjx7KWZLKpAawa1e8Vy4qKfYGSBkFYisccA9sUpxnM2W1gaJeFvPcyc5HHL
         k9zWKuP5C/RsmdYsBETLvHjCsyfQGI8hEJF36LWKcxRlk36ctuHupWP/d0h4WKaeE2Q1
         j0bdzfruQy3Wrh8pExNoX7qd7KbgWiN9QI8B1Ux1g+0yXaDTEMPxlDIcDbroAQBs3/4K
         wU8w==
X-Gm-Message-State: AKS2vOwOT2MSs2Vxz30KfjHUCQY/uiGVLggbp2HG3hA2jdMN/vl9QjwB
        /By1gJifTamiGQrzs8zLC0ZjnSS4Gw==
X-Received: by 10.237.60.19 with SMTP id t19mr5017059qte.206.1498555223220;
 Tue, 27 Jun 2017 02:20:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Tue, 27 Jun 2017 02:20:22 -0700 (PDT)
In-Reply-To: <CAKYtbVbGekXGAyPd7HeLot_MdZkp7-1Ss-iAi7o8ze2b+sNB6Q@mail.gmail.com>
References: <1497961141-3144-1-git-send-email-miguel.torroja@gmail.com>
 <xmqq4lv8kjxo.fsf@gitster.mtv.corp.google.com> <CAE5ih78YFSjcn6RNGzdxsjvn6B7xvHMgKKRqirjW00=9hWpDYA@mail.gmail.com>
 <DCC54592-4010-46D5-98A9-B7B4D1467169@gmail.com> <CAKYtbVbGekXGAyPd7HeLot_MdZkp7-1Ss-iAi7o8ze2b+sNB6Q@mail.gmail.com>
From:   miguel torroja <miguel.torroja@gmail.com>
Date:   Tue, 27 Jun 2017 11:20:22 +0200
X-Google-Sender-Auth: eHlQ8z8BkbG5Q2jA509jcQ97AQI
Message-ID: <CAKYtbVY_=aMjcS=r2YyhcxKiUAaJUJA=OELTvXfau4GGz7Lz4Q@mail.gmail.com>
Subject: Re: [PATCH] git-p4: changelist template with p4 -G change -o
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "Junio C Hamano (Gitster)" <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars/Luke,

I tried a first test extending t9807-git-p4-submit.sh. I set this p4
trigger: 'p4test command pre-user-change "echo verbose trigger" '. I'm
able to reproduce the issue I wanted to fix. However I found yet
another issue, in this case when reading the result from
p4_read_pipe_lines (in function p4ChangesForPaths), the
pre-user-change is triggered with any "p4 change" and "p4 changes"
command (the p4 server we have in production, only shows "extra"
messages with p4 change).
   I'll collapse in one single commit the fix for p4 change/p4 changes
and the new test.

Thanks,

Miguel

On Sat, Jun 24, 2017 at 10:37 PM, miguel torroja
<miguel.torroja@gmail.com> wrote:
> Hi Lars,
>
> I think it's doable to set a custom p4 trigger, created by the test case,
> that outputs "extra info" when requesting a changelist description.
> I'll do a specific test and post it to this thread.
>
>
> Thanks,
>
>
> El 24 jun. 2017 7:36 p. m., "Lars Schneider" <larsxschneider@gmail.com>
> escribi=C3=B3:
>
>
>> On 24 Jun 2017, at 13:49, Luke Diamand <luke@diamand.org> wrote:
>>
>> On 22 June 2017 at 18:32, Junio C Hamano <gitster@pobox.com> wrote:
>>> Miguel Torroja <miguel.torroja@gmail.com> writes:
>>>
>>>> The option -G of p4 (python marshal output) gives more context about t=
he
>>>> data being output. That's useful when using the command "change -o" as
>>>> we can distinguish between warning/error line and real change
>>>> description.
>>>>
>>>> Some p4 plugin/hooks in the server side generates some warnings when
>>>> executed. Unfortunately those messages are mixed with the output of
>>>> "p4 change -o". Those extra warning lines are reported as
>>>> {'code':'info'}
>>>> in python marshal output (-G). The real change output is reported as
>>>> {'code':'stat'}
>>
>> I think this seems like a reasonable thing to do if "p4 change -o" is
>> jumbling up output.
>>
>> One thing I notice trying it out by hand is that we seem to have lost
>> the annotation of the Perforce per-file modification type (is there a
>> proper name for this?).
>>
>> For example, if I add a file called "baz", then the original version
>> creates a template which looks like this:
>>
>>   //depot/baz    # add
>>
>> But the new one creates a template which looks like:
>>
>>   //depot/baz
>
> @Miguel: You wrote that p4 plugins/hooks generate these warnings.
> I wonder if you see a way to replicate that in a test case. Either
> in t9800 or a new t98XX test case file?
>
> - Lars
>
>
