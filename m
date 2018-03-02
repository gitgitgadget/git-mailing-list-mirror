Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC091F404
	for <e@80x24.org>; Fri,  2 Mar 2018 18:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428499AbeCBSPC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 13:15:02 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43599 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427093AbeCBSPB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 13:15:01 -0500
Received: by mail-wr0-f195.google.com with SMTP id u49so10984785wrc.10
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ACxP1MInGuUhxZSNKEDbCPz9ewbzGMikahxetQCT6A=;
        b=I4ZXw0CaLVM3z8feWvt5pNpsQGW6EpTCrwAeLmTaEmufXKdZlG3igbtGO0HIGopI1l
         Kv66UahfBnczjsIA4Nxl6HABm9y3V19VMOFLRyhpMv11GlzxYKTX4HVAR/R/g8+UXa8+
         Fjj/DONRdIlyDvQj0/xhM/6OqSXD1bzAK6tuWMBzSnOoYRDqwRMsOKVHA+R+9nBIKErq
         5gmD5KdThV7VxaJT6s6VnBXGSDgQ7LpvZfl8V3BFAuz4dY8prRVRjUhb1GW9kmgk6H+N
         A5Ri81vJmOLWgY4I9jJXGJy5aSJxR2vUj5WogFVhbJVhk+Kb431mZOcsMG1nZG6t76xO
         9WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ACxP1MInGuUhxZSNKEDbCPz9ewbzGMikahxetQCT6A=;
        b=oZwvkiBvHco+55ZYfJ9lHzjQXMTAP6lPV4W1N+eGyAkvin5wHzrsTuaqIXxD2axdmh
         KzNbtgFAVTeAJNmN3CoagnUsA+j8+aCLTPuQp3KaDisQsQwZDPsQfh4eo33O55YR90Wq
         2BTenvAKNv4mDWZcK8oxKQyz+79q29q8EEEPhcQjGM6knwmTkVXk/iknkUlNllNbqG+a
         pYUMrItR6ucJQW5hpDwzVwzqScyyD9ZqAP5qetCjXxdNZRkZtD3iKYa+S5xLfeGFIVKI
         S42tVb6cRXUsb3Fw7mujs/oPWSAnhkQEneJxsntwCyqJ5jwGzRrfRBjO0+p7k61mQPyY
         +f1Q==
X-Gm-Message-State: APf1xPDBk+hbVOWUytluOM9a5NSxkLsjorxoIqclnJFGXkMClh3n2+u+
        3/Y/ob9Of9EZG6CETyi+9Lc=
X-Google-Smtp-Source: AG47ELtAzuGhc2y6EedmocHLuD1/2QRdgaNjmi64Dr8INbsmCxPAySRp1RU/q1FAFb95BCDNIIoQVQ==
X-Received: by 10.223.163.85 with SMTP id d21mr5744920wrb.105.1520014500169;
        Fri, 02 Mar 2018 10:15:00 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id b99sm10734948wrd.75.2018.03.02.10.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 10:14:59 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <CA+P7+xrkAKB621Na3V-tE9cMtbnADX94FvTrJf26SkQYbXqMGw@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <f26cdbe2-1bc3-02ff-7b99-12a6ebab5a70@gmail.com>
Date:   Fri, 2 Mar 2018 19:14:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xrkAKB621Na3V-tE9cMtbnADX94FvTrJf26SkQYbXqMGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 02/03/2018 17:00, Jacob Keller wrote:
> 
> > It is interesting to think what it means to faithfully rebase a '-s
> > ours' merge. In your example the rebase does not introduce any new
> > changes into branch B that it doesn't introduce to branch A. Had it
> > added a fixup to branch B1 for example or if the topology was more
> > complex so that B ended up with some other changes that the rebase did
> > not introduce into A, then M' would contain those extra changes whereas
> > '--recreate-merges' with '-s ours' (once it supports it) would not.
> 
> Unless the method of merging was stored, I don't think we *can*
> correctly automate resolving of "-s ours" because all we store is the
> resulting content, and we don't know how or why the user generated it
> as such. I believe the "correct" solution in any case would be to take
> the content we DO know and then ask the user to stop for amendments.
 
I agree with Jake, and for the exact same reasons.

That said, I`d like to see what mentioned '--recreate-merges' with 
'-s ours' does (or would do, once it supports it), would you have a 
pointer for me where to look at?

But if that`s something yet to come, might be it`s still open for 
discussion. I mean, even this topic started inside original 
`--recreate-merges` one[1], and hopefully it can still bring 
improvements there (sooner or later).

Thanks, Buga

[1] https://public-inbox.org/git/cover.1516225925.git.johannes.schindelin@gmx.de/
