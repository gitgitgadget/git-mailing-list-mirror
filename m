Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509DA1F42D
	for <e@80x24.org>; Wed, 30 May 2018 17:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeE3RyF (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 13:54:05 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:34188 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbeE3RyE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 13:54:04 -0400
Received: by mail-yb0-f173.google.com with SMTP id i1-v6so6665767ybe.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8djO1W/5o+x635BN7Ii7XpvCcgvdz8NFW0tJWA28M/s=;
        b=uNbO455syQ4e3EeYcgt/r2YgUo4XMkMbJIDDzy8AJdr3DboAgozTjBeeup19OYYaaK
         3do2Gcho0zlpo0HTfzTvcVJs81Iin54IvveXGensrr9GSgj3DFENBtmP7+Q9D6Q566Kx
         A0ENaZBsWQ7t50zLAukcqysl/kGuKomgTqCQ186xuqSk5r57hH7Lb0gzdgNx1fq5EuZf
         Fkm9QYqobwmaxmUdV+TDobpyMZJXk3rL0cQfliaS1rTTtN+2ofb8sB4ou3OB0jBF0pjx
         603lRmYAZZdj0t3s/PMiTXJxztmpsdjg0TzxE3BKeHS2j97L6F6ck8j3iMLXStBMsHmd
         286Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8djO1W/5o+x635BN7Ii7XpvCcgvdz8NFW0tJWA28M/s=;
        b=IzIxCUZuL8BTD87OzQWgovD+o0yfkPbKAV0LlmC5UlyaRVs9ZAN8N53EeCmwQV5Snn
         WWwqhkiJI+qATg3tvte2FoIxdxKe4WLCBdn5S/V5PDuhcuZJsZ2kvWaThWcL2RsluOGQ
         GxssTMyCTi1z+5b/ASCYzhHZKN0bD7ZZaZNwA4vEQxhWKyMuyYJvApiJNz2Z02qU8mUL
         842cUcKB38eV3fXleozQr1tQtKjRBOFu9FQPZKegK906faCoBWcybr/PPy341g/h8zQ0
         RQ9I2hGd4+GORBujxRZPuMO1uxpsfk8mWuweHGkoiMrWE72quqbbBDMdaUPRI9YeZmFk
         OaBg==
X-Gm-Message-State: ALKqPwfvM+MgXqubh325hdKHXPpZri9B92VrovC1Tg1TCBO3Ea2jpGxg
        7IYoBGfok9Q/s6sO5XWyDcZ5bScQ3PbL0zFXw2ehIEAOZNg=
X-Google-Smtp-Source: ADUXVKKE8nwq1U1ZaBUs0Qs9Enp1GSNgrdBSmyp/QRVRG15zIJuu9Bsz0okrKiUl8fV4gKJWvEJtJQmDxAeOihzL4tE=
X-Received: by 2002:a25:a526:: with SMTP id h35-v6mr2000226ybi.515.1527702843196;
 Wed, 30 May 2018 10:54:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 10:54:02 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805300733440.10096@localhost.localdomain>
References: <alpine.LFD.2.21.1805300733440.10096@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 10:54:02 -0700
Message-ID: <CAGZ79kbdbV8r6Vr06ECOy9XXnBO_r=F-XcQU3WCCtOuCr0cfiQ@mail.gmail.com>
Subject: Re: verifying syntax for optional and replaceable content in man pages
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 4:39 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   willing to submit some patches to standardize the syntax of man
> pages in terms of rendering "optional" and/or "replaceable" content,
> and it seems like "man git-config" would be a good place to start:
>
> SYNOPSIS
>        git config [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
>        git config [<file-option>] [type] --add name value
>        git config [<file-option>] [type] --replace-all name value [value_regex]
>        ...snip ...
>
>   can i assume the proper (uniform) syntax for the above would be
> (shortening lines):
>
>   ... [<type>] [--show-origin] [-z|--null] <name> [<value> [<value_regex>]]

So the difference are the angle brackets around 'name', otherwise no change?

>   ... [<type>] --add <name> <value>

all the same but angle brackets around name and value,

>   ... [<type>] --replace-all <name> <value> [<value_regex>]

same.

> and so on. is that the consensus? i wouldn't try to do it all at once,
> maybe just a page at a time to not be too disruptive.

I would think there is consensus for unifying the syntax across all man pages
and put variable texts (name, path, key, value, etc) into angle brackets.

I used git-blame to find all the changes throughout history touching
the first line
of the synopsis (or rather: I used gitk, right click "show origin of line"),
and there were no edit wars whether to use angle brackets or not; it looks like
nobody cared or paid attention since the first revision of that line, which is

    git-config' [--global] [type] name [value [value_regex]]

from e0d10e1c63b ([PATCH] Rename git-repo-config to git-config., 2007-01-28)

Thanks for taking care of these!
Stefan
