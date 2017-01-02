Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6A6205F4
	for <e@80x24.org>; Mon,  2 Jan 2017 16:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbdABQNU (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:13:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:58373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755748AbdABQNT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 11:13:19 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8Nik-1cjaQM3wbC-00vxUI; Mon, 02
 Jan 2017 17:13:13 +0100
Date:   Mon, 2 Jan 2017 17:12:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Paul Sbarra <sbarra.paul@gmail.com>
cc:     davvid@gmail.com, dennis@kaarsemaker.net, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: builtin difftool parsing issue
In-Reply-To: <CAGf+dShpkPvsC8wQN6mWmYeMZ3=i-ZOzDNSM1aa0rinKW6+-+g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701021712010.3469@virtualbox>
References: <CAGf+dShpkPvsC8wQN6mWmYeMZ3=i-ZOzDNSM1aa0rinKW6+-+g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:w0uQTaX8sMXSEn2BZe9KqLA6dlFsRsbPSBOIOLU8TdFWFjUYRGk
 4Clinrx9V3kD+pTKYsLnbVfKhGnCKns54Qst77DBVT5mICUJFJZLIK4I993MNCmykmTOWOB
 ueaxgqG4qj5dJq+029Dqblyn/BQXEMyGm+EurpYHgGPk4kroqPQVsz/7Grcv8h1Pi54PGIV
 EZjM5z6dl/6lDjmbg9zMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YXalrxh0WLU=:NuIrV70CC4xPf+nCFM9yWM
 /AWasAfoS79L4oWKEJPHRnB1zeNfZdgjA30nm7qEtQ7MJVCDPKH3KMcNXefJG205N22XulClZ
 lQPW4WxQpQ3X9fPA+mNevswf+ogGBk8Ob40FcBqU3QhjTa/B0MRDbJqwEtJRqzmG8I2Ir6xes
 2g5KL5NSaTYnLu1XEnDrbqpuWkoxpFXTH1sumtYezNPj08DYXohOtA/x6yQOuJ9/1RFglbb7s
 eeIU7taNIcplgG7KADJX2kKB6D/rwhOY71ik51rPIb8EiqLh6oBe8QjqNZ5pHgUwh7kk8zAx8
 iQ7jXfeWSj9xOz2BUvqTbETcJ4aXpPhTO2yUyCQnMyTqbnGp84f36cu22LjlX2YptZkPaR1Z5
 +qS/JvI9s0ZAmTfdiVJPGeEzQfkdZRpLTbrSlaWQLvyeGc6+G+kTz2sWdtVymAglrjw4ZUb0M
 v/S39mok6XCYDvjXlfqKqiaZK23x2+lmNZH32KDUWw4JZPaVtoHHuPwWZNsXnX+J/9pGBqLa9
 YkEWTJ8pLfKkaUWLBoJ6yIrFqaNwbxoiV66jFt1hAWvjCzdqyyJKaQQDFPgumnvxO9Grqpal4
 cvhpm/YruVqFYnogYn/uBTRTPAH7DTOgG+bPXCFMZcU3RGo9kysngllQXcNkoN/aOgdWDOjy9
 SNJNU6TYgO50F2d9ZGRib9ZrKO6m0qR6nJKLly/dUKo1FjnD4JjP2Z4oiPeRN44qLBInsjoiZ
 y4UBdatmxKkHLgx1VXvxCw/wwTm664CmUcjeKrHoKguJ8hntsS3afXd7Dp2ldd3pyOLx/dcQN
 Sz/P9PW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Wed, 21 Dec 2016, Paul Sbarra wrote:

> Sadly, I haven't been able to figure out how to get the mbox file from
> this tread into gmail, but wanted to report a parsing issue I've found
> with the builtin difftool.
> 
> Original Patch:
> https://public-inbox.org/git/ac91e4818cfb5c5af6b5874662dbeb61cde1f69d.1480019834.git.johannes.schindelin@gmx.de/#t
> 
> > + *status = *++p;
> > + if (!status || p[1])
> > + return error("unexpected trailer: '%s'", p);
> > + return 0;
> 
> The p[1] null check assumes the status is only one character long, but
> git-diff's raw output format shows that a numeric value can follow in
> the copy-edit and rename-edit cases.

Thank you for the report! I fixed it locally.

> I'm looking forward to seeing the builtin difftool land.  I came across it
> while investigating adding --submodule=diff (expanding on diff's
> recent addition) support and this looks more promising then the perl
> script.  Hopefully I will make some progress.  Any tips/pointers would
> be greatly appreciated.

I would have expected `git difftool --submodule=diff ...` to work... What
are the problems?

Ciao,
Johannes
