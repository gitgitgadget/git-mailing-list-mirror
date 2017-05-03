Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C0C207F8
	for <e@80x24.org>; Wed,  3 May 2017 11:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbdECLQ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 07:16:28 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34226 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdECLQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 07:16:26 -0400
Received: by mail-oi0-f54.google.com with SMTP id b204so17759661oii.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eIHyDmDXpQTjDfeuPpCQ64/Ia+MuXUMh/+CqTBViluU=;
        b=VJK0HA5G5WqQS9LqfucgI3xJr6vMHYu6ogiOpM0reSNu+hni00FwhXMi9FVJd1csO9
         Qv55WKh1OpboED0T0A1rMhFpsZRXUam/Q4QoF6uPu25zEVB261sxsYGkUEJ/gHWKcZHJ
         sTGWTGNkMSLAGVzwKAvxuFvuAhiQwODhUR8WuAJwJcCwXUwVdJoW2MbaUPrkN12TXzrV
         UXv5SRvxN0VhEEO91OrRQaUq5ZZ9QKIFgz8WywIaq7QhlB0kPGuKYwM3PzTdFzEFNRgY
         ciT4Ru+r/Zus3jJjYfN2Sq8uepGowKznA+3h9J+XiXuq9bw3Fp2SeFLMn52jzHzVQC4t
         JGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eIHyDmDXpQTjDfeuPpCQ64/Ia+MuXUMh/+CqTBViluU=;
        b=c+X10IoLlSDTidhegdZDJEpeN112wsNZvEelm7hIe8v8XI2ruRmp/zPKKg+KTJDGM8
         8zAfLN5t0d7yUXg7AMu2bfV7Ku2cQ68aZynFVOoud75QcPhfkophG3QgE8cxZ/cEIXMw
         CmuGrF/Lh9ZqsThWQIv+AdbTM8j8fkP2nwzyhlVvfuTsTXTf9Xy97uY95T7rPoRKp5o1
         m5doteW+G+VSJaL+qX0Mkw/91kuvMgU9DakdUfmHyeyMcVFz3ynGMlDr/umq8O4WYfPO
         mSofStihP9KeF6bfboQYhIvYe0BoxOBp6RKmnzsOm+qD4Ny7MJrW+K7jB7YATn6yUTgY
         6oGw==
X-Gm-Message-State: AN3rC/7MCwKWTqbrYm350wK2er0oeMlW9d7A7VXuWhYkeR5VOLmc85Al
        S3a1Y+4FYMROck+CSZna57+McEyqGg==
X-Received: by 10.202.82.205 with SMTP id g196mr7177320oib.153.1493810186155;
 Wed, 03 May 2017 04:16:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.140 with HTTP; Wed, 3 May 2017 04:15:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1705031139090.3480@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
 <alpine.DEB.2.20.1705021756530.3480@virtualbox> <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 3 May 2017 18:15:55 +0700
Message-ID: <CACsJy8C1vaNFint17-ASy=RQnQswEJf-goQ-wiRCFdkeh+punw@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 4:45 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>>     So it makes sense to give our downstream distributors a nudge to
>>     switch over to it.

Some contributor (i.e. me) was not happy with this nudging though. The
other day I switched to some branch (probably 'pu') and the build
failed because, guess what, I didn't have pcre2 installed. If I set
USE_LIBPCRE1 then I lose pcre support when switching to other
branches. And no, I don't want to install libpcre2, not when I'm
forced to this way.

188 packages on Gentoo optionally depend on libpcre, 6 packages on
libpcre2. Chances that a Gentoo user has libpcre2 already are rather
low. I'll revisit my installation when the level of libpcre2 support
grows a bit more than that. You can nudge distributors directly,
probably more efficient too.

> ...
>
> I hate to be that someone, but it has to be said: this is a disruptive
> change, and it would be a lot better to make it an opt-in at first, and
> when the dust settled about this option and many distributions have opted
> in already because of the benefits and tested this thoroughly in practice,

Agreed.
-- 
Duy
