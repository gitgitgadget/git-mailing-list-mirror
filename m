Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DCA1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760250AbdACSPa (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:15:30 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33899 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbdACSP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:15:28 -0500
Received: by mail-pg0-f47.google.com with SMTP id y62so165205992pgy.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JNNoEIaPJ1UzVjvsAwyCwvmC2c3AIXd9wD6EIhB77Vk=;
        b=Qg+5iX3BNYvAAGy/BjDebIfQzw6cOC6FIlKT7eJxisIzxeu4QtVAq9ZVQPyMUhBjN3
         ojHOzzlaxuefDfAKr58iqXqEMWgGbV+R3MzHOb3zF8re7FZ0Mrbb6Ctw8KakjdqnlRTx
         ISdOJnumaLR3iqPtyT/50VYpqSL71IVAJw8OsUzJeh2NMO5Iuq8RKSMNvVSl0iV0rNTe
         uO/vymFTlIiwnqpCOIsJMurRCftdSvirkX6/WVO4IMICTA8GYJHT21uSwBlejrZJKEZL
         UnrGgZzlXVLCSKowhF1KG5ZOaxQq9vkBR9AVZt4LzULlbsp3ea1U7Jaqn6vgQp+QVcLl
         Yajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JNNoEIaPJ1UzVjvsAwyCwvmC2c3AIXd9wD6EIhB77Vk=;
        b=NhORdpJVO5+weWlNjz4tjMDX7tjSv2t3HoKs1n96OPRQjPGnjNZPHS2yDC4zEhEGs6
         dyhuCYlvsgM1RlbXNBgnm0JBTzWF78uJ4GEmRzahUlrMNq4MFVpxQkKhzk2m4rRxDXcB
         L3Bb9++uicB0xnVEknJkbadI8QJWLKjnvnYk+Y2SXGE4NFLY/k+mnUvdF06sITjUDbUI
         MmoPTBDmWTK38m7eMSqG+2OyhIApXjVWRo2xCjnv9kB9++eQ6Vq856vdJDfbTkKFX2Zs
         t/SQXD2jK8sA+87aVXBTXebtAQTjKdHbWzYl1xwTZHuRfPUcFb3Q7OMswNo0Gor6ia5f
         im2Q==
X-Gm-Message-State: AIkVDXLVOgGG0ygxQPONTc15o1N6Kiqga671xZU5ZQvuOUcwHf+NGwbez1IVvg3VwrLxeNWF
X-Received: by 10.99.149.1 with SMTP id p1mr119109984pgd.21.1483467328178;
        Tue, 03 Jan 2017 10:15:28 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c019:d4:4575:9b1b])
        by smtp.gmail.com with ESMTPSA id 65sm141503979pfl.21.2017.01.03.10.15.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:15:26 -0800 (PST)
Date:   Tue, 3 Jan 2017 10:15:25 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/16] pathspec: always show mnemonic and name in
 unsupported_magic
Message-ID: <20170103181525.GB42671@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
 <1481670870-66754-9-git-send-email-bmwill@google.com>
 <CACsJy8Cja1um2oFDWufyk_7xaZbf9+=kyuWFx==Vb0nHiMqiwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Cja1um2oFDWufyk_7xaZbf9+=kyuWFx==Vb0nHiMqiwA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03, Duy Nguyen wrote:
> On Wed, Dec 14, 2016 at 6:14 AM, Brandon Williams <bmwill@google.com> wrote:
> > @@ -340,8 +336,9 @@ static void NORETURN unsupported_magic(const char *pattern,
> >                         continue;
> >                 if (sb.len)
> >                         strbuf_addch(&sb, ' ');
> > -               if (short_magic & m->bit)
> > -                       strbuf_addf(&sb, "'%c'", m->mnemonic);
> > +
> > +               if (m->mnemonic)
> > +                       strbuf_addf(&sb, "'(%c)%s'", m->mnemonic, m->name);
> >                 else
> >                         strbuf_addf(&sb, "'%s'", m->name);
> >         }
> 
> The die() call is out of diff context, but it'll print
> 
> pathspec magic not supported by this command: (!)top
> 
> which looks too much like :(<name>)<mnemonic> pathspec syntax too me
> and threw me off a bit. And it's a bit cryptic, isn't it? Since this
> is meant for human, maybe we can just write
> 
> pathspec magic not supported by this command: top (mnemonic: '!')

I was trying to keep it short and sweet, turns out that ends up being
more difficult to understand.  I like your suggestion, it definitely
makes things much clearer.

-- 
Brandon Williams
