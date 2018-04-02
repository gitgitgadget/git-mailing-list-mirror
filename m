Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214B11F404
	for <e@80x24.org>; Mon,  2 Apr 2018 18:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeDBSbZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 14:31:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36557 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbeDBSbY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 14:31:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id 91-v6so5210425pld.3
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wnnsUwVLszhCHI/XJ4Vt+dXchRXQTEkOrBxVZ3s9YRc=;
        b=DaXOsdUNHf8jKgzGHDGucWFjC0Dv8e2dDAMHV3HtOpJI5M8VA8/Sd9DQGxSSnAZY7a
         PclbN+rb211miBTBmzs1KnFflrY5r7zWFuOOFIBY5YLa0c+85ggBXDG8+ZvjXImFWx6p
         9WyO6e0ObOrTPp+N4a7uFBiYXe0xI9+xMQt38pt4cYcsW3H4WvO4T3mcsoS4SEUPQvxe
         W+pM37kILNxC7jeneDBQvRGwAb+Rg1/i7AyVqR6mGVs8xBsCsFkg0UgToDm1F868xyyI
         4JllOHgBjxpqY81JTWhOcgWiBpvSEyzi6c7aIgcghOUYdeKAyp/C6TSBmxz8a2dj0Oyx
         B9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wnnsUwVLszhCHI/XJ4Vt+dXchRXQTEkOrBxVZ3s9YRc=;
        b=AkEv6FRq1Mah5kiSUTGzxxJsnPSTKD1Pb1MyWJxm+CZnL+ZATxoWmlEUtmUeu1BpeR
         29FcsJg4PKLrkkTTODKPQXtq4R49OOr6ymagjR5luBiEX4k6OWzXr77vYNRrItizCS9Z
         C9AlffkMePLyN2vdfcAWuaWQ+jj0qq6TxnFc32s3Rajqx9INNZMfzFkful+Xnwkjo6lb
         vdEcVlO/Zfqm2nUmtXAR4Q2PANdpbP7Um13+27Xp14dcg1Pz3WQGvNeyHkJtk3SoiD2H
         TAzLuZ0m9rreyQ7obatbgbqQTVJ1cwhb2Tb5FG2/YoR4UhTQ4H0ZxGBwPIt7e2V+AyHh
         X7Mw==
X-Gm-Message-State: AElRT7G7eyTxvVRyLJhG9FZdtR1gR8fJLBJ9rHYxmnRTpciD7X/nwpRq
        qEvgQaKoplBcPuQtMtxKVy0=
X-Google-Smtp-Source: AIpwx49IgQpix25smQbW5UNa0Q14T5C+ggTZs3OyUy/yofA2Q9tEvz7sAirdA2s7a7FHeST6GzAb+w==
X-Received: by 2002:a17:902:24:: with SMTP id 33-v6mr10845182pla.341.1522693884176;
        Mon, 02 Apr 2018 11:31:24 -0700 (PDT)
Received: from farpc0j7wwf.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id y6sm1718343pfd.18.2018.04.02.11.31.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Apr 2018 11:31:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v12 00/10] convert: add support for different encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqwoxu684c.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 2 Apr 2018 20:31:09 +0200
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <3DC6237B-002F-4CAE-AD57-E10A5B5D3D3C@gmail.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com> <xmqqwoxu684c.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Mar 2018, at 20:37, Junio C Hamano <gitster@pobox.com> wrote:
> 
> lars.schneider@autodesk.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Patches 1-6,9 are preparation and helper functions. Patch 4 is new.
>> Patch 7,8,10 are the actual change.
>> 
>> This series depends on Torsten's 8462ff43e4 (convert_to_git():
>> safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is
>> already in master.
> 
> I didn't see any further review comments on this round, and as far
> as I can tell from my reading, these patches looked more-or-less
> ready.  
> 
> Except for 04/10 that had a few messages around "who should be
> responsible for handling the 'NULL is for the default UTF-8'?", that
> is.
> 
> So, what's the doneness of this thing?

Almost. I'll send a new round tomorrow. I hope to make this the final
round.

- Lars

