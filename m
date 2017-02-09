Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C16F1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbdBIV55 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:57:57 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:32835 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbdBIV5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:57:16 -0500
Received: by mail-io0-f170.google.com with SMTP id v96so33872540ioi.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4xQVdWY6Jal0VX7eBn/0ZNnUNPVbCDlGSsAFIlbPzoE=;
        b=DfYiaqYJmXmYh3haHmtuSKiNWtUr3qE4MCXWS6QDJ5mCyxsrWcXjpxQ2ymajtdJjC0
         DO3CCTb4ZqlN97FStaL83TQCBB4V5rjlshNsat+L7kotfP0gt4izRFHUKCf3WJ43mvS8
         9D10RQ8g4747QbAGPEsWc2lKHnpXAVRDhvSkdLcJ6Ksg8OEojPT9hAylXVS12Owz+nNX
         jFXj9BQRWh1Ps0n2NExCKYt60X1adDIKbMtfEnTk2scURTm1caE5MSHgkjrWB+DAB1YZ
         XJ3EPgbY/338B17tNxezGcscBO7BzZn3A90uqnA5WwAfvZmHnwJE1W0R/I9CAr53+f0I
         mkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4xQVdWY6Jal0VX7eBn/0ZNnUNPVbCDlGSsAFIlbPzoE=;
        b=eJrlNndnXc99zbM74G+wWhkoDvLkmiX9XleYX92lv4Tgzqm5/lb/M0Ncjl0XCSX3i0
         j/JDDdXZqsZc3MGlqKzbFLtVoq/kdOxvTTejIbwH840pLg4DPt3aHK3TrVaFtNECy4lO
         SKD8pYpSwf/12P/5xixU0mHQvOIQWosB6FYVPHWCXouiE2/Aqi5jeId/6nvv7yUYhDbZ
         PhGHn4vqcsJ9hF9exAiTGwuwGtSpG/qEBKeIX0BNSK5VHvq7QN9cfdDKyMje28U79jq+
         hUi+j0/EFtN1IZG+CkQCzNO/UE2MXQDDJzXtYiZTJeDv+yG3BmbkqljaaQ2L4fZBhkoV
         HunA==
X-Gm-Message-State: AIkVDXI4vbRDyqLCnUg61ybYhedkBGzzxsLck4K2DIPpfSBmkq2zU5jRiq3dd6K9LxDqgqj+Ir89Rlm5NaUdHw3Q
X-Received: by 10.36.65.4 with SMTP id x4mr24654588ita.69.1486676858811; Thu,
 09 Feb 2017 13:47:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 9 Feb 2017 13:47:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1702092236500.3496@virtualbox>
References: <vpq1svtstud.fsf@anie.imag.fr> <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
 <vpq37fowx5q.fsf@anie.imag.fr> <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
 <alpine.DEB.2.20.1702092236500.3496@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Feb 2017 13:47:38 -0800
Message-ID: <CAGZ79kZXq0oaxLRB+KWrmTpq+zKASJgoCY7Ox-D15zhX1RLRoQ@mail.gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 1:38 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Christian,
>
> On Thu, 9 Feb 2017, Christian Couder wrote:
>
>> I just had a look and the microproject and idea pages for this year are
>> ok.  They are not great sure, but not much worse than the previous
>> years.  What should probably be done is to remove project ideas where is
>> no "possible mentor" listed.
>>
>> But I am reluctant to do that as I don't know what Dscho would be ok to
>> mentor.
>
> I am okay to mentor (except anything that touches submodules).

I am okay to mentor anything (preferrably submodules).

Thanks,
Stefan

>
> Ciao,
> Johannes
