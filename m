Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4895F1F859
	for <e@80x24.org>; Sat, 20 Aug 2016 02:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbcHTCdY (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 22:33:24 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34669 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbcHTCdX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 22:33:23 -0400
Received: by mail-yw0-f180.google.com with SMTP id z8so23426790ywa.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 19:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3kmX04EFGzQIkWBo3KyyeGLmWHpNwKFYQ1Ue0OQ4Ob0=;
        b=YPi9CssjSQ1RDTrdgUJ4w6I1dy/qhdGA1a8OULFfrqpK0hGYw06/Iq+6GAJYkZ8NOp
         1Zf18es08ba2BSq25I5j+rAblkI8W7dJWv2Xy6yMUqjBqsz1qITtj6aj+26/kW57RFyH
         1oHE0Im5RSa3fq/A2s0E3OhEaNkIY0UHBxF7JuDXm/RWWJFjDHZxD8EBYMkR2qwxkyVg
         I9SUeJJD3XCiMyheD6BbKvsaTWqn4C1uN9kfZ37G43CEdferWkpGvSgcFa6yn/Tg7wT4
         VkmZfgUuxmXFYNeTxHJ0z8VJFlyMePCHEojIAEfjAojbbYwEs9bXt7BysWPDLKjHnLQN
         G6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3kmX04EFGzQIkWBo3KyyeGLmWHpNwKFYQ1Ue0OQ4Ob0=;
        b=FRAJdUR0TL4iLE27FGQwzWotEEYLQ403tAk0xeHo3LQvrEuoNNHvnE9QWrQ0Wmdf1F
         wWjOHajZmbMMxSiiAZ7d8iu1oVPqaRcRT0Qp9wr+I2IjXQTlbFzMfRS0n/9pW9+Q/mWQ
         ihSk7SbOiU2ZaQB40yyymLey5s3LPiTcNl5V5oWoCQ4hmiJILQEac98TjGKsTcSLaWK/
         kr0uZBLwsXwryAJn++jRlwrZuyfFc2Yuh5cjjlkfwL2LP6M+VT+bqTIUF2VGGUhvStur
         TpH99JWG4bWEVQR4goBO+urKP03wDrUdfrNIV3M+B7wIfIzGvjw7arbFdj9MYUlkIkUp
         g9uQ==
X-Gm-Message-State: AEkoouv4/g8bFY9dB484c3sqZpcvzMBwIOlT/fkDUgct1XbThWBnobyi+R7f+r0Jo2kf196GHDPruGErcZ82Cw==
X-Received: by 10.129.14.213 with SMTP id 204mr9096043ywo.317.1471660402478;
 Fri, 19 Aug 2016 19:33:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Fri, 19 Aug 2016 19:33:02 -0700 (PDT)
In-Reply-To: <CAGZ79ka3QEMUV6YYa74UZPZXQA1hnbCCZOCG9jZt1BPjJ0Kb8Q@mail.gmail.com>
References: <xmqq4m6h69wz.fsf@gitster.mtv.corp.google.com> <CAGZ79ka3QEMUV6YYa74UZPZXQA1hnbCCZOCG9jZt1BPjJ0Kb8Q@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Fri, 19 Aug 2016 19:33:02 -0700
X-Google-Sender-Auth: TkqKha_FMjdoQc9f2rhBwhdWx78
Message-ID: <CAPc5daWAvn6-Gv88WaWhnus35Bn_Twj2LH0cznwraQx11wX1yg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #07; Thu, 18)
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 4:46 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>> * sb/submodule-clone-rr (2016-08-17) 8 commits
>>
>>  I spotted a last-minute bug in v5, which is not a very good sign
>>  (it shows that nobody is reviewing).  Any more comments?
>
> nobody except you ;)

OK, it shows that nobody competent enough to find easy bugs is reviewing ;-)
IOW, I do not trust a review in this area done by myself alone.
