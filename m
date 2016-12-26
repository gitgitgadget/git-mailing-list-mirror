Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68BE1200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbcLZKci (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:32:38 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33907 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932490AbcLZKch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:32:37 -0500
Received: by mail-lf0-f67.google.com with SMTP id d16so12711315lfb.1
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1aq9NkPcNmwhH9QCJtjTBmb5u1ifVmncmZ+Q9DD2jRQ=;
        b=pJCIy53S/LlDrBHL5jdPso9wE48umufXAAqgAV2FN/mWbvtPAcUPW0sHy/BtoCusiN
         Cgwntu54gjBgh8ozsdWSGnRmfz1IDUmuEQ39KU8OYV82p47HRCQifXaAyUVAedX6+sxg
         3sF7AO9OhgRJgAxLudjrJjexpdY/nEGeiaEGfwu2wSWDfaoMTmrm5OQQzItlOeKNFi/9
         8PdyU2oQ8AaMh1ejgngXh76OcbwJ0Cph4ravL/RtEVggaKhtvu2dWEDsQ4PViB5L3PvR
         mXswC18CxucyaZkRPY4SnOZh8BsK6K1jF9ZqHWONO2LZItVvG8cRG2SCleDVqWm0Cz45
         JX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1aq9NkPcNmwhH9QCJtjTBmb5u1ifVmncmZ+Q9DD2jRQ=;
        b=Kguj+PtQ8sE6VboViKGVsONFHIQpQYPOGT49xQKK/jJF5g5xzZ6c717IAwDyUqi0Oi
         5aiD2g4ot1ITBtWXVNFWqThfzh3iFD2MZIG4mnc/z2D5vmZPlsBc594KXTdkOHEHx9oM
         EcC1kLEDhX/eWafv/YpfSBhBfUG+erGa4P85LtMauXk5QOyFeV4LTlPUhasMf7Q4kTcz
         LsmQ9qUNbcGimA1mp0xONdsVgmxQlKzhdnzhplSQN4eGRLtiMHXiTcjmmqQAiKsPbbR7
         jlR06xvTpBymQqMJXl6Z+behBwFYLG+tJy9X1SqNJv1es19GPyQMf8LfApqevM2RsGHk
         m+tg==
X-Gm-Message-State: AIkVDXL8UvCJw/X+Cm0ZedChq3U4OomN1aioMQT/ozS+zgm1z8++ClNhnwrTcCa6jVkD8ire56lrEwLkJcqmhA==
X-Received: by 10.25.199.198 with SMTP id x189mr9710497lff.164.1482748355960;
 Mon, 26 Dec 2016 02:32:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.152.13 with HTTP; Mon, 26 Dec 2016 02:32:35 -0800 (PST)
In-Reply-To: <20161219120246.GE24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org> <20161219120246.GE24125@ash>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Dec 2016 11:32:35 +0100
Message-ID: <CAP8UFD0DSB2o24EX4GSY38M1cfWB3b6ZkeniVdVP4y+t=xZUcA@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Add configuration options for split-index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 1:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Dec 17, 2016 at 03:55:26PM +0100, Christian Couder wrote:
>> Goal
>> ~~~~
>>
>> We want to make it possible to use the split-index feature
>> automatically by just setting a new "core.splitIndex" configuration
>> variable to true.
>>
>> This can be valuable as split-index can help significantly speed up
>> `git rebase` especially along with the work to libify `git apply`
>> that has been merged to master
>> (see https://github.com/git/git/commit/81358dc238372793b1590efa149cc1581d1fbd98)
>> and is now in v2.11.
>
> I've read through the series (*) and I think it looks good, just a few
> minor comments here and there.

Thanks for your review.

I think I addressed all the minor points left in the v3 and the emails
I just sent.

> (*) guiltily admit that I only skimmed through tests, not giving them
>     as much attention as I should have
