Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0718A1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 21:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbdHPVPx (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 17:15:53 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36572 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbdHPVPv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 17:15:51 -0400
Received: by mail-wr0-f171.google.com with SMTP id x43so27230238wrb.3
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Mp2QB5GZnDqKUz2291/exluKPntAiJ0um0fj32JvQ7Q=;
        b=Ui4C7iqt6IVp62kSKrCESVL45QrhJWRwlzFdZ7XTwYv5qqorUdp1G9HPaMhGXTP6IA
         YSFuE2+XOHkVu/X6EQpuAmTBJshNlN988cFXqrUSif7BNLFv8OTnMp1mWsh1/gANA8QB
         g5bTK9FJ0MkQLLitG3JcySnQXfcHp9nYJ6J3MqKj5Dp7VkKP+yqALK4UepdguPF4HrMJ
         nIUsTt747B5qrgd7pDSfP171JvFooMKX26eZWWO/eNWU+fgVZYmIPGAl5z7ogoWDqAUi
         RIsiWdLMjCFlxA/61n+Jx1hfCyjc4kikkWXO3mdpM8JDLNn8wCB1NJWbbAaqhKj8g1g8
         bSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mp2QB5GZnDqKUz2291/exluKPntAiJ0um0fj32JvQ7Q=;
        b=Zes86OZbafp6GO07eMa7ZVfmas9Vf2NGnB2UNKcH3jv316HXFV0SX5b0vvKVFvoJEP
         b512jcGpehTn72RGkZkpWts1911wyuwBC+DRhfVeR3aK+NCqV7xIJrZFf+Sw76gM/4iI
         ynrvvpz9ObYToBAelrRIskElqAtImCxaF+3tnQexz/0VHQv4805dTtOiDteHWWOc3XOr
         YDXbla/95TBk1wxJrpnqyLtwk4P/6y00GBceqqllUXu6roP9qyCAPaueYE0tSzxCl2re
         mDyByZvvMptZFJl8B71rQDgvRonxp35do+K5d7lLrXklz1IUuRSrDJaEJerrUV5Bl23U
         5TrQ==
X-Gm-Message-State: AHYfb5jsc1aq2gaHmHjI2DI3/gdTDlSpN6NkYpjcfE2YEQ87SipGjXJd
        XqjdMXgeX5xmCRQH
X-Received: by 10.223.160.26 with SMTP id k26mr1825113wrk.121.1502918149795;
        Wed, 16 Aug 2017 14:15:49 -0700 (PDT)
Received: from ?IPv6:2001:a61:101e:8501:b1d7:7310:2c5b:d269? ([2001:a61:101e:8501:b1d7:7310:2c5b:d269])
        by smtp.googlemail.com with ESMTPSA id i7sm1845518wrb.19.2017.08.16.14.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 14:15:48 -0700 (PDT)
Subject: Re: [PATCH] fix revisions doc about quoting for ':/' notation
To:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>
References: <CAKkAvazj28RR1nHEWNNeZeyE6mpkb3opk6kvrxP6Lau6tcCbJQ@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <956ccc83-c291-4217-795c-fcef33fac35b@gmail.com>
Date:   Wed, 16 Aug 2017 23:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAKkAvazj28RR1nHEWNNeZeyE6mpkb3opk6kvrxP6Lau6tcCbJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.08.2017 um 05:21 schrieb ryenus:
> To make sure the `<text>` in `:/<text>` is seen as one search string,
> one should quote/escape `<text>` properly.
> 
> Especially, the example given in the manual `:/fix nasty bug` does not
> work because of missing quotes. The examples are now corrected, and a
> note about quoting/escaping is added as well.

Right now the documentation describes the syntax as git sees the
parameters. This is agnostic of the shell or other UI with their
different quoting rules.  For example users of fish must quote
`rev@{2}`. A GUI might require no quoting at all. In that case `:/"fix
nasty bugs"` would be given to git verbatim and hence not find the revision.

Also: Other examples like `HEAD@{5 minutes ago}` need the same quoting.

So my suggestion is to not use quoting in the examples and provide only
a hint in the text. Example:

 <rev>{caret}{/<text>}', e.g. 'HEAD^{/fix nasty bug}'::
    A suffix '{caret}' to a revision parameter, followed by a brace
    pair that contains a text led by a slash,
    is the same as the ':/fix nasty bug' syntax below except that
    it returns the youngest matching commit which is reachable from
    the '<rev>' before '{caret}'.
+   Depending on the given text the shell's word splitting rules
+   might require additional quoting.
