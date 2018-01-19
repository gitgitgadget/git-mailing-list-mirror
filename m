Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA3F1FAE2
	for <e@80x24.org>; Fri, 19 Jan 2018 00:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbeASAaf (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:30:35 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41843 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbeASAad (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:30:33 -0500
Received: by mail-ot0-f194.google.com with SMTP id 44so27906otk.8
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QwIh7vnf63YdB1WVmTS253jxccSkFD+RHHkU+OqycyI=;
        b=AJTzsj0jMZ4Q4RqurIngYbNmPWe1r7dWzsMybszs9TvQ01e2P+oqTp1wPvIyO2/8AU
         oUiksr21zmKId3jbZRxj56LZeCOz5qn8Um4vuGIdj8sSu3yZf/eC6nKIWgAoqVxdhHA0
         qHhfzNW01f48IhG4E2LxOKp3v8Dfy+flEayag2m3XklpYYCH9p/QypbLcBwHGTM+EsTR
         kqf+Ecw6GJCmzvxXvbXSiiFGv6O/pZWLnWLDRLjwlWgMeHdLoibBXsdl8X5PpLRYJDsT
         re4xiPfg+TK6aHMGFJxKTBZfYcvnHhtX7t8CB8AvMNb8oyBhb9eqPHmhq12A/nmOWdM2
         sP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QwIh7vnf63YdB1WVmTS253jxccSkFD+RHHkU+OqycyI=;
        b=s0qRliaQOIVY6xUd9k/O+hVvAxVxGuYK/QcWx4y3PlQi0ddpX/KKeUabxy7vP660Ec
         vdDm7YLSS+b4I+pRmb2u+PXqkXo2mi77RsOfonm2C0cwa5rkM6iGrbub45otc9zNC5Uh
         3Xw+eCs4hwj8FHw3VZbnqyjNXo/+l5CqZkxlz3ajeCQGtQ7erc6SNMrOuojMcvP7szlk
         Rjs17GzZxiFP1OU8xGF8xMBHW7ziJxzq9np1raxKN65ms1nXU+h2y9o2fQtCDRpyOE8k
         dcAmzgmSnaQXphO78U5kp1TcIt9kQNpFH9nKxvAuErYlytq/LOKw78xqAmmlqiSw8B8a
         Na/A==
X-Gm-Message-State: AKwxytdluuGNgJmxAmBQSaT7JLxWmPhkt6hfdy9Tkim5zrv+YRa0l0iK
        WKHlX9oQQ+QoB916FrI6Igo53qhOcFJtXSOIWjI=
X-Google-Smtp-Source: ACJfBovh08cess87HoheQPGdL2dvixOqetWPQ6PCFer5m0uF9+WjpSSQsHE5JVPw0Igj/oVnAz1e2c0pntJGC1tp4Ec=
X-Received: by 10.157.87.133 with SMTP id q5mr5065166oth.106.1516321833258;
 Thu, 18 Jan 2018 16:30:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Thu, 18 Jan 2018 16:30:02 -0800 (PST)
In-Reply-To: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
 <20180114101820.4273-1-pclouds@gmail.com> <20180114101820.4273-3-pclouds@gmail.com>
 <CAM0VKjmGo5gjUBpTQp9M+pvZzBMDAmYYCu-5VfG-8LYRxU7i0Q@mail.gmail.com>
 <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
 <20180118132931.GA21914@sigill.intra.peff.net> <CACsJy8BkJXeaG3mYNEsfVK4N_-WxwU2Pk2pa1FThH1sMEW2yxA@mail.gmail.com>
 <20180118150014.GA2097@ash> <20180118213732.GA7403@sigill.intra.peff.net> <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Jan 2018 07:30:02 +0700
Message-ID: <CACsJy8AgwKY8xXYp3w39EfoGgoWjN3oNiBju4fV2du4PWaWsHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write
 shared index
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 5:32 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Thu, Jan 18, 2018 at 10:37 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, Jan 18, 2018 at 10:00:14PM +0700, Duy Nguyen wrote:
>>
>>> The test suite was run as root, no wonder why my removing write access
>>> has no effect. I got the test to pass with this, but then it fails
>>> with
>>>
>>>     Can't write .prove (Permission denied) at /usr/share/perl/5.22/App/=
Prove.pm line 542.
>>>
>>> Some more chown'ing or chmod'ing is required....
>
> This is the fallout of running the tests as root in the past.  With your
> patch 'prove' is run as a non-root user, but the prove state is loaded
> from Travis CI's cache, where it has been written as root the last time
> around, so now we don't have permissions to (over)write it.
>
> I have patches in the works to address this as well.

Great. I'll leave it to you then. I will update the test with SANITY
(and a small fix in the test name) and think more about the "-i" Jeff
mentioned.
--=20
Duy
