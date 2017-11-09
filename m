Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946051F442
	for <e@80x24.org>; Thu,  9 Nov 2017 16:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbdKIQKa (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 11:10:30 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:55865 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbdKIQK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 11:10:28 -0500
Received: by mail-qt0-f181.google.com with SMTP id v41so8231397qtv.12
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 08:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Lzxdq/cCTJvlCanvY3z+plPBPtOl/KuWrb8F6h8cviQ=;
        b=bDvkZsx3160rd4Oj3z9BNwZ+IiRZtePYuTHCBG3RQnY4n0Bf0BDE34OlzQDJWp8Q7X
         x6U5zWja3BfB/lbVj83HpPXuQxojjUDcMT9/wQMlywAfwMADHpD9GJMdOlyJqkIHolEf
         kCyiGOoyJVZ7KygdU2LcobdQ4eV5Pp8TbHW/vgl1TW47C7I35vGS6a0mJRiI9POWEiGX
         +AfXVRwmYWLfYT7/en33eI31GeYJags0a3l/QSazPO62NyaFchC0frNASWxI8IrXoE0a
         5m8GwnlSEMehcx7kEyT0AfnzJRnm0TnEeSWqIfl84HA7+F+nF57jzxCQAdDhHqoEjQhu
         gQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Lzxdq/cCTJvlCanvY3z+plPBPtOl/KuWrb8F6h8cviQ=;
        b=Akqz3YGxNuyoSZSD5aHizdLpE2G3QnB9j8tTQ3MSxygE+CWQn9Ej2/N4ilkrKEPQ0b
         yFDgcEYEdNWKkVZuKGk0LPnxz/jv4oiqNtDHtflwRxbHoP+QNiDhUw+TnDMNxsppuK7R
         1d6kbJ5hzDN6SfN1EamvqG/SgYTk8wrOyGkCAarpt7Nh3cjd004d4ScwAyOON5MdBgVO
         wZ/9RhNtV7x4f7pHuDwlOuponmB2yQgDOwiOFAO0iNMDMGWg6n9c7WX2nZLr+aHaKiLZ
         SqwXHG9zd9Io1VA8DdF2qE8CEaJrr0fWe1PSWPyyZO0wrzjrN00u3GeeXwMiZStmYhnY
         KtNA==
X-Gm-Message-State: AJaThX7MRrNbY9EktpN64hIa1jVLn/Q1Jq0VWfI3zsf/f90WNbZfqORq
        39OVDXiyROzJULftGQjvczKwH3Py6bls4up+jgbMzg==
X-Google-Smtp-Source: AGs4zMY/CYRdWlLkF2kE6IT+glFe73TkuYPvRbk2kZKWNXLiZ5I/eqK29heVzAY6ZlJg6LKzHuEbZN/HEWXHU4OkomQ=
X-Received: by 10.200.56.83 with SMTP id r19mr1551251qtb.293.1510243828006;
 Thu, 09 Nov 2017 08:10:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Thu, 9 Nov 2017 08:10:27 -0800 (PST)
In-Reply-To: <20171109130826.52132-1-adam@dinwoodie.org>
References: <20171109124714.GH20681@dinwoodie.org> <20171109130826.52132-1-adam@dinwoodie.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 Nov 2017 11:10:27 -0500
X-Google-Sender-Auth: ZlDXjT3m-narMFBD8ZKePjSFh-c
Message-ID: <CAPig+cRADknKB7KxqcZVinwP9vmGh1tmUrySUND3hMTi7a+bag@mail.gmail.com>
Subject: Re: [PATCH v3] doc/SubmittingPatches: correct subject guidance
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 9, 2017 at 8:08 AM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> The examples and common practice for adding markers such as "RFC" or
> "v2" to the subject of patch emails is to have them within the same
> brackets as the "PATCH" text, not after the closing bracket.  Further,
> the practice of `git format-patch` and the like, as well as what appears
> to be the more common pratice on the mailing list, is to use "[RFC
> PATCH]", not "[PATCH/RFC]".
>
> Update the SubmittingPatches article to match, and to reference the
> `format-patch` helper arguments.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> @@ -184,21 +184,25 @@ lose tabs that way if you are not careful.
>  It is a common convention to prefix your subject line with
>  [PATCH].  This lets people easily distinguish patches from other
> -e-mail discussions.  Use of additional markers after PATCH and
> -the closing bracket to mark the nature of the patch is also
> -encouraged.  E.g. [PATCH/RFC] is often used when the patch is
> +e-mail discussions.  Use of markers in addition to PATCH within
> +the brackets to describe the nature of the patch is also
> +encouraged.  E.g. [RFC PATCH] is often used when the patch is
>  not ready to be applied but it is for discussion, [PATCH v2],

Not a new problem, but since you're here cleaning this up, the "not
ready to be applied but it is for discussion" makes for a clunky read.
Perhaps something roughly like:

    E.g. [RFC PATCH] is often used to indicate that a patch needs
    further discussion ("request for comments") before being
    accepted.

>  [PATCH v3] etc. are often seen when you are sending an update to
>  what you have previously sent.
>
> -"git format-patch" command follows the best current practice to
> +The "git format-patch" command follows the best current practice to
>  format the body of an e-mail message.  At the beginning of the
>  patch should come your commit message, ending with the
>  Signed-off-by: lines, and a line that consists of three dashes,
>  followed by the diffstat information and the patch itself.  If
>  you are forwarding a patch from somebody else, optionally, at
>  the beginning of the e-mail message just before the commit
>  message starts, you can put a "From: " line to name that person.
> +To change the bracketed text at the start of the subject, use
> +`git format-patch --subject-prefix=<text>`.  As a shortcut, you

This may be nit-picky, but it took a bit of thought for me to work out
what "bracketed text at the start of the subject" meant. I wonder if
it would be clearer just to spell it out:

    To change the default "[PATCH]" in the subject to "[<text>]", use
    `git format-patch --subject-prefix=<text>`.

> +can use `--rfc` instead of `--subject-prefix="RFC PATCH"`, or
> +`-v <n>` instead of `--subject-prefix="PATCH v<n>"`.

Overall, this is much easier to digest than the run-on sentence in v2. Thanks.
