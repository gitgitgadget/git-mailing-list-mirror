Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAE51F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCVQfD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:35:03 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:56210 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCVQfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:35:02 -0400
Received: by mail-wm0-f51.google.com with SMTP id t7so17166032wmh.5
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cdUAfMPBiFumDSReMGZT5l0CUpoZJiG6qxuQqvLgVPo=;
        b=JmjaiB1mUS+JJY4Tv834GiEyJdkdo4fDgTvqTIPCSHY4+K4IsCwF4eY3Jpjnfk0QuT
         4wbq8lM4/zuSbsUCTjYcrKQyfGj2M7vKw9jdSiOVZWzkfwgzORNiQnqHdVHCsolbxOvx
         gWdXTQIoGyJZtkfAkIJ5xlc8tGf9YjaddnqUDG2cayEm9Fzk6VDmYTW6Z884WTHDj5m/
         w5c7u3z8pEQvt44zfBuXLtgmHKOhe5GGKwisyfv7tOtOr6NB4IegJGWYtYAUw/9EAMVN
         yDlhktZv4I1eAaA6aBC71SHM+veMvUb7f5afCEqS12Qhk8/gjFhKNHKCRyWomx1v4RlO
         AkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cdUAfMPBiFumDSReMGZT5l0CUpoZJiG6qxuQqvLgVPo=;
        b=eFP30tHHVs9a0WRlGtAhEMGi2/KxCBAaApooPxOCa5Qaasz17LQiVcbtmGST2VllkE
         4NW3vWPlg4hYjrzq4HdLeJU7mEErpimuG+5n5I1wXwQkjlhQPlo9iLZEBYtRtaqOANvg
         z0gUmMsF7EPZNC1l7UGM+fyQ43kWt8+hUH+/irL2MlIpAWg8qgw6RXCFyzY23L7jWvXJ
         3QUF1iCufReJOpt5dHkGpxZEV2AuUVZY3vZjoWRZcryn0+dsHPKyiXbHLd6UrGJjqMGy
         mpSLGfhHy6vnGTqZ4dQvVKNfZxjnoUckyrvBY/n56eTM1OnJiPWjyZe1YViAB/UC7Ieb
         KwXQ==
X-Gm-Message-State: AElRT7Hs0k05f8LcImhQZIVwz2Xhryd3Ic1ngIPPWfLom4yc/hTH//UW
        mjq+vTjyCuYTCX1/A4HwLBE=
X-Google-Smtp-Source: AG47ELv7MCYh/6TKsOljiA9anEeRuxx8udxJdszbiOJdlzj7RfGA8giPIz8uAF7t2t9zRxwivZ8Agw==
X-Received: by 10.28.113.216 with SMTP id d85mr5724292wmi.97.1521736501063;
        Thu, 22 Mar 2018 09:35:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l22sm6863381wmi.39.2018.03.22.09.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 09:35:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Pursehouse <david.pursehouse@gmail.com>, git@vger.kernel.org,
        David Pursehouse <dpursehouse@collab.net>
Subject: Re: [PATCH 1/1] Fix typo in merge-strategies documentation
References: <20180317033142.20119-1-david.pursehouse@gmail.com>
        <20180317033142.20119-2-david.pursehouse@gmail.com>
        <xmqqo9jkvwjh.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803212330510.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 22 Mar 2018 09:34:59 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803212330510.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 21 Mar 2018 23:31:14 +0100
        (STD)")
Message-ID: <xmqqk1u4m5l8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 19 Mar 2018, Junio C Hamano wrote:
>
>> David Pursehouse <david.pursehouse@gmail.com> writes:
>> 
>> > From: David Pursehouse <dpursehouse@collab.net>
>> >
>> > Signed-off-by: David Pursehouse <dpursehouse@collab.net>
>> > ---
>> 
>> I somehow had to stare at the patch for a few minutes, view it in
>> two Emacs buffers and run M-x compare-windows before I finally spot
>> the single-byte typofix.
>
> Pro-tip: git am && git show --color-words

Yeah, I know, but that would not work while I am wondering if the
patch is worth applying in the first place ;-)
