Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8088E200B9
	for <e@80x24.org>; Mon,  7 May 2018 03:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeEGDhJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 23:37:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39967 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeEGDhI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 23:37:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id v60-v6so26975390wrc.7
        for <git@vger.kernel.org>; Sun, 06 May 2018 20:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5RMHsshGojm0SYI0Y/Z+1/KjN/HINMY6sCT77qYfcOE=;
        b=VfgBkXh5EWJpD8hel4MrzJdHidjbh9jBePSVPosr5ZKpQtgTCBiq7iaom1nhDaRwR6
         Hv9pxkueAD2w6316i5CH6GmR1wYPOIWfL5HQLLOiTEFucfUNCu9Uxe1aapIpAJCjJR8a
         3LAyQCpvP1lIUWdWhIG0Z0zN+/Zv13qcE+pz5XeGyu9MuN1Z74G/lQa6rnRr1z04gmEj
         KoNOSB5aSvyJsMiFJssmmquvlkFHozJN91BPQkSibRMYZWGTyUTfoDr+kyzrf4GqxEwQ
         vHRKsXFWIz3uCziTd4NUmk0oXjFntUmsiusqSNR1f9JYKM3NRXr65yEyHIqKtu158w2z
         qbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5RMHsshGojm0SYI0Y/Z+1/KjN/HINMY6sCT77qYfcOE=;
        b=rgs/Spvx6qwnT81QRO7hsSKox5cFFw2wkzR+dKJ7q17Pt/NeWOECe8k3ngrNZYjlLg
         ZZBSRgnluvZeRAMHAuSe1IPPHkmpAQvwB6RhznLF6AVdas9WIm6+GWeGivkMZO1ZwlfV
         j19x/I4XjDcyE22CnKdADGj+E7/8oDGfvEyX/GkRhx7P4ZyH3QtmO5q+7hOARxqYYHKK
         szca8YDXrGvhg/+jd17/lLkDR8R7zutiWA6t1inE8eSHo2JNEYXKAvF97Lu/eN0gR+Nl
         zPJ/QpvssFHHzUFWnbdrUaU4RK4Jley2g720Tu7vE1Y5UPcqlEJq0H8JhjvOZxXwfjEf
         EGAQ==
X-Gm-Message-State: ALQs6tBtXHm9mE8uTuO+AdSEwoLA3QNrlW+zGEm+bAellswYNZ35FRcl
        qRAmoZU87fXFU4DIPqW3TE/qdRkk
X-Google-Smtp-Source: AB8JxZpRc+0vdX0VSqyEe1chEJuSS4fJdwsuWnkSTh8sjuBwqHS6AcKFrUiez3l2FJgVnPaQ/Tb33g==
X-Received: by 2002:adf:a970:: with SMTP id u103-v6mr26763433wrc.71.1525664227527;
        Sun, 06 May 2018 20:37:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q7-v6sm25183302wrf.49.2018.05.06.20.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 20:37:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailmap: update brian m. carlson's email address
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
Date:   Mon, 07 May 2018 12:37:05 +0900
In-Reply-To: <20180506232421.975789-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 6 May 2018 23:24:21 +0000")
Message-ID: <xmqqa7tcqgpq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The order of addresses in the mailmap file was reversed, leading to git
> preferring the crustytoothpaste.ath.cx address, which is obsolete, over
> the crustytoothpaste.net address, which is current.  Switch the order of
> the addresses so that git log displays the correct address.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

I initially reacted to "was reversed" with "yikes, did we break the
mailmap reader and we need to update the file?", but apparently that
is not what this patch is about.  I think what is happening here is
that cdb6b5ac (".mailmap: Combine more (name, email) to individual
persons", 2013-08-12) removed

-Brian M. Carlson <sandals@crustytoothpaste.ath.cx>

and then added these two lines

+brian m. carlson <sandals@crustytoothpaste.ath.cx> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
+brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>

where *.net address did not come from any other entry for you in the
file.  I guess the author of the patch saw that you were sending
your messages from the .net address and tried to help by unifying
the two addresses, without knowing your preference and recorded two
reversed entries.

Will queue as-is for now, but if you want to update the log message
I do not mind taking a reroll.

Thanks.


>  .mailmap | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 7c71e88ea5..df7cf6313c 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -25,8 +25,8 @@ Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
>  Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
>  Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
>  Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
> -brian m. carlson <sandals@crustytoothpaste.ath.cx> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
> -brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>
> +brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
> +brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
>  Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
>  Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
>  Cheng Renquan <crquan@gmail.com>
