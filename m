Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B51C20357
	for <e@80x24.org>; Sat, 15 Jul 2017 04:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdGOEJf (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 00:09:35 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32788 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdGOEJe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 00:09:34 -0400
Received: by mail-qk0-f173.google.com with SMTP id a66so75511032qkb.0;
        Fri, 14 Jul 2017 21:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gU52zYaUV3h71DuBS00huvSfBGnIahkTNbn4fvz592Q=;
        b=C8jY+Z4eVOINpllaQOn0p6YtHRC3VRN75sv2dTbgFSKB8kT6NSnayenw36M+GN3j9X
         1l/JaSaUKXD+PWTh1xe/o4frgB/EaNSEvHdAB9z5N63Za5YKrNwE9Yd9FmVXQO7yOQU5
         1Ad/89e0+q72uikgSoovjgitojA11cEWdDs+U3Z/qTEcwjiuQBPs4O2S6m7tKqH8+aBB
         zPIHc8Q7SnjlgTUktFqJhgG8PFxg8cb3jm+xBCUUoQ8eZGMop1abl7Krv6EXkGLArVlg
         cWbsh29MvSYoPgijtzCkdt73crPC2nS4f25Bnttw/KbfoVuwHQ9CleiP7Ou64rqYNgoZ
         y8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gU52zYaUV3h71DuBS00huvSfBGnIahkTNbn4fvz592Q=;
        b=VadPb1WlpqXzwwworzLJuHZ0m5dp7bbyhVJmkMvEPZ2bHfEE8nvYYd+cazGviKQBDi
         NxlCPOyUzu9Giz8EpGQfQ+m7zLgqcaaB5EZcgza+nyr1FK2/wv11MU9YEHYeO2piP2mU
         8KdOqsbMJ3Aqv8XclH9wzVBj4gYGaE45efn6fYJZVq/KLTMKD16sIOST9+lC1Tqko2Xd
         fiYvTQO1qvIJ2AzF+vg143wD2D+lUjBjCF6qvVEZGQUmhq1o2IgmSfbILc+ruiBbK16a
         NB65Bh94mE+ptLWgp5N7EcPyI4XCNzZ+s7fMSDgl39IO+HZvDYw+AUpxBjEZgzATrVtA
         BOVQ==
X-Gm-Message-State: AIVw110yXgY+0cV7hv7Q0yH7XkD2kgbGYJxeq6YY+XhDzIzyjEYaQFFx
        0guXnntUEULgso1FlilsL9b9jJsvxg==
X-Received: by 10.55.203.17 with SMTP id d17mr14518279qkj.147.1500091773559;
 Fri, 14 Jul 2017 21:09:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Fri, 14 Jul 2017 21:09:32 -0700 (PDT)
In-Reply-To: <87mv8638y5.fsf@gmail.com>
References: <xmqqzic7sy2g.fsf@gitster.mtv.corp.google.com> <87mv8638y5.fsf@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 15 Jul 2017 06:09:32 +0200
Message-ID: <CAP8UFD3Xe=bxWhQdm_Jh0yfB=Cv3UUNxmO6ji5akaa4PH_KurQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.14.0-rc0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 15, 2017 at 1:17 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jul 13 2017, Junio C. Hamano jotted:

>>  * "git send-email" learned to overcome some SMTP server limitation
>>    that does not allow many pieces of e-mails to be sent over a single
>>    session.
>
> Makes it sound like it does that automatically, also "pieces of e-mails"
> and "sent over" is odd, maybe:
>
> * "git send-email" now has --batch-size and --relogin-delay options
>    which can be used to overcome limitations on SMTP servers that have
>    limits on how many of e-mails can be sent in a single session.

Maybe s/that have limits on how/that restrict how/
