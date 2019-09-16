Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0421F463
	for <e@80x24.org>; Mon, 16 Sep 2019 10:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfIPKsC (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 06:48:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41111 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfIPKsC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 06:48:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so1214961pfh.8
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ugBBNV38DUKDm0oZCB84etJ2Esj88C+7xjkjH2mV0k=;
        b=trmeeiYKISM4Zxkm/hSH99iW69btf9QPGf5eWwN7LHVrTxJpdXbHB14agemuQ371TZ
         wP5n0PiYGrIAGvUsQnx/ZbWAJDbLjwc/FuHVPEOM6N4dex7ESjVscOFeEKu5irC1FWJh
         m6PiS6xXlQyK26iVAsFQqwkrhOK4xMIHrZBKkCvch5EONajmqAcHYeCb9vbOa+p2Zx7i
         Mzm9WlOMh7ZvtBzY4n4MRhVUioxyABF+SbdSykYGNhkgdCjFWGfPHtE1ZApZIv2BCJYc
         V9SYWwaDpzxrsC9qKWn/qS12AMfy34tOHXkwBXji6F+8n2Xmj92ZnX3EBDBArpytAw8v
         npkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ugBBNV38DUKDm0oZCB84etJ2Esj88C+7xjkjH2mV0k=;
        b=hH9Bp/EFBi5c70hh81A+ZEA2OcIESv1JCw3CJ8yMlVLWgbkPNHha7q1UD91B8rF0U5
         +FH08bgLVK9jarLkfgGLye4aSezNejq2LD97X0//sVtSBfgRFs5W39IjL5ED8QmPHmDR
         bgDNtq99GAohPPFw+yv4a8H12RN+JNfa+g5R58XOTMzXJeo9jjAmV04xiWeKwOkjJSZr
         NFt6n/Zr4ZzK/uzMVYtQcHceOh9uq8vtOjmJtF7J9QKGaQ7pjy+mo1pSe5FdD7mhVuYp
         qQQ6hgLC8I1ZmPDHFLNtcz+coamkO+Oodl7GIW4FDE0EPLlibdKQbtqdBGDwckyKaUcg
         93Eg==
X-Gm-Message-State: APjAAAVDBBngu7zUIaCchE1BjxfjdRB3ey5aFZ24Yw8dud4MLMQ4cN39
        Pq7lkn5FGLA4nzoIL9QMMl1APxmtXSoFCAELHy2hjnRt
X-Google-Smtp-Source: APXvYqxaNi0ItQS1xwjkxVPYKxT5Tt3gK1Bp6ePPN3JacuMQm1RJiyg6IOcnlCIMaFRECvUvW54rAYr6CvAJrnKCZIc=
X-Received: by 2002:a65:4841:: with SMTP id i1mr55775171pgs.316.1568630881869;
 Mon, 16 Sep 2019 03:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190913015240.686522-1-sandals@crustytoothpaste.net> <20190913050634.GB21172@sigill.intra.peff.net>
In-Reply-To: <20190913050634.GB21172@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 16 Sep 2019 12:47:46 +0200
Message-ID: <CAN0heSqcKR_HV3jt2vVU2iafA77cqTyjFaTmiyXaHChmmUBhgg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: fix build with Asciidoctor 2
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Sep 2019 at 07:06, Jeff King <peff@peff.net> wrote:
>
> On Fri, Sep 13, 2019 at 01:52:40AM +0000, brian m. carlson wrote:
>
>
> >  Documentation/Makefile    | 4 +++-
> >  Documentation/manpage.xsl | 3 +++
> >  ci/test-documentation.sh  | 2 ++
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/manpage.xsl
>
> Running with this patch on asciidoctor 2.0.10, plus Martin's recent
> literal-block cleanups, plus his refmiscinfo fix, I get pretty decent
> output from:
>
>   ./doc-diff --from-asciidoc --to-asciidoctor origin HEAD
>
> The header/footer are still a little funny (but I think Martin said that
> he needs to update the refmiscinfo patches for later versions of
> asciidoctor, which is probably what's going on here):
>
>   --- a/f1d4a28250629ae469fc5dd59ab843cb2fd68e12-asciidoc/home/peff/share/man/man1/git-add.1
>   +++ b/6c08635fd1d38c83d3765ff05fabbfbd25ef4943-asciidoctor/home/peff/share/man/man1/git-add.1
>   @@ -1,4 +1,4 @@
>   -GIT-ADD(1)                        Git Manual                        GIT-ADD(1)
>   +GIT-ADD(1)                                                          GIT-ADD(1)
>
>    NAME
>           git-add - Add file contents to the index
>   @@ -356,4 +356,4 @@ SEE ALSO
>    GIT
>           Part of the git(1) suite
>
>   -Git omitted                       01/01/1970                        GIT-ADD(1)
>   +  omitted                         1970-01-01                        GIT-ADD(1)

Yeah, I should be able to post v3 of my refmiscinfo-series this evening,
which should fix this, so that the only difference that remains here is
how the date is formatted.

Martin
