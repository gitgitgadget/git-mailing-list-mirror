Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2981F404
	for <e@80x24.org>; Thu,  1 Mar 2018 18:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033899AbeCASYc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:24:32 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36222 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033770AbeCASYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:24:31 -0500
Received: by mail-qk0-f169.google.com with SMTP id d206so8761148qkb.3
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CuqeH3lQybD4KNZxZQlTFzVipZv5yZAtKfXuOZxamzg=;
        b=vef2TNUZeJuaOgLBYQZH2C0e0Ms+9Ev+18OikIA5Ov/rPQqX/IvPPzkztVjP+saIXs
         tTcLRQq0Im8h/NtNRfbuioi1nR5ew3LqyEXXugQfF0CJ2jQSVIkqIqgUj1AVmSf345Sa
         Gdxuk6CRVi8LBJstxFRf6itr0ilsiZCIvDUFFQF3VGytISKf49qvSAr1vK/zbRh5Y24Q
         u75NyDahOATF0j9oLxjPrKhDuFpmVRT3vMTb7dwZTkDzuozbmBXoJj+9iYdJiyHA8CFx
         zdd3SGd+a5dw0NCp77iiXOmMusXdb26T8VPT30zcemHUk5RPDACidvWxnU2/pIDL2+NP
         Undw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CuqeH3lQybD4KNZxZQlTFzVipZv5yZAtKfXuOZxamzg=;
        b=U/Eksw3W8cMuaVxR8peq/FXvoXyHSHGiXaevZcBV/GEpacza/st6lnKXrSmpYqblAi
         NUBG8LHhG9jPzeSbUKXjqnTsZpFBbu3iCTen6pC5PL6zBIlCkrsYmOI4QcgQw22PsPjX
         Kb97XrSGHU+0gZhDElFVIcnscklgTVvuIicXo+hPSbMLZ0OfXTcFrt5VV+LwUbYU3HCt
         pzOd99WBcyRn6+pxl4vRZPnPRfweK9tc9k5NjBdTKSEpDa7zLZHIRQgprrdCm0oBhSGg
         sfx3la7sjt3tXdw0pEraA/BnEIgIky9v15g5EynQldzSSNpGEOWcGZcOkWaung/InDec
         kt0g==
X-Gm-Message-State: AElRT7HIsuHPb71eE0gbQ6rxowcCZdrHaW62rbFA+R7YSCx0k/ShwS0s
        4dzZ9eJoN0hbKqaIeKCvSFijtl2pZbWgroOkSMY=
X-Google-Smtp-Source: AG47ELsD3NCQ9z0mdCWNGQR17Bgw8UO9i/jbQZimwBXUreuj/mtnw5OePfhTA98jYhdQUbvw8aUwH66db7Np6351QEE=
X-Received: by 10.55.132.67 with SMTP id g64mr4318277qkd.28.1519928670636;
 Thu, 01 Mar 2018 10:24:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Thu, 1 Mar 2018 10:24:30 -0800 (PST)
In-Reply-To: <20180301111907.17607-1-alban.gruin@gmail.com>
References: <20180228172906.30582-1-alban.gruin@gmail.com> <20180301111907.17607-1-alban.gruin@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Mar 2018 13:24:30 -0500
X-Google-Sender-Auth: lydhL1mbak8OWtnDr8QlE4MtXNM
Message-ID: <CAPig+cSPHa_A05iLBKUSr8dZcaOoEJ28TF+nAZzvQN2dQc6csw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] userdiff: add built-in pattern for golang
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 1, 2018 at 6:19 AM, Alban Gruin <alban.gruin@gmail.com> wrote:
> This adds xfuncname and word_regex patterns for golang, a quite
> popular programming language. It also includes test cases for the
> xfuncname regex (t4018) and updated documentation.
>
> The xfuncname regex finds functions, structs and interfaces.  Although
> the Go language prohibits the opening brace from being on its own
> line, the regex does not makes it mandatory, to be able to match
> `func` statements like this:
>
>     func foo(bar int,
>         baz int) {
>     }
>
> This is covered by the test case t4018/golang-long-func.

A possible suggested rewrite to make it flow a bit better and to
mention the loose whitespace matching:

    The xfuncname regex finds functions, structs and interfaces.
    Although the Go language prohibits the opening brace of a 'func'
    from being on its own line, the regex makes the brace optional so
    it can match function declarations wrapped over multiple lines
    (covered by new test case t4018/golang-long-func):

        func foo(bar int,
            baz int) {
        }

    Whitespace matching is also a bit lax in order to handle
    non-standard formatting of method declarations. For instance:

        func(x *X) foo() {

    versus typical 'gofmt' formatted:

        func (x *x) foo() {

(Not necessarily worth a re-roll; perhaps Junio can pick it up when
queueing if he considers it an improvement.)

Thanks.

> The word_regex pattern finds identifiers, integers, floats, complex
> numbers and operators, according to the go specification.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
