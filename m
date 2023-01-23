Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312C7C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 08:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjAWITY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 03:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAWITX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 03:19:23 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDAF15CA6
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 00:19:22 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 78so8374947pgb.8
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 00:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10oFN63LDVBY77kDmPqCPP17g2cKUysQUWxzkRq7xao=;
        b=ADdQPvFMgG/vxV5SX5iiKLSO2x3bVbx31rqeZlebRhASO39Ae7Ggw1SAtB6XHBFbFN
         YDFkvWv8/MPmHhmitsSvJkaTg5CuIaI2F722pQHF+fDuuW1eASwD3ah65HBnRHfjB4Wc
         ZG8mr4j2s7sDj8l4sa/HMSsudDKS87IXBYko64goBP75BVRrmaVhDwGf2zhxQs++VzbT
         EUgZncAJpXZdgJ3lhzTqo8F3KDvtpDZIpVI/hE3pPuzOnDaTxzgqsT/JtHmPEBIZ4Ccq
         jCtIaFC/s6c+HGs0BV3nbc6iReqG+W8UBlopmn/tsg5StaueTso4G0qL9GPNVsV/Dmra
         wPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10oFN63LDVBY77kDmPqCPP17g2cKUysQUWxzkRq7xao=;
        b=8Kr3xbf/0Bj/u8QgVGiTRhSGre+JG8wbwv/kFBYA9iIYlMNIU022HlvW3SE46RFXQB
         coqRrFeGhZLH85lfore76n1cXmtFzzsvu+ugrsbPGoFV8Sw3088k1FUXAOe+XimSXiuJ
         cEJTbD2HVWAFYi5HJb9E6B/hS79fCTIIDJ7DoG+YtNYC12ocCN6oUSfe3VFKWrAnXH24
         uN+PONcgA/InmypM8qkPrJ1dDJH3E74WLYOl+bV6nEcByVgD2YkZZZOJtectDXGyfxRT
         /rFbbW5kNdg7o32sQRQvk12IQl0AhsMw5q/PWG/QxR+h7GrBYuvYD6J7o2fM1KIAxDMT
         edEQ==
X-Gm-Message-State: AFqh2kofrXenlZKg1p3ajvuUjGjl1zVdlaYp7nsqgUWuxVt7vDErjVIX
        fOGjAwDx1XO2nN9MFxgAHgcxG6jABRfzy6t3dSM=
X-Google-Smtp-Source: AMrXdXuVneR+iL/N82FmaKJxM+k/vFFaqYHH1bPIYA/jpB2grxbLrgw3fC3HoTEKVZYhJ+4mRYhTfSvRZtNbfr5om8k=
X-Received: by 2002:a63:cc01:0:b0:4d0:370b:5027 with SMTP id
 x1-20020a63cc01000000b004d0370b5027mr2048134pgf.8.1674461962433; Mon, 23 Jan
 2023 00:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20230122165628.1601062-1-rybak.a.v@gmail.com> <xmqqcz76qizp.fsf@gitster.g>
In-Reply-To: <xmqqcz76qizp.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 23 Jan 2023 09:19:11 +0100
Message-ID: <CAN0heSo6poJMNSmJ2Vwy2ecrW3YRc0E5VYLH22fXUgnqfx_TAA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: render dash correctly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Jan 2023 at 23:55, Junio C Hamano <gitster@pobox.com> wrote:
>
> Andrei Rybak <rybak.a.v@gmail.com> writes:
>
> > Three hyphens are rendered verbatim in documentation, so "--" has to be
> > used to produce a dash.
>
> Sad but true.  I suspect folks with TeX background were so
> accustomed to type three dashes to obtain em dash, but with AsciiDoc
> (and asciidoctor), sadly, two dashes is a way to ask for em dash.
>
> The changes in your patch look all reasonable to me at the source
> level; I didn't do Documentation/doc-diff to verify, though.

doc-diff looks good.

I suspect these were identified by greping for " --- ", spaces included.
We seem to have some "---" that aren't surrounded by spaces. They're
perhaps a bit more tedious to find, but I see there are two in
gitformat-signature.txt and technical/rerere.txt. Maybe it would be
worthwhile addressing them too in this patch.

Martin
