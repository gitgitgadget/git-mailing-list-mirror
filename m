Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E582A20248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDCLfM (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40893 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCLfM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so8174568pgo.7
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vOz0kseDCoPULmD8N1pZkUuy2BdbvCNNcMp4r3mllQ8=;
        b=ut7ETbAyW3w8OB2XyqxCN9z5STjn3FNywTj/ptidHYutEgwt5nVPSCtMvSNdUjGekb
         k1JCcP+xQv8j+xt4jTgILHfziWuAMUb+YS2XNSw3wnO76wel573Jtzh633fZwIRm23G1
         1pLypHQcU4i9yKHp6A8Qx8V+YfUqFh366jyyxbVD4l/5fbQQlYzcgBaQJ2qS7Qz/7Puq
         J9UZIB4/hl4hxXjpKx765NyYnk6hFk72OUOtXq42tSEDcF4RwTteFQdH69nNlNO3HR44
         hfH0MVM7XmroLRehcYWRR+dlhNAGD6zXBFQpHveqVPzs1Urj5IV4fqPkmz+aiiDpDdOU
         +/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vOz0kseDCoPULmD8N1pZkUuy2BdbvCNNcMp4r3mllQ8=;
        b=tGfwIay6Y8XZ9w8dXxq+/w9G87/hM9XTZjK1iMzE/E/iU1bSIS3FeAy9Q+qtmipBYS
         JkEd+mU2/v0iSqyecaDhoHp4fZQ5T0i/i/xMdNZERa/FV52aUB7b4j9aWI/k1gMDWHFJ
         wnTKplcuImr7zFvvfbwv0pZStMcFKVAcHkq15G3gYpIJdUEt2TlGJsGC+qVhJJaWTwl+
         ro7UlJfmvd1u4pAspDECl5k8N1GuVhJlk0U32ZrJpbziIoJdxwhE/vSf3VQ1Z3Q9O5Zf
         Gpw82wwWG0A/Bkaavz04Sspq0c338owFP5TU/LvmYA3FtiqNygIXgmC7wpWjCdODj5Bu
         9u9Q==
X-Gm-Message-State: APjAAAVELnix8Y9kBQyaMo/dKG3Fwo89A0rSZMTD/ZsuF7+e+zIoX5E5
        gnnShgLQwXrBxfCawW3WvBHJ9SH8rIaXXDJnfyM=
X-Google-Smtp-Source: APXvYqxr/I5QvbGbYjzNr33SjABF+8wMCAHDwcklrJWH2vqZ7Mu3wHiJsVy23GRuPxhh8gy85gas573gS8QT9vzlKCA=
X-Received: by 2002:a63:6786:: with SMTP id b128mr62995597pgc.318.1554291311917;
 Wed, 03 Apr 2019 04:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190324215534.9495-1-szeder.dev@gmail.com> <20190329123520.27549-1-szeder.dev@gmail.com>
 <20190329123520.27549-6-szeder.dev@gmail.com> <20190329195246.GH32732@szeder.dev>
In-Reply-To: <20190329195246.GH32732@szeder.dev>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 3 Apr 2019 13:34:58 +0200
Message-ID: <CAN0heSrQrVQ+t3ZH1igU8zZLjjyhzZshFgarLcZOumWMBRN2Tg@mail.gmail.com>
Subject: Re: [PATCH v3.1 5/6] ci: stick with Asciidoctor v1.5.8 for now
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Fri, 29 Mar 2019 at 20:52, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrot=
e:
>
> On Fri, Mar 29, 2019 at 01:35:19PM +0100, SZEDER G=C3=A1bor wrote:
> > The release of Asciidoctor v2.0.0 two days ago broke our documentation
>
> Well, what happened "two days ago" when I sent v2 is now seven days
> ago...  Let's just say "recent" instead.
>
>
>   --- >8 ---
>
> Subject: ci: stick with Asciidoctor v1.5.8 for now

This was picked up as 28216d13f4 ("ci: stick with Asciidoctor v1.5.8 for
now", 2019-03-29) as part of sg/asciidoctor-in-ci. Actually, all of the
above is included, self-quote, scissors and all.
Martin
