Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D171F453
	for <e@80x24.org>; Fri, 25 Jan 2019 19:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfAYTZy (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 14:25:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42958 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfAYTZx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 14:25:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so9304397lja.9
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 11:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=67wY4FTv0uskKxaBiigmWfRnJtSZuF1vcaWqB8QRzM8=;
        b=uouGemRIslME4tFU/uebY3oKLPreCIdmaGY1muts6IkkRwWdT/ufg/8jh1gE8Tl7GW
         GKNseWaS8WhD3DrVQfGe1jkzY+2ByCiBuGgdlXjVA8xXDufY03RV5PsQrZbOGJx2tRZU
         f7owi0Da9G+zJe16r5I4/gSyn3AAGY+KonFh4GjvuKgzTn0nFZpAgIEnD5UFl1hsrWOc
         0yInumzZWVUCz3NLjtlEq3PFoqsoKu8n0xoPb+foQAWApNM1Emr1pVG48gIkY24tbWOJ
         MLn3eVdhFTq4RZ4GEQf+6LPQT8aCNWM5Zc1GnxJcHjWOW4i4PaVlIiQO9u4AGOF2NNI1
         OgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=67wY4FTv0uskKxaBiigmWfRnJtSZuF1vcaWqB8QRzM8=;
        b=pvC7G3x43R6m8cBEbxzXLi9nNZhUmzOpNIg1E8Dtfw4sfz2A0JSTUAkMj0eQ5ZNsRY
         6zBSEh3hDRr9J+xD2FSMAq3R70mpxIroXvx4mUN0kOCwsE0Z6oc38nWS5yBAGCDyC3lx
         rnWPUBCkApWxgU7RK3RRM7IO42WWsXSpHComh/Ui8SSJxa1zBKVQyvfVjan9JrZBYgRf
         ijImo1aC3ZGMhRdxTK27gIRlkZcnAFrHgMavirztO7tQIXUN1IEtCNMLfv7Go2N6bc9A
         Dr/xpDQN2ZfJcKVON+4bqb1ho46zn4TREABy/U+VRv/v29MFHThhzJDKA8p5gVdJ4q4F
         wlTw==
X-Gm-Message-State: AJcUukfAY6xtab8sfpPPxY8jv7XBNFfsa6dq2kJCHAhmkO2GxiT/qXsW
        U6RwDEwZW4LSfRJIcGyWPEr4djwZjMeyUTN2ahI=
X-Google-Smtp-Source: ALg8bN5681wHLwd1LvVMixSX45chhraFdOYGs0W3byYrLgIgDQR0TI2+D2uDfabo+K88yT9dk9kYUPeA3j44UDrbb1w=
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr8726507lja.19.1548444351719;
 Fri, 25 Jan 2019 11:25:51 -0800 (PST)
MIME-Version: 1.0
References: <CAN0heSq0Nb-WdhDFpdwgjUMrkJNbviAtietn=B5nJg-rDgcR_g@mail.gmail.com>
 <cover.1548186510.git.martin.agren@gmail.com> <f8b021033b887923662eb9fa63f6df1677ebbbb5.1548186510.git.martin.agren@gmail.com>
 <20190123055704.GA19601@sigill.intra.peff.net> <20190124001450.GR423984@genre.crustytoothpaste.net>
In-Reply-To: <20190124001450.GR423984@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 25 Jan 2019 20:25:39 +0100
Message-ID: <CAN0heSr6ssaLc6kDdAzny=HxCtxfV8S0+CFJ9-HcU+O1tJ2=rQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] setup: fix memory leaks with `struct repository_format`
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 24 Jan 2019 at 01:15, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Wed, Jan 23, 2019 at 12:57:05AM -0500, Jeff King wrote:
> > > +void clear_repository_format(struct repository_format *format)
> > > +{
> > > +   string_list_clear(&format->unknown_extensions, 0);
> > > +   free(format->work_tree);
> > > +   free(format->partial_clone);
> > > +   *format = (struct repository_format)REPOSITORY_FORMAT_INIT;
> > > +}
> >
> > ...this uses that expression not as an initializer, but as a compound
> > literal. That's also C99, but AFAIK it's the first usage in our code
> > base. I don't know if it will cause problems or not.

> > Given how simple it is to fix if it turns out to be a problem, I'm OK
> > including it as a weather balloon.

Thanks for pointing out this potential problem.

> It's my understanding that MSVC doesn't support this construct. If we
> care about supporting MSVC, then we need to write it without the
> compound literal. MSVC doesn't support any C99 feature that is not also
> in C++, unfortunately.

Ok, better play it safe then. Thanks.

Martin
