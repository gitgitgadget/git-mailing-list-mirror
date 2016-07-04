Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39E1620179
	for <e@80x24.org>; Mon,  4 Jul 2016 15:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbcGDPxX (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 11:53:23 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33912 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcGDPxW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2016 11:53:22 -0400
Received: by mail-io0-f173.google.com with SMTP id g13so153960764ioj.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 08:53:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/A2Qx0uq2vFXfjfmW0L+Khk0cgr/tvXLWa/v9k2HYHA=;
        b=Yc5HufjoiQ8ynUZH2XpuXheoHKF7Co0draub6eXAxxSpWVb5IsN9xoE6bxV8TS2VLS
         vQ/O5giaVxSEesC/71KZhwOGofBUDwMqSIft9lIaU8fdSxVG9dZe2vLTgDk/7arE6RP9
         EJrfRenY4lNaxOZR7AknD4nAKP/SMAlthvrhP2FnfvncRu4ZU3EqUw+SqOeuUx88gvL2
         SpUZdpElNUUDCPu26WP2cMiqgDf0B3o2/dQvhy6y7V1oCm8ldsQBpxpsLixAfz5lzyhc
         nfFKMsuawoRFZa1M/WDbVaRflXEgifjBkfMWlMM6eQunwQ2Inx0MtAvw27S0IPDZ3SsI
         jjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/A2Qx0uq2vFXfjfmW0L+Khk0cgr/tvXLWa/v9k2HYHA=;
        b=i+16u2PWLLmJYGLAhgYft3qK6ixit1PytQnXriQsQCbnRj6pi9oysV0xBlxMpxW2D9
         pnFcPLiNkRE4qSanCcVkJWJ8LGILPbnOiIBzN7ac2TngBuFMS8UtTuKe4poDEzZn98ay
         rFM/YiCb+jtBmYylp7swCWY/fouRVRqqF+bBppz3Ub9K356kWYanByc3yrQbkOcKSgCn
         ArskyCI4WMsnMRTl0B5ZLorVG8uBh2E0e4xtZrOJ5TpxFdNbxnO+Brb/sVbWNvOLpiLx
         jreZK151HAjPYHbIjmJKkUCzazeD/gfuvhw8or5zhiI0ojVDbuFh9GCsgUxZVWkaXQ0h
         XwyA==
X-Gm-Message-State: ALyK8tJ8ApWB/G/iK2Wl1qVt4k3SaD7xcIFt1FFhjTxWVDAnbDVIe2dFAqBodiB+RbvX3DYawFF96WG/fPP7fw==
X-Received: by 10.107.159.16 with SMTP id i16mr8802695ioe.29.1467647581612;
 Mon, 04 Jul 2016 08:53:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 4 Jul 2016 08:52:32 -0700 (PDT)
In-Reply-To: <577A7FFB.6050507@gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com> <20160626055810.26960-1-pclouds@gmail.com>
 <20160626055810.26960-2-pclouds@gmail.com> <577A6DBB.2030902@gmail.com>
 <CACsJy8CoSwM9W-HX2X9rA9NbJBVQ8BzySJjp3XjXBK+5r1tXZg@mail.gmail.com> <577A7FFB.6050507@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 4 Jul 2016 17:52:32 +0200
Message-ID: <CACsJy8Crt8d5QdwPP+-ATaseR=gGLb7ri0jOozR==_U0Z1u4YA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] git-fetch.txt: document fetch output
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 4, 2016 at 5:25 PM, Jakub Narębski <jnareb@gmail.com> wrote:
> W dniu 2016-07-04 o 17:17, Duy Nguyen pisze:
>> On Mon, Jul 4, 2016 at 4:07 PM, Jakub Narębski <jnareb@gmail.com> wrote:
>>> W dniu 2016-06-26 o 07:58, Nguyễn Thái Ngọc Duy pisze:
>>>> +summary::
>>>> +     For a successfully fetched ref, the summary shows the old and new
>>>> +     values of the ref in a form suitable for using as an argument to
>>>> +     `git log` (this is `<old>..<new>` in most cases, and
>>>> +     `<old>...<new>` for forced non-fast-forward updates).
>>>
>>> It would be nice to have documented here also other <summary> formats,
>>> like "[new branch]", and/or mention that if the <summary> is not usable
>>> for `git log` it is put in brackets [].
>>
>> Can I do it in a separate topic in future? We may want to unify this
>> and the output format in git-pull as well, then include fetch format
>> in git-pull.
>
> Yes, of course it can be added later.  Though it feels strange for docs
> to talk about <old>..<new> and <old>...<new> format only (note that it
> is also suitable for copy'n'paste to `git diff`, not only for `git log`)
> while having "[new branch]" in examples / later patches.

It's because it's copied from git-push.txt and not all
[<explaination>] are listed there either :) But I think you have
convinced me I should do it now.
-- 
Duy
