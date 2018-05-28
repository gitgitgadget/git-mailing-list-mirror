Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490DF1F42D
	for <e@80x24.org>; Mon, 28 May 2018 18:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754726AbeE1Spv (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 14:45:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45165 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754663AbeE1Spu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 14:45:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id b130-v6so11014964oif.12
        for <git@vger.kernel.org>; Mon, 28 May 2018 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8WVGsmUVttkXXJifEuwE0XGN4QLwloOpIqFLABj+7Mo=;
        b=Qblrtj95JS/+uT1seldClpnTJybfjj83hxANC6N5CGmLL6dNKSdY7FC6885oQR4q8q
         EYHgpphy10cmtNR5ucvnNQHZkHgaYxblaUTkjgFdoPcKKY69SOnwKF7q5SxnMVT8jZVx
         DTzgXIhWkX+u52Y9eqhFPV9rCrH40Ia8W0E58qQUf0lUEV0WDWyfeVds8i6gl8rgeEd7
         udyTj+j4bY9NdyKAwc7hHbQxgy/x3I1+r67ag80PDTQTE3BpI8PP+IdvrC0ZT/PT/Wpy
         5lMWRL6xLQiZ87nU93Ov5+da/V4KX/p7l54kKWSxFLGm8jlzflWAAufMH85Afkgx5Bc1
         L9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8WVGsmUVttkXXJifEuwE0XGN4QLwloOpIqFLABj+7Mo=;
        b=j5swSL3LSUzBQXfYFCpm4NowzXI1yldVwBYaY9au45cYODeLBuImx2ooCUMnETd+BV
         q9X3PHA24FigKXzv/KpVzkUea8orBzJgkfPeFzfHRyTD8j3wf8IoS9oOyyaFESwfDeHx
         lXiGJ2JidVNE23Ar04ZEFPHQT9tdP2Alyw+hHWPqJk19pIMBCyZMpoCkpLC5y5m1cCQy
         ZjlNvUctib/2+f6cywmkSRQiFHk4HC/1UMSYZICpgwriRSik6Z3EzcTB4aFqWspewQDd
         UJgJG2+Ze5XYoIKXYLoq0YN5+G/RyGU1BcWBybzBZV++T963pg31IeErUSCDioph0gu6
         5i1w==
X-Gm-Message-State: ALKqPwcrinOOgae1hXeG0TknwuCs14vuAUH1wFa6N2WHSH3Y9uiZOfSk
        ZbOqlAwvjntOxxw6kpKPwQrnJplpgyY4RHlFDiI=
X-Google-Smtp-Source: ADUXVKJR3JESEPt8ujZg+plgrVCh8atuJwodUefCGHhjTasMI2NU3u2U6knh7JEoXeXYO+BwW6zg97ermbX8InVE8jg=
X-Received: by 2002:aca:52c3:: with SMTP id g186-v6mr8362675oib.228.1527533149722;
 Mon, 28 May 2018 11:45:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Mon, 28 May 2018 11:45:19
 -0700 (PDT)
In-Reply-To: <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
 <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
 <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 28 May 2018 20:45:19 +0200
Message-ID: <CACsJy8CgzDfbES2jC+Rv+bKj_JAk8dzEDCm89JMuBFQmyGg9Gw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just
 the first
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 11:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sp=
arse-checkout.sh
>> index 0c6f48f302..31b0702e6c 100755
>> --- a/t/t1011-read-tree-sparse-checkout.sh
>> +++ b/t/t1011-read-tree-sparse-checkout.sh
>> @@ -243,9 +243,9 @@ test_expect_success 'print errors when failed to upd=
ate worktree' '
>>       test_must_fail git checkout top 2>actual &&
>>       cat >expected <<\EOF &&
>>  error: The following untracked working tree files would be overwritten =
by checkout:
>> -     sub/added
>> -     sub/addedtoo
>> -Please move or remove them before you switch branches.
>> +error:       sub/added
>> +error:       sub/addedtoo
>> +error: Please move or remove them before you switch branches.
>>  Aborting
>>  EOF
>
> This shows the typical effect of this series, which (I subjectively
> think) gives us a more pleasant end-user experience.

Also, very subjectively, I'm torn about this. To me, just one
"error/warning/fatal" at the start of the first paragraph feels much
better. If we have to somehow mark the second paragraph that "this is
also part of the error message" then it's probably better to rephrase.
--=20
Duy
