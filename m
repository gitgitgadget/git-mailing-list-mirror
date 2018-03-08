Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8425C1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 10:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755275AbeCHKWr (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 05:22:47 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:40032 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934059AbeCHKWp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 05:22:45 -0500
Received: by mail-qt0-f182.google.com with SMTP id y6so6148278qtm.7
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 02:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ASWzq3sWV71foYfmf18PM332BgKqXXpB7V7gVtQvYWw=;
        b=fimKb6TryVAP0N3Wt82ADV2hCINbGdQM4I0gXMgrOJR8APsvbFfa7HUM4UzvPvSTNo
         KJi+LuzcygLpHdiyf0jJoI603MVng0jhHZaS7yq4Qy93TBj/ner43+4Nryi4Vb2Xer7i
         HvMMphctxytJbGb8mbXlixlwjf0KYEvUMg+V76lWOrr0oXJJ5VSrDXb9oeOduirHaFSH
         1+xWdVGHjdBA7e39VMXa+xKBmN0TUzrNOuYdOufVLBGs/yo2j9c0yzl7SY3Ws9xHfmYA
         tE/VZB6vaJWqA1MXvdxBdHDqDF1Oa3KV75ehdX5rN8AHkUjYB959exlECV2moBCWePEe
         ezLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ASWzq3sWV71foYfmf18PM332BgKqXXpB7V7gVtQvYWw=;
        b=LGrfIgcZRWG4sfRcUHZDHnwPifqzKlt2+ZZUDtK1hinBtEbCiJ8h+Dy8JVGDJqL9Yr
         dzD3ataTEMN6bDJwMCsQjVNqXphUEKFPhdDYeffuKP0Aj0ixQxiiiaAP5Jiyl2IfBExq
         PwO+FZmaUKj+MrWh+CUrRrhnoVhrr5XmfZoBfpk8JR3y5vWoR2kOSanL0uBsRTV83GJu
         8zhs5NSy7XpQtCLyQ7v59NclN8SsjeP3uf+MahX1/SVYqwJFDyIaoND+0SP63It39EUc
         ufZK2q1y/Db6GXGatiBieYLJinx47nv5Fm0r6qj4XTUun5akUgl+2gh6MjsUS21nBRkn
         6L9g==
X-Gm-Message-State: AElRT7F+8XPm/0p0DMHHl3/fPIXzJg7g98egv7SOndMCtzrfKE7gnkQf
        DxO0g9GQCjjFqqiz+XR+yrnfSdVIbaaycQvmtVI=
X-Google-Smtp-Source: AG47ELsIXRWSLp7D9Q0xUITgYJh7fV9lF/q/gmD/Hh3dhWFlZQtSSw4ZhA23uvsQxaymPxbDO61u8GXh+KoXLYAXTJ0=
X-Received: by 10.200.12.198 with SMTP id o6mr38093810qti.246.1520504564401;
 Thu, 08 Mar 2018 02:22:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Thu, 8 Mar 2018 02:22:44 -0800 (PST)
In-Reply-To: <0102016205115067-f3cdd5f1-2d69-4464-a665-db3a28360260-000000@eu-west-1.amazonses.com>
References: <0102016205115067-f3cdd5f1-2d69-4464-a665-db3a28360260-000000@eu-west-1.amazonses.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Mar 2018 05:22:44 -0500
X-Google-Sender-Auth: TYz5frDJ3URl56aazK_RF-E3hDc
Message-ID: <CAPig+cTPMqf1hN-fsaAkdZwCEH94ZPYJbfSE_rcjFCoSobxK5Q@mail.gmail.com>
Subject: Re: [PATCH] userdiff.c: Add C# async keyword in diff pattern
To:     Thomas Levesque <thomas.levesque@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 5:04 AM, Thomas Levesque
<thomas.levesque@gmail.com> wrote:
> Currently C# async methods are not shown in diff hunk headers. I just
> added the async keyword to the csharp method pattern so that they are
> properly detected.

Thanks for the contribution. Please sign-off your patch (see
SubmittingPatches[1]).

[1]: https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L278

> ---
> diff --git a/userdiff.c b/userdiff.c
> index dbfb4e13cddce..b92caf42b27be 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -138,7 +138,7 @@ PATTERNS("csharp",
>          /* Keywords */
>          "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
>          /* Methods and constructors */
> -        "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
> +        "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>          /* Properties */
>          "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
>          /* Type definitions */
