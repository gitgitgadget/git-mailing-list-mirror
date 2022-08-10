Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC20C25B08
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 13:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiHJNGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 09:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiHJNGo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 09:06:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EED6DFA3
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 06:06:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dc19so27537947ejb.12
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vHslwtu3OMnJglPK3f3sdDFzBQtx445TmX1Vlw3PHUo=;
        b=I9WlbiJmM/Z2bWMGTK41cxjIXF3EtdFNVw5eFghH+zBSfRdxrtl1bnFiwimClaKNHt
         RCyIzJXvBL8zRiXtQIADLlAfQyLAoGRi3FaTW/6h2LGUF9nbVubJaNlL/3SdWfGjxkd0
         EsTEY0Fbiping8pf1qE1xEDu/v7ephGbecRaOUPfQOMiqwUI/G6bvso+8Mp+Wkg8BCg1
         N0xKdP9AJtHMHvsIMoGalYhcY9yRgsKB6jdRivf4N6f+EcHDudc1ouh62P0loeHzNiB5
         JQmuhPvHn1ch1xbHjP6iav/HOcoqvhmyeCv2NfaoBDXhJaF95iIBdm11Drw8Roa9DVY2
         hPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vHslwtu3OMnJglPK3f3sdDFzBQtx445TmX1Vlw3PHUo=;
        b=WWE9masEIcJJ3xaEHHX7tJz0Bthxik8frYg7ueqhDYjxpd9uhFROahzxbDNzGyScf9
         LrIzdmBR4K86ldBEobFQ2lq/2nfLkhi9zmhw3wZZj/17bnYw5OZW24+FWduL/K3EksKv
         wYXpPHIu8jhiy5VdNT9MZ1xVZqmVetrNDHztp8aLoZbtae4YmBzF+IOWKNTbhX/N3C5T
         7wxtCzRXLNCKs6A0bRR4UCAX+eQPzuKi1h4Dmu4Tremic3OUOgNoCjxG0vqoj2OapfRL
         zIEOAxfpJkz/vGO5CQLvLcr/GICO+zKvitSpu4HyM1mCxz1zqHNWVcDqcYy8r/Otwzq3
         fG0g==
X-Gm-Message-State: ACgBeo292X4IeGuR53xz67gdaL9iL4xbCNwA4KGGKhF0JpD9Oi8eom3A
        evmSGp9a98Nrx32UK4NS38V3QUZWSJpZ+c8lr3w=
X-Google-Smtp-Source: AA6agR4bckisZLzeKDSusmyPyBmvEGKw3Xy/7yS/t0e/me4NJLCjHq+E79NGrSRdQqz3PA4qSL77WU1h7yCZ8yTVF3k=
X-Received: by 2002:a17:906:93e8:b0:730:9e5c:b45a with SMTP id
 yl8-20020a17090693e800b007309e5cb45amr19377163ejb.530.1660136801568; Wed, 10
 Aug 2022 06:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1304.git.git.1659387885711.gitgitgadget@gmail.com>
In-Reply-To: <pull.1304.git.git.1659387885711.gitgitgadget@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 10 Aug 2022 08:06:30 -0500
Message-ID: <CAMP44s2z1FC-3T0X39aT5WTq2aFGph_-iVz-yJtTN6VpG-qdzA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-reflog: remove unneeded \ from \{
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 1, 2022 at 4:04 PM Glen Choo via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Glen Choo <chooglen@google.com>
>
> There are some inconsistencies with how different asciidoc environments
> handle different combinations of "\{<>}", e.g. these results were
> observed with asciidoc on two different environments:
>
>   | Input     | Output (env A) | Output (env B)   | same/different |
>   |-----------+----------------+------------------+----------------|
>   | \{<foo>\} | {&lt;foo&gt;}  | \{&lt;foo&gt;}^M | different      |
>   | {<foo>}   | {&lt;foo&gt;}  | {&lt;foo&gt;}    | same           |
>   | \{<foo>}  | {&lt;foo&gt;}  | \{&lt;foo&gt;}^M | different      |
>   | \{foo\}   | {foo}          | {foo}            | same           |
>   | \{\}      | {}             | \{}^M            | different      |
>   | \{}       | {}             | {}               | same           |
>   | {\}       | {}             | {}               | same           |
>
> The only instance of this biting us is "@\{<specifier>\}" in
> Documentation/git-reflog.txt; all other combinations of "\{<>}" (e.g. in
> Documentation/revisions.txt) seem to render consistently.

So, I did some investigation. {} are used for attributes, if you do
{manversion} that will be replaced by the manversion attribute (which
we are setting), but if you do {foobar} (an attribute that doesn't
exist) different implementations will do different things, what you
should do is \{foobar} as that's how the documentation says you should
escape attributes [1].

In 552cecc214 (Teach "git reflog" a subcommand to delete single
entries, 2007-10-17) it was {specifier} which could have been an
attribute and thus should be quoted, but in 49cbad0edd (doc: express
grammar placeholders between angle brackets, 2021-11-06) it was
changed to {<specifier>} and that apparently cannot be an attribute,
so it should not be quoted.

We shouldn't be using verses for this kind of stuff though, since we
want the whole thing displayed as-is, it's better to use literal
blocks [2], but that's a bigger change.

For now it should be:

  @{<specifier>}

So the patch is correct. ACK.

Cheers.

[1] https://docs.asciidoctor.org/asciidoc/latest/attributes/reference-attributes/
[2] https://docs.asciidoctor.org/asciidoc/latest/verbatim/literal-blocks/

-- 
Felipe Contreras
