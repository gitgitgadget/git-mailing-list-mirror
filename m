Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1352092F
	for <e@80x24.org>; Tue, 24 Jan 2017 07:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbdAXHHH (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 02:07:07 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36917 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAXHHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 02:07:06 -0500
Received: by mail-wm0-f42.google.com with SMTP id c206so193366923wme.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 23:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=htC8dvmyvB3vNrGSA+RKcLhGlg2JdLeonTXsd1tIKSM=;
        b=OewALbWJFLshONMF4812S0RrwaPKpxYfFaoREj2cn1vhd7wwXv8GzHnlMZuTWFCaR0
         d3bo/RVNmqjcY6h0gLQlxkOOJnXQgQrDkjfdbXR4VMlIy8o7FqRI/dssnz2t2fWc/mk5
         TIUXC5yssKpEzFO379YdDT9GFZptGMTPZyn7VaWgNj/kGKEIOcLgaqAMwnjadF7GUuUL
         5lFYWpSlHFPgOPnZxt5tBFr96tawAaTo+PQ1F2TlpVGiavdfazUZJbiScZTtfSz2IZmq
         aJOSbEYnX3JZpNHIVPx85AaWZRoXzRPWyD9ZJmX2/XoMTHwMJdVdOCtCm5qWoL3Ds/cE
         s4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=htC8dvmyvB3vNrGSA+RKcLhGlg2JdLeonTXsd1tIKSM=;
        b=C+UhfxQCAMBB96yy+JM2a+5ElNhXccBlTTSS3zB3sTkmbXBCOAgK8KQV/EoZ92laoG
         qUVW+oaxiszitrxdVgJa9aAcZJcET6/hcJDrtfg0P8PlnhU/jL7bnzby+dRUtWGjfX/S
         OPSBoguBJG2TMVn1UjFSrjb6x/8DdUYXv6ggYboJhSPZ1iwj1NHwgRe9sVSVYPKFfIGl
         2lJjKWI7F8osXraC1OV94nUNWLB8+N0CDLNf9aJVslLIxW1x552alx0LfCSIEZBOMJ1C
         IlwLaIQFdAyxwKfpPYHwSTJARpgefpk/f7PMv+tPvIupVoll/ZLxBiLeMwTX9dHZFX6K
         DLKg==
X-Gm-Message-State: AIkVDXIq0UdyHBxP6wa5HUf6iziODL3OvFJ8JlZiH4+dTrUP9lf987SUB6XrOz/ftFvl5AA3Bzk1t8v5SLz7MQ==
X-Received: by 10.28.0.2 with SMTP id 2mr17170661wma.141.1485241598976; Mon,
 23 Jan 2017 23:06:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.145.193 with HTTP; Mon, 23 Jan 2017 23:06:18 -0800 (PST)
In-Reply-To: <xmqqsho9pdbc.fsf@gitster.mtv.corp.google.com>
References: <20170121104904.15132-1-giuseppe.bilotta@gmail.com>
 <xmqqh94ptzke.fsf@gitster.mtv.corp.google.com> <CAOxFTcyuLkvgPOxQuzaDUVuDRu_KJg=JrYtU84pQyjLstChbLg@mail.gmail.com>
 <xmqqbmuxr0pd.fsf@gitster.mtv.corp.google.com> <CAOxFTczrLmWZg3720HMUA-13q9ADi_rK5k0x+TEYyKR=xR5b_w@mail.gmail.com>
 <xmqqsho9pdbc.fsf@gitster.mtv.corp.google.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Tue, 24 Jan 2017 08:06:18 +0100
Message-ID: <CAOxFTcwDK6tdb7xjemoxJ7rgEa9S-Ub9ZdrCEJFw98r0cUXRmw@mail.gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>> I'm not sure I follow. If the user doesn't want to signoff during a
>> rebase, they can simply not pass --signoff. If they do, they can not
>> pass it. Am I missing something?
>
> alias.
>
> Which also means that there needs to be --no-signoff option that can
> be given to countermand an earlier --signoff, if a user did
>
>         [alias] rb = rebase --signoff
>
> and wants to disable it one time only with
>
>         $ git rb --no-signoff

Oh, right, good point. This should be easy, I'll give this a go.

>>> In any case, will queue as-is so that we won't lose the patch while
>>> waiting for people to raise their opinions.
>>
>> Thanks.
>
> Thanks.  The final version would also need tests, so it may be a
> good time to start thinking about what aspect of this feature wants
> to be protected against future breakages.

I have troubles thinking how it could go wrong.  The most obvious
thing I can think of is it could not be remembered after an
interruption+continue. I'll think about this some more.

-- 
Giuseppe "Oblomov" Bilotta
