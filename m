Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458211F406
	for <e@80x24.org>; Sat, 12 May 2018 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeELOAs (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 10:00:48 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:45532 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeELOAr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 10:00:47 -0400
Received: by mail-oi0-f44.google.com with SMTP id b130-v6so7073166oif.12
        for <git@vger.kernel.org>; Sat, 12 May 2018 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1nh/XYoZAJpWUX/fh7ejvvEp05DZyueyrXP39ryAcNE=;
        b=vOqfU4ISXg8N7/n7b9jwv7ahpHF+8j15araF4fARPFs2HhEIh8j2N9vTEG3lWqQT+T
         Mu1LwFLmvhj1SqP2iS6KqCXMql5jVSLfJ8klmCB3r1MNBAk41sd4qrEeJE/V7Orm9xAX
         1NU/8ymcRi5ZvzihLBESlQzizzRjK4vtXp3B/wELDHUQj+828OOiJp4o9axYM85Xf2jd
         9M6Lt8eFbhvdEhlUHpxApTkhW9v0Ywx7Mz3OpL7kstIgb4VDgO9j+KlCjobPyNf3bygi
         eoD+Nk9qvG127mBsvRh8OPje8eI7yqGV7vwPujaU5P3Mm85muowR7anQTzEqFJ194bYO
         uUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1nh/XYoZAJpWUX/fh7ejvvEp05DZyueyrXP39ryAcNE=;
        b=TBK8SRtmWHBZK1aFfoHRTwJLz7ZbR9BhcuLXdEYz5zGG+kUmA2nEyT/JViuaAuEPbY
         9w1slZVnBZGcwGGQ+Jh4MiABTKUdET4S3ZCtE1oLlDZIhAbYxWca+18u0ngKqIA5lw+4
         Mr/+NXDyiFYkavndvKPFJK9Zc5AtyHaKEgk3A6sgGuXoZfyRByJd/Z2JxtrlTeI9sK/W
         ZsIHtKXvcqEU7YuZ9u8vGRc1vdqWDbNayuuFuv4tw5FMYkEnJ86IM9kYlehEM7QyqqzW
         4L7ksejOGCtKNdsgKSjjvMmAEOYdYz1NQH9sOlqhYPXhhmlHWlK+BEV6CDQW9X2OcUmA
         p9Jg==
X-Gm-Message-State: ALKqPwf1R7trZmEVBqC1WcsgmqIlY4Z7VCF16lQhrCPH2OQsFWAlmLgZ
        fmR3Evjj4XTaCdTj64DsFTTzyTtk/yfaOk9iUFo=
X-Google-Smtp-Source: AB8JxZpYubzHzLBjEzy+084AjLQirJcuIDcKPwSFMj2Ascsr0k/P0WxMqFJTol6FUqznw/K4JM3z5Ek1YKFAhtwPxkg=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr2164727oig.34.1526133646617;
 Sat, 12 May 2018 07:00:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sat, 12 May 2018 07:00:16 -0700 (PDT)
In-Reply-To: <xmqq36yxf0qc.fsf@gitster-ct.c.googlers.com>
References: <20180512080028.29611-1-pclouds@gmail.com> <20180512080028.29611-5-pclouds@gmail.com>
 <20180512092500.GE28279@sigill.intra.peff.net> <xmqq36yxf0qc.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 12 May 2018 16:00:16 +0200
Message-ID: <CACsJy8DOsSFDR8zoXogyqvKaFrdnF=sQK6O+uvu47OGBrT2sWQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] sequencer.c: use commit-slab to mark seen commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 3:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sat, May 12, 2018 at 10:00:20AM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>>
>>> +define_commit_slab(commit_seen, int);
>>
>> Yay, this one is nice and simple. :) This is what I had hoped for all
>> along with the slab concept.
>>
>> -Peff
>
> Does it need to use a full int, not just a byte per commit, though?

True. Is it time to introduce 'bool' type? I did not want to put the
'char' type up there (but now that I think about it I could have put
uint8_t too).
--=20
Duy
