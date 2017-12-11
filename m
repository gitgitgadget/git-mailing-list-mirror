Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1771F404
	for <e@80x24.org>; Mon, 11 Dec 2017 12:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbdLKMZn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 07:25:43 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40470 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdLKMZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 07:25:42 -0500
Received: by mail-wm0-f49.google.com with SMTP id f206so13703264wmf.5
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 04:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nZEn0OcdVtdjP4am5AnCkS9d1bXjb0KSNDJX36idVMA=;
        b=S6tpP0CZi5Dsoy5fnaPvd1S6RqAbUJ9JHddivttcKtAuPfu4TbQS+08KRz5LmsNPcy
         blz6jjxAwammJ4STXeNvl5+zrgfCRdYRJhqLg+fFujHrSR8o32nFzH0aLA4miaX36QvP
         xrXz0vpOind4sYYj2n3lpF/F2L9X1bxqZIiX5TkMGf4dyFM1lrDG7A32KxHJDVeSuN1F
         uRm1vLNcTssvjcYOz/6y7i/eB9WqK35gNcA0LUmkrUWNJFDjPPHj5j8ZU1A1arQLDsYt
         YhMr2iitvzIQoG9v5xa/z35J4ILWcFxXUBDyjsgd2cysXkW6Y4+v+6JnvrxLyUfofOjC
         npjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nZEn0OcdVtdjP4am5AnCkS9d1bXjb0KSNDJX36idVMA=;
        b=Wq8cHcjWJT7z7BCoX2n32s+1kX1vkVuF0ioBwdXh16HrpJCIesp7BSClaR/ahuLevU
         ZoobE12FN3X20th7aCgiPyEIGZDuhfu0WDegQkx1gOEMZbwuZjAscAjkIqUV+N0LiaCu
         NWA7PfITmGCAJgFO9DO2AkEdIIBiAq359ERLsuAU3YMrTxpjqpuS/1LMR8OYlKgrPxRd
         Rpazn3T3DH4Fn94IAavfMbTxUiHqinqucFSHKbH6KpK4GfUq4Ex4we2UgEDli9BjmrJJ
         AH7pAgrrwqzckqAouCbTUkXc7XSxtfhZeqFAoWusETlUaaF+zdl0G5nkqBJq1I5kF5Qv
         cDWw==
X-Gm-Message-State: AKGB3mJvjstm41/1qQxTZVlnp3KcpZjSFlQlrS/BoL6bob6in4k+SotN
        KKWNxuSeM1369RHM3k3nauAHfkl93tDx6KgIYag=
X-Google-Smtp-Source: ACJfBoukW+yr+VIBY9UHTKcZXASmYa443cVA6wuluDudpQjXYMOCoYyE95MlSjmhphx/o4vXP4LDL2UkgepEhhelpqI=
X-Received: by 10.80.181.83 with SMTP id z19mr897319edd.48.1512995141294; Mon,
 11 Dec 2017 04:25:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.184.113 with HTTP; Mon, 11 Dec 2017 04:25:40 -0800 (PST)
In-Reply-To: <0ABBA110-59E9-423C-9A8E-9CF4BE2C4CA9@gmail.com>
References: <0ABBA110-59E9-423C-9A8E-9CF4BE2C4CA9@gmail.com>
From:   Thomas Gummerer <t.gummerer@gmail.com>
Date:   Mon, 11 Dec 2017 12:25:40 +0000
Message-ID: <CALgYhfN4NiQsaBZBU8jj4XBd48BjdWcEUqJCZH-rkHF-8QbdLQ@mail.gmail.com>
Subject: Re: How to begin an error/die string? Upper- or lower-case letter?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 10:23 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> error() and die() messages seems to begin with upper-case and
> lower-case letters in the Git code base:
>
>   git grep 'error(_' | perl -nE 'say /.*error\(_\("(.).*/' | sort | uniq -c
>   git grep 'die(_' | perl -nE 'say /.*die\(_\("(.).*/' | sort | uniq -c
>
> Do we prefer one way over the other?

The coding guidelines mandate not capitalizing error messages:

    $ git grep -A6 "Error Messages" Documentation/CodingGuidelines
    Documentation/CodingGuidelines:Error Messages
    Documentation/CodingGuidelines-
    Documentation/CodingGuidelines- - Do not end error messages with a
full stop.
    Documentation/CodingGuidelines-
    Documentation/CodingGuidelines- - Do not capitalize ("unable to
open %s", not "Unable to open %s")
    Documentation/CodingGuidelines-
    Documentation/CodingGuidelines- - Say what the error is first
("cannot open %s", not "%s: cannot open")

I guess those that are capitalized are just leftovers from before
we had that guideline in place, or slipped through review.

> Thanks,
> Lars
>
