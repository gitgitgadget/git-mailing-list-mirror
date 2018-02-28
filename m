Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B7CC1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 00:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeB1Aar (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:30:47 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37961 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbeB1Aaq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:30:46 -0500
Received: by mail-wm0-f48.google.com with SMTP id z9so1845149wmb.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5LiZG9FUMhLOiBnCfn9net0Ti/ElVVFhjYTM4MMMUIA=;
        b=ThlTUVXOiW8dusKIGfeGmyGLpTsHBgFHtn8F2UyjYUpg0LDhKxDKd+cPTIHzoa+Zyj
         WmOro17vqvYTEBRL88jzw9MK1jg+fITRO8PZx5VmfxImHDsoIa5z2tBMqAAQQ4S/R8GD
         amzJV0yDn4Aw+Y6w9y9dtpV23hX2xUMqaCxAuf++fOp4ztd8sMh4vI4tmTGurVx/U5P4
         ET49gSHA59dbYuxTleClHv3flGT2K2g9JllL/GQXb6jfaz5icqYYpqdumCk37vs2geXb
         C6/zAe0xihj+kqo+sBYft2d3GxIuieyjCH0oWZ2klpprUXZJGnwMPLx9peC4WmRGF+oj
         5KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5LiZG9FUMhLOiBnCfn9net0Ti/ElVVFhjYTM4MMMUIA=;
        b=QXLDw6no23yOasl4lPjAZKpa4n5uffe8d257IvRQyqwiEc+humzM4ANGHQckijS1Qg
         1jXSSimOOH1ISVTEvJ6fdZeoINSXDqZEEncgry6a6UAdoKtKSf6VNRXHdXjNy9BupjqQ
         SC1OhYXbZzfI5YPZdyKb4X50sCUsQHEB0lUeyGbOcWC+MbQRCY42nG+qb3VRbYrMhEQK
         /+sV2hLvUucMaXljBLuJxb1mzxgu1+MEmE4UF/aEmftQ9LY+wSJVYDY81VGGUcR/I+NI
         M1hkgsMipoQZYeZ821+dE7Dc3wfikj7PXICc5MKk5MR4CkqeMMAAm0g7tg8WC8cx/V3Y
         2OEQ==
X-Gm-Message-State: APf1xPDt3WWC3kboB9D9TOSjJEUnTkm6s2XporIlTpaLOj3IeelEWh88
        xI2UcSvWGmFNFQI6/03MrDHjcOQsoBGpDSt7apk=
X-Google-Smtp-Source: AG47ELuwxKBQxVGh5c4/KwOkLpAcJjFy5fd3Y12qAJbVVBiVTOwvZSdQVb3Y6UayC8Kmvin9ZQMhBdJh3DmJBYjsFJA=
X-Received: by 10.80.232.69 with SMTP id k5mr15079407edn.133.1519777845384;
 Tue, 27 Feb 2018 16:30:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Tue, 27 Feb 2018 16:30:24 -0800 (PST)
In-Reply-To: <xmqqbmgaqp02.fsf@gitster-ct.c.googlers.com>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87zi3u4pd0.fsf@javad.com> <xmqqbmgaqp02.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 27 Feb 2018 16:30:24 -0800
Message-ID: <CA+P7+xpNhEF0=QoR71v5Y=nc39OL4XKX36xXYjP1Kn_+DUCf_Q@mail.gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 10:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sergey Organov <sorganov@gmail.com> writes:
>
>> You've already bit this poor thingy to death. Please rather try your
>> teeth on the proposed Trivial Merge (TM) method.
>
> Whatever you do, do *NOT* call any part of your proposal "trivial
> merge", unless you are actually using the term to mean what Git
> calls "trivial merge".  The phrase has an established meaning in Git
> and your attempt to abuse it to mean something entirely different is
> adding unnecessary hindrance for other people to understand what you
> want to perform.

Agreed, I think we need better terminology here, the current words for
(TM) are definitely *not* trivial merges. Same for "angel merge", I
don't think that term really works well either.

The goal of the process is to split the merge apart to its components
for each side branch and then bring them back together after applying
them to the newly rebased branches.
