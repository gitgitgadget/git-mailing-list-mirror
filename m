Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4BAF209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbdFFSXV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:23:21 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34332 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdFFSXU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:23:20 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so100525729pfj.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f2NhU0GB0NSH6iTV3xSMKXcTGzvQl5rk3TLf89w5rVM=;
        b=ErebKXpgQePbX6FE64DNYB6VAu17BFwtMfGqhOffOkXMb0CUbTF9zra2MtONuHfDBv
         BqYwq8WTyCFiuCpRDph9q+vZ0Qg1cun0YuWlwzLTrCNxfZVkW2zT2gz2113VHXcn9pPl
         QGrMBtDTZ57Fqod53Pb9T3JVdKcfkpd7nz8Hk3GrAv3B7H2JsNMsXajVzXWRHv07rSwh
         KrXzeECxFFRfenksSJT1nFZxfS0F7yZZQT50h7V5gEnf6IaEp8HsE6ehB77UgwDBVb5l
         +t9T9LFVgUaPy1ONOidH2c0SZH5uEQiAthgQZvHw2O4iXm56oxO4+9rP3rI5VlF5k5dp
         +d0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f2NhU0GB0NSH6iTV3xSMKXcTGzvQl5rk3TLf89w5rVM=;
        b=XXzpOovnmVf+GfPusdlPb2XYgv92N5wPpUO1FN2ZSAZSJLhCx0lU50wk9QgNqqv22h
         KmTl1Gs6KHXjyA2+iGxaPS5/gAJ+klv5rg5Wb8Xc/z6fxryXuCnQ/awE+r41vXZezsDB
         +pg/zJW1/NkAhoiQfTrh+4awHFMgiou03AIPvNQsQpo/pNVGPVAEs8f0oa0qC7/ofZ7w
         AsE4f6KKwblRjvxCB9K7kG3Hw4oGgNZ71tsaR7uV4D28T+ReviD/JcJ63CDfnl1vX9mt
         zbR7TfN2oPGSIuFmdMhnOmYJWcGLGtWlMewRDMVacQPe6mocG53jeUIssvroUF+Po7g8
         dUrg==
X-Gm-Message-State: AODbwcCXVsWDstzvgL+O9nHRglMuSd5cdNqF24D+UgkOYD2An1N+giL5
        riJ+IbUGDQxmAPtX01G0e7Bf89gTxfe5
X-Received: by 10.84.137.165 with SMTP id 34mr22582170pln.167.1496773399780;
 Tue, 06 Jun 2017 11:23:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 6 Jun 2017 11:23:19 -0700 (PDT)
In-Reply-To: <20170606151231.25172-1-avarab@gmail.com>
References: <20170606124323.GD25777@dinwoodie.org> <20170606151231.25172-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Jun 2017 11:23:19 -0700
Message-ID: <CAGZ79kaaRsUBAxRKLPxjuk=oRrw2zBdoHWd9iNDmTbY9MpqN-w@mail.gmail.com>
Subject: Re: [PATCH 0/3] update sha1dc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 8:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> This updates sha1dc fixing the issue on Cygwin introduced in 2.13.1,
> and hopefully not regressing elsewhere. Liam, it would be much
> appreciated if you could test this on SPARC.
>
> As before the "sha1dc: update from upstream" patch is what should
> fast-track to master/maint and be in 2.13.2, the other two are the
> cooking submodule use, that's all unchanged aside from of course the
> submodule pointing to the same upstream commit as the code import
> itself does.
>
> Junio: There's a whitespace change to sha1.h that am warns about, but
> which it applies anyway that you didn't apply from my previous
> patch. I think it probably makes sense to just take upstream's
> whitespace shenanigans as-is instead of seeing that diff every time we
> update. I guess we could also send them a pull request...

I would suggest the pull request.

Also as to not make the mistake from before that I jump on the
submodule bandwagon here:
Patch 1 ought to go in its on series/patch, so with that out the way
we have more time to consider the pros and cons of the rest of
the series?

Thanks,
Stefan
