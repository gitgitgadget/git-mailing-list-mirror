Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71D81F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeB1Sre (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:47:34 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:39816 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeB1Src (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:47:32 -0500
Received: by mail-qk0-f177.google.com with SMTP id z197so4308005qkb.6
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zsEZsDwUnf8pcKSBvth04B1esKMAajzHgwg1kAhwJvw=;
        b=uenO4WqlfPBhdxTO7p4wUiGQqLZh4rlva1J0wdU2n13TxGZjRPklWJqRF0x13h1KpS
         lBy3+Flhi57VdmpiMvrNdDwj2D+69qcCjDZiK0A6CwpvW0C/ovpzwLDOvUzTTNXATJnx
         cU9PpQFIwrYXLrEK9Cyy04hHGSAATU/11s76uAP5Ep5hm1ZjzG5cluzyQkh26tSpmtC8
         jLzQiNc4dU6fAtDeMRSmDeIgpy1PLLyvLVsZqVQOf03TvnndhZ8zEO7hlGRvmCatd7eo
         nmhterOKoFW+im90GvTUREIXqa0uBal6PYWXPkckdO+4OwLPuuVEAIYFN6h88QtJysnm
         e8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zsEZsDwUnf8pcKSBvth04B1esKMAajzHgwg1kAhwJvw=;
        b=RlKoLMV2HFZjW9ty17wA4HpwOIccfVq1VQJ5XpePkUHDISDzjP7PrxC4J9YYPIhn8L
         moiFkkEotoeXOoz1Rb4ZRFVkWcAB4hTjAywVrIqMwhRdlt3CH3x93yIZYpLihiL7MN13
         EtE81389CiqPG81wdzqZWhwxl6a7MpKavLDx3XGNNFRxON0resQ/SbCJfvRjgi/EvIXC
         rBjzkaK6XJpHaN9CeK2spRj1KP3jnGEy5rmBY5LelhWpvso04TVQ1AiJa9XX1Zul4V+u
         v9eYmYPL2cmSyCr+tVkkysXMVi75GnmKD4GvrJkZCuLmbEYTjEevs0k4jkZdmdtpL4b1
         bUZg==
X-Gm-Message-State: APf1xPAZF3IH0KJfQmZfklH8S8nmLz828ETct7VmYcSj9+IkiT9nahRT
        eZvbNL907ygoSgKGFdey6bz4t/yZmupJ1wLUw9M=
X-Google-Smtp-Source: AG47ELvaZAYOxcKpzN8cpyDC0UTfCaponNcXMPWs2SwJugKO8rwqqFlKw1NAVnUs3xilxUCCfzAvf4D1J5JOz/nxk1M=
X-Received: by 10.55.134.133 with SMTP id i127mr30246563qkd.275.1519843651981;
 Wed, 28 Feb 2018 10:47:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Wed, 28 Feb 2018 10:47:31 -0800 (PST)
In-Reply-To: <20180228172906.30582-1-alban.gruin@gmail.com>
References: <20180228172906.30582-1-alban.gruin@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Feb 2018 13:47:31 -0500
X-Google-Sender-Auth: kfc48XjX5nLck1m7HEiPEw-d90I
Message-ID: <CAPig+cTOv+jAQHA8p76MHcbbvv4SAs4y_1BxeRpexWwTT4+8hA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] userdiff: add built-in pattern for golang
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 12:29 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
> This adds xfuncname and word_regex patterns for golang, a quite
> popular programming language. It also includes test cases for the
> xfuncname regex (t4018) and an updated documentation.

s/an //

> The xfuncname regex finds functions, structs and interfaces. The
> word_regex pattern finds identifiers, integers, floats, complex
> numbers and operators, according to the go specification.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> diff --git a/t/t4018/golang-complex-function b/t/t4018/golang-complex-function
> @@ -0,0 +1,8 @@
> +func (t *Test) RIGHT(a Type) (Type, error) {
> +       t.a = a
> +        return ChangeMe, nil
> +}

Most of these files use a mix of spaces and tabs for indentation.
Please use tabs only.

> diff --git a/userdiff.c b/userdiff.c
> @@ -38,6 +38,15 @@ IPATTERN("fortran",
> +PATTERNS("golang",
> +        /* Functions */
> +        "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"

Why is the brace (and possible following whitespace) optional?
Considering that the language demands that the brace be on the same
line, I'd think the brace should be mandatory.

I suppose you made whitespace after 'func' optional to be able to
recognize a method (which hasn't been gofmt'd):

    func(x *X) name {

rather than the more typical:

    func (x *X) name {

I wonder if it would make sense to tighten the expression to recognize
functions and methods as distinct cases:

    function: mandatory whitespace following 'func'
    method: optional whitespace but mandatory '(' following 'func'

Your current expression could accidentally match:

    /*
      Fish like to have
      functors for lunch {
      just like eels}.
    */

but, even the suggested tighter expression could "accidentally" match
example code in a comment block anyhow, so I guess it probably doesn't
matter much in practice.

> +        /* Structs and interfaces */
> +        "^[ \t]*(type[ \t].*(struct|interface)[ \t]*(\\{[ \t]*)?)",

Whitespace is required after 'type'. Good. The language doesn't
require '{' to be on the same line as 'struct' or 'interface', and
this expression makes it optional. Okay.

> +        /* -- */
> +        "[a-zA-Z_][a-zA-Z0-9_]*"
> +        "|[-+0-9.eE]+i?|0[xX]?[0-9a-fA-F]+i?"
> +        "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&\\^=?|&&|\\|\\||<-|\\.{3}"),
