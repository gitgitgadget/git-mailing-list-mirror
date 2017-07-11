Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A7E20357
	for <e@80x24.org>; Tue, 11 Jul 2017 09:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbdGKJST (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 05:18:19 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35861 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdGKJSS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 05:18:18 -0400
Received: by mail-wr0-f174.google.com with SMTP id c11so174589789wrc.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xa/1bUJjH1+fpI7I6JUEVS7n4BXvmL2Zo4FQ5ZGWK4E=;
        b=h/titMVJMbIWZ5+RKJnoo6L/EXSo+gWwoLJHWVWVnYv7v/VqMq8/gGB0vTg17tbM48
         /3oGpyW2hfDjMDlbQ3K8EnGRACxzU/YreVFXxcISAZQrqhhg09i2sC/fjZ6dZrRnrJjC
         ku4SjhRtRDagn3eG/ndeeerm9J6hHeA5ncVz0AhziVnuuWPxJ4UA0AcbUeNtUQYXJi/W
         TbojToqxrRSa36kwG9Sck0FE2wI8As+ASN64ZKMrZjhPsXc5VIRfzilW6/HZ0614eVCS
         u/hJC+JOw734ZJGRXP4HHRhxAxQIfedg0Q5ijaw68x4HD6BjanRYwaoLS48driD7bELP
         LvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xa/1bUJjH1+fpI7I6JUEVS7n4BXvmL2Zo4FQ5ZGWK4E=;
        b=GJbinAnVGhvM9vWmvA0WQPxLi/3MQoCXB229e46BRnPanRzhrsZ/wkQZeVVYAYc+xc
         Hmp7b5rdt1npuZChV40jxgfmdsG8jQ27ceemfUeszyGTX70uZjDgSHs18b5o9RJb+7Fl
         VsH59ql1ObT2NDkerSW/wBSpTSaG1MHIAt8HJd9SRcutMHQDhYmFCTF/0XPtEPtg8rG4
         mlVT1u4t17CjNGbN2g9SaT77j0l6RG0vCyitwgSHtydqfJmde0m5Y967lRQau4u6lGMX
         Yf5NR8bMTkiGiNXqUvzAAsYbusbKIupCfGJ3vRbtdyP/J83puvK0sCSpuG/keo+gmk9v
         CFUw==
X-Gm-Message-State: AIVw113iAghUCGsqYa2/zd7qfPmleh6wibDldDDAP8RvQd0RO+Q5JEjx
        avH9MlRKFiY69Ieb/dk=
X-Received: by 10.28.139.204 with SMTP id n195mr1844476wmd.14.1499764697322;
        Tue, 11 Jul 2017 02:18:17 -0700 (PDT)
Received: from [10.146.248.58] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 1sm11887530wmn.32.2017.07.11.02.18.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 02:18:16 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170711091108.3qj35d4yk5el5xxa@sigill.intra.peff.net>
Date:   Tue, 11 Jul 2017 11:18:17 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A334F9D4-E884-4A8F-A0DA-C07214CF9001@gmail.com>
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com> <99EB15B6-CAA1-4C78-88B6-C934C8FBD8F8@gmail.com> <20170711091108.3qj35d4yk5el5xxa@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Jul 2017, at 11:11, Jeff King <peff@peff.net> wrote:
>=20
> On Tue, Jul 11, 2017 at 10:28:08AM +0200, Lars Schneider wrote:
>=20
>>> On 11 Jul 2017, at 00:48, Junio C Hamano <gitster@pobox.com> wrote:
>>>=20
>>> * ls/filter-process-delayed (2017-06-30) 7 commits
>>> (merged to 'next' on 2017-07-05 at a35e644082)
>>> + convert: add "status=3Ddelayed" to filter process protocol
>>> + convert: refactor capabilities negotiation
>>> + convert: move multiple file filter error handling to separate =
function
>>> + convert: put the flags field before the flag itself for consistent =
style
>>> + t0021: write "OUT <size>" only on success
>>> + t0021: make debug log file name configurable
>>> + t0021: keep filter log files on comparison
>>>=20
>>> The filter-process interface learned to allow a process with long
>>> latency give a "delayed" response.
>>>=20
>>> Will merge to 'master'.
>>=20
>> Hi Junio,
>>=20
>> can you already tell if this topic has still a chance to be part of =
2.14?
>=20
> I'm not Junio, but we should be able to reason it out. :)
>=20
> It's marked as "will merge to master", which typically means it will
> happen during the next integration cycle (i.e., within a few days when
> the next "What's cooking" is written).
>=20
> Since 2.14 will be cut from the tip of master in a few weeks, once =
it's
> merged it will definitely be in 2.14 (barring a revert, of course).
>=20
> This holds true during release freeze, too. Anything that makes it to
> master is part of the release. The stopping point there is that things
> stop getting marked as "will merge to master".

Thanks for the explanation! I looked at the Git release calendar [1] and
realized that 2.14-rc0 is scheduled for this Thursday. My assumption was
that either on this date 2.14 will be cut from the tip of master or =
master
would not change significantly after the rc0 date until the 2.14 =
release.

- Lars


[1] http://tinyurl.com/gitCal

