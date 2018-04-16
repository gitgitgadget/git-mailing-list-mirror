Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EA1F1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 18:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeDPSXo (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 14:23:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45870 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeDPSXn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 14:23:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id u11so28637845wri.12
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N8etomfOXg5OfQMEIzR8KUQneK2Octsu/NNfkLfdp6I=;
        b=NvWkQVmsOUoOr+bSJbrmVLgenLgLYK+H80pqLrEPZitNgpcvvXpbJUg2QqNgoWgD51
         nbse0utzrVdIWcuscvqZM8RvJrMD2PIo0/OYoAzMBtfT0mTFiB4AFy0rVJXlwasfQqQY
         XhhH7UUrU6lXHbdGsL4H3F4bu3vF72LJV6G62xW0WnfjQsEnnzUPQRoyyCSX1Gx5LmLB
         jA6vhNGDR6DC8C1qVynovfeHfEh7MjJnqddBT+McZ+6jAI8vSHAoUsr3+AL6jcfsMi6P
         eNqOXsaoryLTp8do4VNpb77WLpYRMnwaHJqb8CGSwn/svOoxweMDsYr7ihc66+HNxtoX
         n47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N8etomfOXg5OfQMEIzR8KUQneK2Octsu/NNfkLfdp6I=;
        b=O2aAkRQDYO1WZu7j809itgWAvJAetKyZx3JnfAqyjKvg+X6MuSQ3UjQ1gbHYo2I6JB
         ObHfM+c7/MB/ghtFbUgSpER4145SEHjz6ukTreufAiI1r+eyJz3WuoikLqiXxPGaS9B6
         pZLa2KrMFB5GX65Y9nA0r2Ev6OslGmf4Rxmb2bcNq2cHwTgW6RtKqlDMStD1oYrXR2Ak
         jmnJ01VSJ0Qhkzt9kpWYPKZCzN68JF1Ro46yl77JEeJBW7B62d9/4CHMwF7pRKeZpgan
         C7zwsmhiuWoZt1smNovUjZTih7B/wXYhnVv+4b3VBoobuMjhiquChNoQj/fEiLIdLgoA
         QErA==
X-Gm-Message-State: ALQs6tDj6cQTyR9g2VyWw12xv4RXJxpvQqTk/TmFAdnlGGysNBnHds+A
        rkVCewr7QUfqw15e3NriIyZ6oIwr1s6R0wQHMC8I0Sr+
X-Google-Smtp-Source: AIpwx4++EgBbYf8huHZ5tN1+6og0cm2gS3g5Ps0it+gPT6wz+AHTbxHaw2D4j0o5VeBxOnt/ZhmjwZk7uCToICOIARg=
X-Received: by 10.80.192.145 with SMTP id k17mr17893290edf.303.1523903022522;
 Mon, 16 Apr 2018 11:23:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Mon, 16 Apr 2018 11:23:21 -0700 (PDT)
In-Reply-To: <86sh7xlxyp.fsf@gmail.com>
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
 <20180413103005.671-1-szeder.dev@gmail.com> <86604un5mz.fsf@gmail.com>
 <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com> <86sh7xlxyp.fsf@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 16 Apr 2018 11:23:21 -0700
Message-ID: <CA+P7+xqVdhJ3PrGjQWcofHJV3E1UYWVHEXVt5yaV3Ycv1YvkTg@mail.gmail.com>
Subject: Re: [PATCH] completion: reduce overhead of clearing cached --options
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 14, 2018 at 6:27 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>> On Fri, Apr 13, 2018 at 11:44 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>>>
>>>> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
>>>> builtin command, which lists the same variables, but without a
>>>> pipeline and 'sed' it can do so with lower overhead.
>>>
>>> What about ZSH?
>>
>> Nothing, ZSH is unaffected by this patch.
>
> All right, so for ZSH we would need LC_ALL=3DC trick, or come with some
> equivalent of 'compgen -v __gitcomp_builtin_' for this shell.
>
> Good patch, though it does not solve whole of the problem.
>
> Best,
> --
> Jakub Nar=C4=99bski

Is ZSH actually affected by the broken set behavior, though?

Thanks,
Jake
