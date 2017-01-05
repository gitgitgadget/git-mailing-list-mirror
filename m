Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5751FEB3
	for <e@80x24.org>; Thu,  5 Jan 2017 10:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938301AbdAEKFx (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 05:05:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34917 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938290AbdAEKFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 05:05:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so70229880wml.2
        for <git@vger.kernel.org>; Thu, 05 Jan 2017 02:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8c0+7KOkyhgXa3spfya0QM/viwD5jsT1v9G39ChGeWA=;
        b=gH/kifaVrV99G/EcMVwMphd9MyyWr+P2H4z3C5/9ITcXEK6flFtwSiLzslXbbUUVEa
         rQg73bgdj/nrYzIIHu227osZEPDWzJny0uj20xZ7FqLX016lU35WTKLjOaKIMUSsLi4p
         +N3h6QgvNacDLXTCsmn8cw2okyjWrxVoyKrPIKQfQaOVGH2Wzilbu05Tlc8jDRfv4/0L
         Oaxf67pFxCPDSVSgS76oeeUg5xHTwusztZrcK08Hb0X9BJ6Oti0JVvu5s8OQkjk9R1lR
         p9/KvqQqOvMoy8Q7/0Bzt2avlROcliSsF73ogBZw/LnEXyeBv50cFUWcoY7bcSBgwhZF
         gaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8c0+7KOkyhgXa3spfya0QM/viwD5jsT1v9G39ChGeWA=;
        b=rpbhTSRONW84479qX8Kd6mh/14JjsVvfz1p9eVELCkxAtt2gcKoC8KzPW3Fv88r96N
         XhUgZyRwtGebDatKI/pY7bFfIKSqT52K59ohO4Kxh8xjZ7bZe3nHDHPD4c2BvfbYw9LW
         /78WTl139aNBL6nCRw8X1vEGK0o9qsSk5AWwe/ufFZtQ1qqPsVxlegjqTdM3NjtSVG5z
         YHZBxfiLvNfrR6CbmjvNnoR/eVuujMGxCfE9MH8t80/TyE8EZOuKCUllqOSUMjkxK81p
         lUPNOl5HXHbIxTG7PDgeDotxkI3zA0rhE5vX/NzUCL3sAf+NrREoDrRYQUj972llNW69
         72zg==
X-Gm-Message-State: AIkVDXIxMPYZo2JgP8A5qNPN/17/yFJD1rUpH9cTNdltQSsmFGnf4AIv6o/SDxQOJvdWTQ==
X-Received: by 10.28.158.82 with SMTP id h79mr58868134wme.19.1483610732071;
        Thu, 05 Jan 2017 02:05:32 -0800 (PST)
Received: from ore1x2cyy1.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id f126sm99147594wme.22.2017.01.05.02.05.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jan 2017 02:05:31 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by `asciidoctor`
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
Date:   Thu, 5 Jan 2017 11:05:29 +0100
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <1D7C66EA-E87A-4154-ACAC-8045D28477D2@gmail.com>
References: <cover.1483373021.git.johannes.schindelin@gmx.de> <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de> <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Jan 2017, at 09:08, Jeff King <peff@peff.net> wrote:
> 
> On Mon, Jan 02, 2017 at 05:03:57PM +0100, Johannes Schindelin wrote:
> 
>> From: =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>
>> 
>> The `user-manual.txt` is designed as a `book` but the `Makefile` wants
>> to build it as an `article`. This seems to be a problem when building
>> the documentation with `asciidoctor`. Furthermore the parts *Git
>> Glossary* and *Appendix B* had no subsections which is not allowed when
>> building with `asciidoctor`. So lets add a *dummy* section.
> 
> The git-scm.com site uses asciidoctor, too, and I think I have seen some
> oddness with the rendering though. So in general I am in favor of making
> things work under both asciidoc and asciidoctor.

I am not familiar with both tools but it sounds to me as if "asciidoctor"
is kind of the "lowest common denominator". Is this true? If yes, would it
make sense to switch TravisCI [1] to asciidocter if this change gets merged?

- Lars

[1] https://github.com/git/git/blob/master/.travis.yml#L48

