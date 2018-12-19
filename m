Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68162211B5
	for <e@80x24.org>; Wed, 19 Dec 2018 06:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbeLSGdP (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 01:33:15 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:40018 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSGdP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 01:33:15 -0500
Received: by mail-io1-f54.google.com with SMTP id a11so115562ioq.7
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 22:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNuiCTivs6S2Y3NFJwoDnRmmEC+RwRvYGoHhDRbEaGw=;
        b=L1tgfhrozQvDK6/afR1qzn3aMDVyalI7up9oXt+Nwb4b/sQ4w7jYY7MMKxG/73xWWE
         eWRlBO/c1OyjXO1IKioBoWa4ePopB0SB5UJJkoifd/dbwNR3BEaOF9c2W7WVuEoPzZ0C
         iglLxSwLTK+7zQHW8ht0b120140N6GbjoA+QV/wKG5Bh8nW0cSlRp5Ywwd+zbrIp/vYH
         /5/YkeKMiM3q9gg3w5QNMc+RXg7Vg5PgRrX6/WqAht0lLQOl5TqPPnqYa1lFkoSYyQaI
         GGDn2P0/6uAhC1xt8yO/7omXA9GpHEgUcq4fLLD0GY+D5ID/gSqQRrkxVU8c3vbi7KsF
         39vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNuiCTivs6S2Y3NFJwoDnRmmEC+RwRvYGoHhDRbEaGw=;
        b=XjXBMsozZRFdYRC6NJ364W4/Drlz/Vx9j3joefKLcrXxURIG1A/8bhkhP/0/wJi7B4
         GITn8vQXt4FHUKDkJ+86Tr8SEELCGvP0HSLrJR1J5pg91+kMbAsDSvi1GCIqnRQc4TsA
         5a4He9B8jVJSn6bLhScxcRi3H8egQEaWD7CxPXTEMTKDAlUIceEfFoiM739hPcm23CpC
         gaewr1uCndZw4DQVzHaV9ZY9Ga8W6DZCQ6XGupACWNVsLXpgsGSeXzqXWXTBmOCuju7/
         JOdMfYO1LkwzvDyGcfuBwlkBmw0vurQyMw9nFfGA66C/IDkoqo6/8w8lH/5zX5+oGZUW
         //ZQ==
X-Gm-Message-State: AA+aEWbmSJROHbJCnEAEpfHJ3p44PgVGvYYdFU5cNEyduoi8GK/ndS9p
        CIFvamAjEkVLWb6WbCUW/gZ+ZGQoVIA++pDtdY8=
X-Google-Smtp-Source: AFSGD/VXcHAkuAXm7hBx3qI2R1bfLckju7UXeOY3Yx+h+zznAE1ERAWBC3S3k37yWoQxi+paTuLr3BvYe8qUNQMgHZE=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr16844823ior.169.1545201193193;
 Tue, 18 Dec 2018 22:33:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
In-Reply-To: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 18 Dec 2018 22:33:00 -0800
Message-ID: <CAPUEspgw2xYxNQN-0_nqQrWE4jhmMN-9aHgJ8NvLDcEKTrZNAw@mail.gmail.com>
Subject: Re: Can git choose perl at runtime?
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 7:29 PM John Passaro <john.a.passaro@gmail.com> wrote:
>
> I recently submitted my first patch using OSX and found the experience
> frustrating, for reasons that have come up on the list before,
> concerning git-send-email and perl dependencies that you need to be
> root to update.

you can install them somewhere else (your homedir, for example) and
then instruct perl to look for them there by setting the PERL5LIB
environment variable

Carlo
