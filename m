Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF8C1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 14:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeJWXBq (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 19:01:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39114 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWXBq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 19:01:46 -0400
Received: by mail-it1-f194.google.com with SMTP id m15so2384311itl.4
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eO3F/zeauo0KZ5R1pkoquI/pWTblX2TYNgWG18omQNY=;
        b=UCzINiPBt0tH6Y9kJWY3TEFCs0cU5RJZnzck2mcK1y/BWlBFH1LWDYrhuLdY467aIi
         96gcSOI41Zi7gOyNnqO9kvNMVzeH0lkY3zGMb8Xtel4pL9UkqDj/OSohwOdc1usa70Qw
         D37xAqVhvGrg7OMOvZTpR1ofLKZ5qjWrZtl2gP4mZ9ePc7LC2fTz7bT/KU5lj44AvvWl
         ndrL9YZi/ZSETkSBnz6rv0kqFTEeRag1tmjm0pRs0BuTDs8DUXhS2nyFx/JgQDJGf88D
         lOgjF/BUAegzngnQR7XmXgkabI9AT9eLNl+MfC++ihDFL41AveMpjKh7iBRE+L3oheiz
         yf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eO3F/zeauo0KZ5R1pkoquI/pWTblX2TYNgWG18omQNY=;
        b=FXAHf9hopsLnquU+787RQSYcjeeVR1PyRd87RwetUowlYKFSv49B98BD7JmVqwydiy
         jqfbTwocMQzlNka+KDwdwOxSET4CMXud3ldul8Ya+5KNZAbifxBqzCGrq3D1lxFv9rSq
         lTK4lrJ0vky0804t9zYSNzT0okhZ/ZH0CnD5cucYlYp0agZL+bw0YnKc25IQyxkYot0/
         X0CzXl5x7WnOPLL7VMP+HsX1luC/WtFLz7iRWK5cAWNe5kitb/ciJ8weRucZg85zZUJz
         47oS6c585wKTE252VGPO9UjS3PxRtple5EBL3RZWtdCZSctQ7L3N5kzujuSzo3wALJED
         /EpQ==
X-Gm-Message-State: ABuFfohegVDqT/PkfJdKjBQcNNGHZnXUdVNyS/6ulvxs0ppEQ4x+Voi4
        nh3sCsTBYsj9vowFgWM+ymaUVLaiazmm749t83w=
X-Google-Smtp-Source: ACcGV61EvHTzvGt95NsxV3DfBOohkL+hFpyJcE18+Dc3UA1EUJTlGeEtTFNeKvqz2Qg+sCirTF1j3lKvGprjmlVRWD8=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr12983137itg.70.1540305483416;
 Tue, 23 Oct 2018 07:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181022153633.31757-1-pclouds@gmail.com> <20181022202241.18629-1-szeder.dev@gmail.com>
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 23 Oct 2018 16:37:33 +0200
Message-ID: <CACsJy8COKa1JZFOSQBDZoJKQ7aJgEvKFmcu0sFa2BDcuJa33Pw@mail.gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 10:23 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> Once upon a time a GETTEXT_POISON build job failed on me, and the
> error message:
>
>   error: # GETTEXT POISON #
>
> was not particularly useful.  Ook wouldn't help with that...

Oook?

> So I came up with the following couple of patches that implement a
> "scrambled" format that makes the poisoned output legible for humans
> but still gibberish for machine consumption (i.e. grep-ing the text
> part would still fail):
>
>   error:  U.n.a.b.l.e. .t.o. .c.r.e.a.t.e. .'./home/szeder/src/git/t/tras=
h directory.t1404-update-ref-errors/.git/packed-refs...l.o.c.k.'.:. .File e=
xists...
>
> I have been running GETTEXT_POISON builds with this series for some
> months now, but haven't submitted it yet, because I haven't decided
> yet whether including strings (paths, refs, etc.) in the output as
> they are is a feature or a flaw.

A feature to me. The only thing that got through and but should not be
grep-able is strerror(). But that's orthogonal to this scrambling
stuff.

> And because it embarrassingly leaks every single translated string... :)

Easy to fix. I hope this means you have no more excuse to not push
this forward ;-)
--=20
Duy
