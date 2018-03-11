Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D371F404
	for <e@80x24.org>; Sun, 11 Mar 2018 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeCKACs (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 19:02:48 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44992 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeCKACr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 19:02:47 -0500
Received: by mail-wr0-f193.google.com with SMTP id v65so12253208wrc.11
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 16:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KqKvqqSMeEdkQWbQlzZ/iOwoAM3ME970Q/XG1P0KZ/I=;
        b=p0BN3+cJ4Jc+AVOc3Km0b4EmJwPsTsJp7PSSRb6Qj6D+ph+QER1cK4KUafmctuWMJT
         bmOohlVrBEYrvLc89rbK9kw5D6KamCFC9Qx7mYVECVlw/YFTPbqTtJ8F6OAiWHPTSQSy
         b0G3gTS1BZUmxE+ggd2vgnKhimcf6fNkguZya5bFBOi0fZMgvODidC2wXcSUF2DIF6YL
         45J7pxmWwL8n29n7l1vuPKVnBSasyJEQ5Vc4rN6hMS7G9Gy8XOCH5A+s9awHL/Neg+Cg
         wqxrg7KJ7UjPle7DRyni9voKyH1SeS958L1IlPWezuMmsKeFA6Z83of2LwGrmBUSq90j
         LrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KqKvqqSMeEdkQWbQlzZ/iOwoAM3ME970Q/XG1P0KZ/I=;
        b=G3pnpXUfhpHbm8PYRGtfTAcRbRW2SDdGbXhQ5C1U14Z47eMJ/7k99mV3pVqgxT5UaB
         yCe3Dex4P/pYKZqPvLljZ7UhjFJl4Q2jpCSkzU+bJwVSV3cmj7b0yDl3bPocxPTXiSyA
         zbyPvEoOaaLKGKAUiCTw4C57HmEbPEyL1M6//BSL0hVBmd1lMyeEWknabcz1Zetw5Qm/
         WmET/417yXtLw1Zn1EpxcRGyVF9Q7mzJPRW+ITayA9TSimx+WOtJ6mCeMp7x5FuPABrz
         pXUYEsJx6/UTP7NBP/YgpX/XhIQL4kIn/4/deXIQjnu+ctfn77TQX3JlPi2twDdVnPjs
         JCRg==
X-Gm-Message-State: AElRT7EYFPEzzScKfhiDCO/6AWtgnBPaRfVAgKWEuI9PsBppVGxCAv3B
        Q9YXblMAUASSutldFmyQtExy9GyZ
X-Google-Smtp-Source: AG47ELvMHtE6mr3pufP7fKmuExMD5KZhwQPuDlpO8TF+n+1+4aD8E6wLBAtYOH6Iy24ozq+waTnt/Q==
X-Received: by 10.223.133.182 with SMTP id 51mr2338581wrt.226.1520726565771;
        Sat, 10 Mar 2018 16:02:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v8sm1820767wmh.9.2018.03.10.16.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Mar 2018 16:02:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jonathantanmy@google.com, bmwill@google.com,
        stolee@gmail.com, sbeller@google.com, peff@peff.net,
        johannes.schindelin@gmx.de
Subject: Re: Git Merge contributor summit notes
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
        <87efksqe3p.fsf@evledraar.gmail.com>
Date:   Sat, 10 Mar 2018 16:02:44 -0800
In-Reply-To: <87efksqe3p.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 10 Mar 2018 14:01:14 +0100")
Message-ID: <xmqqwoyj32e3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Sat, Mar 10 2018, Alex Vandiver jotted:
>
>> It was great to meet some of you in person!  Some notes from the
>> Contributor Summit at Git Merge are below.  Taken in haste, so
>> my apologies if there are any mis-statements.
>
> Thanks a lot for taking these notes. I've read them over and they're all
> accurate per my wetware recollection. Adding some things I remember
> about various discussions below where I think it may help to clarify
> things a bit.
>
>>  - Alex

Thanks, both, for sharing.
