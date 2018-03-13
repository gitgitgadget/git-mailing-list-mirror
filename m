Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8301F404
	for <e@80x24.org>; Tue, 13 Mar 2018 00:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeCMA3m (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 20:29:42 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41977 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbeCMA3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 20:29:41 -0400
Received: by mail-wr0-f193.google.com with SMTP id f14so17749258wre.8
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JyT2rVi7/Dd/wg8YN0ZyQ/42Hufu9lInM+G7wBhq4Rk=;
        b=XpmItl3duqo42JF1sChAroTJwXdN6RhRUUkf5DEeQoMAzJBwqbpyh931/pADR9R92P
         4JV4YZYXRkQ8WP6dWU1G/+VVeCeNGicO4Ko2pQELjrA8zLhLJTAy30JPEVq/Rvo4X7yp
         ACma8cDfOCnbNgkcZY8EKPKG/jTMRVnlSieMjPKcwygFImWfoEloCRdh1WTmNfohvabg
         bgzGEUbRKBwS6SseKxSko2zynGmdW2zlwxdMXfyWdNBTeJVXfBrP7DE2ZlWYfXXFhbXR
         jUqtvp96zS5W1exw/cDek5hsLX7su8Y9NRdDExaRCh/YrMNQvM2Oh9grtcxEMJ0gREOM
         NTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JyT2rVi7/Dd/wg8YN0ZyQ/42Hufu9lInM+G7wBhq4Rk=;
        b=hDncQBM0jdnFiHtAoD9z+z+CZciUsPcvUB+Je6ET3TzJZxSpxYKVJdzTMsrDEaEuvF
         anCcnUnM9r2wi86McxiGGOA82pCdR0cdIXQsKAuRcX4aWl2RdTgObBxGlyp3ZIDrlNJT
         PcoJOC/mdCH9UWw6wdksn4PiN0qKnIVh+/wl1OBRcUJlodDq7+KFh9t802k34mguIkX4
         SNDETjq0ExMUt65Ekhyus8VeTbxF5GrJa2rtzdnby6E2zd59vqKrIoat2es15B3FNhUR
         rUPygSQs7+e65q9cuAvPeI2wCtHe4PApvVjZBLQxZpi5Mr+CTLy8r6btze50yZ2Fd7T5
         1yDw==
X-Gm-Message-State: AElRT7HTGLLHoH2FnzmGHWjkrqxNrcKtWb99JE/46WwUPzhLUHfNMevK
        Ano3jwnQN4TKrWzHyrX4cQ0=
X-Google-Smtp-Source: AG47ELu+0miYXqr8c0whLx2xkEqnntwowgUXY8f4r6dujKC1nAWjWAzA50Q8YJGPcae4OdfVrZLYFw==
X-Received: by 10.28.194.213 with SMTP id s204mr5660181wmf.43.1520900980569;
        Mon, 12 Mar 2018 17:29:40 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id r70sm7570706wmg.40.2018.03.12.17.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 17:29:39 -0700 (PDT)
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae8yq15.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
 <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com>
 <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com>
 <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com>
 <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com>
 <nycvar.QRO.7.76.6.1803121056400.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <45d05a89-b10e-5035-7c5b-2981dba27d42@gmail.com>
Date:   Tue, 13 Mar 2018 01:29:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803121056400.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 12/03/2018 11:20, Johannes Schindelin wrote:
> 
> > > [...] and cannot introduce ambiguities when rebasing the
> > > changes introduced by M (i.e. the "amendmendts" we talked about).
> >
> > Hmm, not following here, which ambiguities are we talking about?
> 
> U1' vs U2' of course. Those are two things that can be different, even if
> they ideally would have identical trees.
> 
> Phillip's strategy does not leave that room for ambiguity.

Ehm, in Sergey`s approach, this is not an issue, but a feature :)

If U1' != U2', it just means a more complex rebase happened, but it 
doesn`t compromise the result (rebased merge) in any way.

On the other hand, if U1' == U2', we can be pretty sure that merge 
rebasing went as clean as possible.

That`s the idea, at least.

Regards, Buga
