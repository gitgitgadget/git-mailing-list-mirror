Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DBD8208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeHGNH3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 09:07:29 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:38272 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeHGNH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 09:07:29 -0400
Received: by mail-oi0-f46.google.com with SMTP id v8-v6so27616219oie.5
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZiT/XHJ2QuTqecxVVZOWp+NNJ2lRnyTwU7Xkz2+7EzA=;
        b=sxivDOQPg6eL8Rx2gRxaJ18zonTeUdIWto5n/4PT+hFnnRf/Am3P+KK+ZCyBTw7VVe
         s6kH1kb0EPT6/dqm3iUkDWoBti/xCJHYkoDSHVMwVz1uZorxxNRfAYoIZoBesQm55EOk
         jgU/Kw++QO57050zW1VNd0D/uZdo517eNd+eYwpIVLsaqf1PNnAPSOyqx+8v55H6OFHY
         gw/iH7MIDOOa9+0WCOPsTAuDr2FLivTp2QQXmmdWHWP8pnCv5/waoW65W7cLojQtmtmX
         ypEeFMkMQ33nDJJZRAlrzujK/8ZGq2Z7MnAhzpu3kroYAzP+Xbr5RORxMfZd+gQRiqT0
         Qcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZiT/XHJ2QuTqecxVVZOWp+NNJ2lRnyTwU7Xkz2+7EzA=;
        b=lOM2RQCvqEGlRMpBXY4QGRc3mV/47QaKgXozDm03xOWparuG2ELN7NE4TawT+qqmVA
         L826866/rhdtBQEqVCdTDfLUI0TFQRVknDiHQ8J/GtoguBAPXWiZ1V1pEo2Yv0n3QwYT
         kSWPztqSd9Jnb/qKRivNi5aK3h7+nuDyMZgLRyRxuIOHn5tEl3Sf0hhQRD7Kx4SL/fDi
         qTw4GJ1llgDUh8U4fXUKFTtoPltxi6uFvk9UcdhTOskxmom/w2I08i/Mh3U2d96qPnE2
         G0DE55IphJr9NwJrWF50bumLKToFhg0JED+xH36LXzdXPcWFovm1i3KU4sj9fx7lR+5i
         9fDw==
X-Gm-Message-State: AOUpUlFvx82t5UpFxM2sNwQdI4Fplh1uJXG901JLQd7S3hDpS6gAAw4s
        KzoMH23x6UlZIH2p+NpozcJJILobz4FKvSF1Jac=
X-Google-Smtp-Source: AAOMgpcQD51x8S3HpiEnTOAhkoaddTNczFs+Q1KeT0jApeU7SLKLZLz4SDadSSHGIduf7kaycXD5TO7bx33ctAKoq7E=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr16900114oia.154.1533639224627;
 Tue, 07 Aug 2018 03:53:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:12f6:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 03:53:44 -0700 (PDT)
In-Reply-To: <a50da318-1f15-3dc8-53e0-c40365a053f7@gmail.com>
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
 <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com> <bea0e5d0-d944-ddd8-c3ab-a95355352b47@gmail.com>
 <CACRoPnTWxYvGfqgGt2r5ETOhfJZnqr1fTO9Fzwp-u25XbMGPPQ@mail.gmail.com> <a50da318-1f15-3dc8-53e0-c40365a053f7@gmail.com>
From:   Paul Tan <pyokagan@gmail.com>
Date:   Tue, 7 Aug 2018 18:53:44 +0800
Message-ID: <CACRoPnSJm4bwRs-k5kkz4VDMCQ_r00JhQxpXUTrFUvRVODMWHg@mail.gmail.com>
Subject: Re: [PATCH v2] t4150: fix broken test for am --scissors
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 1:42 AM, Andrei Rybak <rybak.a.v@gmail.com> wrote:
> On 2018-08-06 10:58, Paul Tan wrote:
>>> +       git commit -F msg-without-scissors-line &&
>>> +       git tag scissors-used &&
>>
>> Nit: I'm not quite sure about naming the tag "scissors-used" though,
>> since this commit was not created from the output of "git am
>> --scissors". Maybe it should be named `commit-without-scissors-line`
>> or something?
>>
>>> +       git commit -F msg-with-scissors-line &&
>>> +       git tag scissors-not-used &&
>>
>> Nit: Likewise, perhaps this tag could be named `commit-with-scissors-line`?
>
> How about "expected-for-scissors" and "expected-for-no-scissors"?

Yep that's fine.

Thanks,
Paul
