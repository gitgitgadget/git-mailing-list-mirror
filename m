Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9662D1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 03:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfJNDGa (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 23:06:30 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:33123 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfJNDGa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 23:06:30 -0400
Received: by mail-qk1-f173.google.com with SMTP id x134so14664037qkb.0
        for <git@vger.kernel.org>; Sun, 13 Oct 2019 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uwhNwL3s/Pb0M+v6noCMpoSd7FgOjZLQcG+Y0an48VU=;
        b=JGjD4sWsPaushgyPAjS4lRX2gknydTFFQJNzbDzKPDAHqU9dpkzVSfGhExAjXGvifG
         OmJvsdgBf9JTHK0FAz9NuP/YC8XrsM6ndBCrIIO0PnLCh3BV/XXtn6631shgVDgbXKC2
         2SNHkPXYtjKGp4hekBd2KJ1A+h/cTvEdcK/XOU/TVZjGVfeCicnAll1/REoASUPKoDTo
         6BfmG/5qaed3WhfXp2JogJ7BKuOmAsn+YwgIVKkVHzAmRqJ894OIYGgLczABGMzyNqtp
         rAo9yMOfe1yUCfiAE7XT1Pi637vzL+J5nmVQv9UqK52Zs7B+O0pJRJMTuguTFRFP1TIk
         8xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uwhNwL3s/Pb0M+v6noCMpoSd7FgOjZLQcG+Y0an48VU=;
        b=D2/qjZxdu8Lh0kZGZszT030ogRqY92+1da40eTZiRElZ2Bn/0W+qrJkbpzoHsRuoB3
         HJQQbjMp/0QUwu/jUMdt44REeml7KB6E+AbpykpfQz9WaWkaxeYTfjxbbvsyhQA/bdr4
         cH1LZiwvyREmw31F6xxqfv0FrSfn9+qfjRB4j9TTMpeRcSRd0WHYNExwzBuaJJyhUF6B
         zkWbS/pMBUNIIsxTQpokmGUqZZSDqUfCIkAJZy6XnLAgcou/Ye8e4h4v4HZd1TVbYW8g
         bUEI3W9kVUVjEF57/cLhRXMzNvZj7EE67P1BX8QuwtsP+X7HoMHDNI1NYQpj/5TLl3mP
         OrVA==
X-Gm-Message-State: APjAAAU4mVy1uvDe4BTuvlIONxTIpBi2/8/VK98WfnJEvwt0FN9NpXFf
        818Jq5SSm0A6uSgmIXfKPrepyjNgGY7Y7Z9UK4I=
X-Google-Smtp-Source: APXvYqxxE1QAeD0NvFW5LHO7Xcd89XT+X8EUcJYNT6dIwWv7enM8rSlwYz/+otIf4IllJg7pCBn/asLLQrkzQ+oZHAg=
X-Received: by 2002:a05:620a:74f:: with SMTP id i15mr28917156qki.265.1571022389006;
 Sun, 13 Oct 2019 20:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <f5eba6e8-b51a-d1a0-0d8f-0aed76d803c9@naver.com> <CANYiYbF3T=1e-ro5mOBWYjhvRWyr8--mZCa8JQMoPB52w505vQ@mail.gmail.com>
In-Reply-To: <CANYiYbF3T=1e-ro5mOBWYjhvRWyr8--mZCa8JQMoPB52w505vQ@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 14 Oct 2019 11:06:17 +0800
Message-ID: <CANYiYbENRdOeniOZo69xXkace8QhhyvNTsL+4YoVe4wRSkNokQ@mail.gmail.com>
Subject: Re: Is GIT GUI still in progress?
To:     =?UTF-8?B?6rmA6rG07Jqw?= <rlarjsdn122@naver.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> =EA=B9=80=EA=B1=B4=EC=9A=B0 <rlarjsdn122@naver.com> =E4=BA=8E2019=E5=B9=
=B410=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:02=E5=86=
=99=E9=81=93=EF=BC=9A
> >
> > Hello.
> >
> > I have a question whether the GIT GUI project still in progress or not
> > because I want to contribute to translating GIT GUI into Korean. I aske=
d
> > prati0100 who is a maintainer of GIT GUI on
> > Github(https://github.com/prati0100/git-gui), but he doesn't know the
> > project is on.
> > If the project is in progress, please reply this E-mail with how to
> > contribute the GIT GUI for translation.
> >
> > Thank you.
> >
> > --
> > Signed-off-by: Kim Geonwoo (=EA=B9=80=EA=B1=B4=EC=9A=B0)<rlarjsdn122@na=
ver.com>
> >
>
> Git GUI is a stand-alone project which is periodically merged to Git
> project by a subtree merge. According to the latest
> SubmittingPatches[1] documentation, git-gui is managed by Pratyush
> Yadav in a separate project[2].
>
> As a separate  project, the git-l10n project will merge l10n

Typo: s/git-l10n/git-gui/

> contributions into itself and then merge them to Git as a whole
> through a subtree merge. As what README.md[3] of git-gui says,
> contributing to git-gui should using mailing list. This means l10n
> contributors for git-gui, have to use git-format-patch and git
> send-email commands to send patches to the mailing list, which is
> inconvenience for git-gui l10n contributors. I suppose using a
> dedicate git-guil l10n coordinator repository or simply using pull
> requests of "prati0100/git-gui" as the l10n contribution workflow,
> @Yadav.
>
> [1] https://github.com/git/git/blob/master/Documentation/SubmittingPatche=
s#L375
> [2] https://github.com/prati0100/git-gui
> [3] https://github.com/prati0100/git-gui/blob/master/README.md
