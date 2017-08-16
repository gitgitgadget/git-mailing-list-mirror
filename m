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
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C4D1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 12:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbdHPMLx (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 08:11:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34454 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdHPMLv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:11:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id x43so2725219wrb.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jJoQ87iv0tA5AZ/1q22IVwI7mLIzvbj/rluYm8YxI6Q=;
        b=h+JyIfAEYwS3eYrKwn/HZC4GSbYIwqe3PSOc+JB1HQcj33fuJsTvdU3gFrP3G49YMR
         IoWmTqlLKO4fpXN6xedgJ6DVgUDMAu0qxWFJsgriFM6pTnPfHQnRHccs/G0hexu5ESqy
         D1CEnUTe0G2ENP/gHRfmK2jWXrOE6mkXqsR71lGq5qwS12TjqlJ3Lof/ULZlHEHYFWdP
         7t3L2vXeHqidnKyXZPtlQ946Geq77AXR57cZfqG/oTSZVYyPLADH3djOd0lEqAd1iWkq
         RuNDGuDxg0kyyHnw/h3VWE2xLmr9x0mVewfuNneo3AY9vvMvEiinCcQxhx7sYy8hYoap
         e2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jJoQ87iv0tA5AZ/1q22IVwI7mLIzvbj/rluYm8YxI6Q=;
        b=RwP10y4spnq6d7k2OJMXX+EZJsRCVm9aFVGOCgvFn62rBHzy4kBoapL/CWHUm3k4HH
         0H7K5eokwK6RHBNLFxzovT1dnYdXjTNu1EYaKMfTU3mlH4ew8siFxz7seqMc6FdcF7To
         07X7RuS3oMp4xJv18E1acG37cV8pAcNh4dOyzgVhSC5wxwbmA7nFMY02ntDBMKWEsBEy
         fH5gLYvj9KK6HjNpBV3z9dStTWVFPW+1aDwGe3AH/hkjZNEVzNCDr+Q8w56cTQ6vXwVS
         AVHOXt2lkBfyIe5Wc3r2j3oTq3CAubMKaL/PY4h7IdWJxtyx3f2HTLl2+VPPG7QuZUQN
         BvAg==
X-Gm-Message-State: AHYfb5jxyd/9CQumHeDej2N4rUU91eCjHsy8WzUFM1C1l3U7tHDTGJGT
        sbZAW152ia3ijnGqdtZ4dKoidL+0cg==
X-Received: by 10.223.174.232 with SMTP id y95mr1213068wrc.56.1502885510330;
 Wed, 16 Aug 2017 05:11:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Wed, 16 Aug 2017 05:11:19 -0700 (PDT)
In-Reply-To: <xmqqbmngr6wq.fsf@gitster.mtv.corp.google.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <a21088f049390828cdee957f88503e8466e1d34e.1502796628.git.patryk.obara@gmail.com>
 <xmqq1socsnay.fsf@gitster.mtv.corp.google.com> <CAGZ79kaCA29j6ON4KSsB=EH8FPfZGE56hVGSAAepcPiH952v6g@mail.gmail.com>
 <xmqqbmngr6wq.fsf@gitster.mtv.corp.google.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Wed, 16 Aug 2017 14:11:19 +0200
X-Google-Sender-Auth: QD2iOXyhjw6guQKjXvvuUkrbNsw
Message-ID: <CAJfL8+R6SK3RGEGXcr5N-btKKjHCUcT95r7oOOsWgY1RXwEEtA@mail.gmail.com>
Subject: Re: [PATCH 2/5] sha1_file: fix hardcoded size in null_sha1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> I said this is OK for "null" because we assume we will use ^\0{len}$
> for any hash function we choose as the "impossible" value, and for
> that particular use pattern, we do not need such a union.  Just
> letting the caller peek at an appropriate number of bytes at the
> beginning of that NUL buffer for hash the caller wants to use is
> sufficient.

Do you think I should record this explanation as either commit message
or comment in sha1_file.c?

> MAX is inevitable only if we envision that we have to handle objects
> named using two or more hashing schemes at the same time, with the
> same binary and during the same run inside a single process.

I think this will be the case if "transition one local repository at
a time" from Jonathan Nieder's transition plan will be followed.
This plan assumes object_id translation happening e.g. during fetch
operation.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
