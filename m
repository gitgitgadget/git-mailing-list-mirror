Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC69820323
	for <e@80x24.org>; Sun, 19 Mar 2017 13:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbdCSNx2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 09:53:28 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37650 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdCSNx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 09:53:26 -0400
Received: by mail-it0-f49.google.com with SMTP id g138so70567628itb.0
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=k7X+LZ0mIathOsXhVP7KW332YNS+7ekqdLBalF2nmCs=;
        b=gCdlBdMAagjv5ejBcTq0KtMnVm4tUka2UkwqO5bED+eOLdnyykJt8Yo6nkR/cm+SvD
         wzYsprdI0xg5nZU+vxTQxQY2dKjVLG5PHxGe/40El0V8UQbJ7q1uXAW3uEtRcPp6aVYZ
         9lLAzrd/XiP9phvMkmGwOk4NBuLE2X6QUH5EhBQY735GikaJ2gtoI7Bp5LJm3hAGrqM/
         wLTu3jCrpy+L2u/ncOKKlr9L9cudsJQVN8I5kcgfjER02YMNbWtJI1EZrg23pBriQZjZ
         qqk65ZWtDswpXJZpZZNSKR3AZ+WWKTzmkAzWshQG3pxDUGdUmrhxlhqlYML/gySDHkml
         Dudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=k7X+LZ0mIathOsXhVP7KW332YNS+7ekqdLBalF2nmCs=;
        b=WZyTdEqcK+//Y1huOAu5wZmUlb+O9V77xNGa+ZmCDbtvXPwJOaYnFt6jxFim0qZhmd
         XCm0rBcQ6fjbSLLi8J6a0+IIpTS4NQqclK/YsQk6eOt3jLNIQETfCpsDFPEjRmMxyewT
         7TRsxGiN8rx/2U1eHYo63wxChWiNRLegbxAGWnwz/5I/AehRYBWpzI7aPEVshx8u3kdj
         7rOECj8Oxl9FiUrIn0R8n7L2+G2Om2DooFk6aFpA9o+t2w2qhl2EZ7YKRcMGEFooM+n2
         eKEGlEfMZSvY5/ioqFfaIWq9jCC8oMLcEuRAHnYnRrDgLH1yCGeyTUW6lcw7jaCSHWMz
         4TPA==
X-Gm-Message-State: AFeK/H0Z1Y7MszleMa/1Tl7wTKDMSsAqdAwsNGzjUUEpz2d03e+f8/xe8KcoTzF5Sy1Qqvv+vWdNr37HwQczdw==
X-Received: by 10.36.90.144 with SMTP id v138mr6565423ita.24.1489931034401;
 Sun, 19 Mar 2017 06:43:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sun, 19 Mar 2017 06:43:33 -0700 (PDT)
In-Reply-To: <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
 <vpqa88hlghm.fsf@anie.imag.fr> <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 19 Mar 2017 14:43:33 +0100
Message-ID: <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
Subject: Re: Add configuration options for some commonly used command-line options
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 2:18 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Mar 19, 2017 at 11:15:33AM +0100, Matthieu Moy wrote:
>> I think the main problem is indeed "stop the users from shooting
>> themselves in the foot". Many command-line options change the behavior
>> completely so allowing users to enable them by default means allowing
>> the users to change Git in such a way that scripts calling it are
>> broken.
>>
>> This also doesn't help when troublshouting an issue as these options are
>> typically something set once and for all and which you forget about.
>> This typically leads to discussion in Q&A forums like:
>>
>> A: Can you run "git foo"?
>> B: Here's the result: ...
>> A: I don't understand, I can't reproduce here.
>>
>> just because B has a CLI option enabled by default.
>>
>> This is the same reasoning that leads Git to forbid aliasing an existing
>> command to something else.
>>
>> OTOH, we already have almost "enable such or such option by default"
>> with aliases. People who always run "git am" with "-3" can write
>>
>> [alias]
>>         a3 = am -3
>>
>> and just run "git a3".

I can't find the E-Mail chain now but this has been discussed on-list
a while ago. I.e. having some getopt support to say for the push
command, that the --rebase option can also come from the config, i.e.
in this case the pull.rebase option.

IIRC the consensus was that such a facility would allow commands or
individual options to say "this command/option is configurable", thus
of course all plumbing utilities would be unconfigurable, but
porcelain scripts would be configurable by default, with some
exceptions.

> I tend to agree here.  At work, we have code that wants git status
> --porcelain to be empty.  If a user added -b to all of their git status
> calls (to make -s output more helpful), that would break a lot of
> tooling.  It's much better if they create an alias, since that doesn't
> affect automated tools.

With the caveat I noted above this would be a complete non-issue, i.e.
we'd just pass some option to the getopt for --porcelain which would
disable any other option slurping up its configuration from a config
file.

> I expect developers of things such as fugitive would dislike such a
> feature as well.  I get the impression our existing config file options
> already make life difficult enough.

I don't know if this is what Duy has in mind, but the facility I've
described is  purely an internal code reorganization issue. I.e. us
not having to write custom code for each bultin every time we want to
take an option from the command line || config.

It does make it *easier* to flag more options as "this is
configurable", but whether that flag is turned on for each
command/option is just something we could discuss on-list on a
case-by-case basis.
