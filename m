Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553B41F462
	for <e@80x24.org>; Sun,  2 Jun 2019 07:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFBH1g (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 03:27:36 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38855 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFBH1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 03:27:36 -0400
Received: by mail-ua1-f66.google.com with SMTP id j2so1511926uaq.5
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 00:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOsAbkjeu3T5BZicounraXrItw8D3fVXlEZoVEkja/c=;
        b=XEz/PxYYKx6eMnYYMURCqDVMZV6iMkv1iTZYwLpBiAPnGcQWbxNN/pIcWwBzgsN1wn
         7vgFpTKEMdm2GeCgQw2MbkK4CC/4kr4/JBSFyYlqb+hRwy6ygqh/xmI8/tCwnuJvu/G1
         6gXlUKmMof5pt2zUGjJzXVhxOJzZ9ofNHIRHE+8aeb4HeSsUAXFT2dHi9HApD19kA1yL
         W3DWxvRA9YRhI1xfFWpG6zF2g7JCujGS6NiEXl3OJJuEk87cdmPv5Hw72W9DeJAIfnA0
         EjzCqoiQLHM91wkifmdQ/BnjM/CJj7ipjgTpPDsIlVbubWJOpFWEv3QsV53/EWF52VWe
         pJww==
X-Gm-Message-State: APjAAAUurrTrBdMvJeJlq9XdZf6V+YNM/A+1ZS1WEiuTJX2885RDYUAq
        j3ZUlmdAyuoRQ/1aHKl05urpLJb97jWIFo3qLiEACA==
X-Google-Smtp-Source: APXvYqwgePj7ieK0XnTINUwAWa6kFANJDG1IPUmrQ+10UUSjN6vIvSCG03JRCBrYaHyi7hvD/P0SU5/DN124UdiBLeA=
X-Received: by 2002:ab0:67c3:: with SMTP id w3mr5594181uar.68.1559457244612;
 Sat, 01 Jun 2019 23:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190601201212.19165-1-zombieleetnca@gmail.com>
In-Reply-To: <20190601201212.19165-1-zombieleetnca@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 Jun 2019 02:33:54 -0400
Message-ID: <CAPig+cQ4+nCLfrh2s76_RbLuGCOt7C3xu9HoSQstAeB585vZBA@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: change 'The standard email format' to 'The
 standard date format'
To:     Victory Osikwemhe <zombieleetnca@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 1, 2019 at 4:12 PM Victory Osikwemhe
<zombieleetnca@gmail.com> wrote:
> The current content of date-formats.txt under the RFC 2822 section
> specifies 'The standard email format' whereas the format specified
> is a date format
>
> Signed-off-by: Victory Osikwemhe <zombieleetnca@gmail.com>
> ---
> diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
> @@ -14,7 +14,7 @@ Git internal format::
>  RFC 2822::
> -       The standard email format as described by RFC 2822, for example
> +       The standard date format as described by RFC 2822, for example
>         `Thu, 07 Apr 2005 22:13:13 +0200`.

Given that not everyone is going to know (or be motivated to discover)
that RFC 2822 is about email, I wonder if this change could make the
text even more self-describing by instead saying this:

    The standard email date format ...
