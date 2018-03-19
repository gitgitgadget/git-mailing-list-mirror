Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3621FAE2
	for <e@80x24.org>; Mon, 19 Mar 2018 00:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbeCSAeK (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 20:34:10 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34964 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754425AbeCSAeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 20:34:09 -0400
Received: by mail-io0-f174.google.com with SMTP id e7so8219707iof.2
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 17:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ELN6nO6/TLbFh+YCqksiYuaUIBq4eF6bqavXzvhpPLk=;
        b=ihjxBLeOqc9tp2sO1SThhDjf8nkCDgj66X+7x2z+Ou53SqwOoPZlE37IcjdmKpZ4Xw
         wRQsEi5/xOzBZP8YMY4RXb+mHNhmdMETeNW14LcJnePgYRHlJarR3iTA5Y0L2xx2D0uo
         sQIWvHTrY2rV/iHyu+y4yO5M+TzOLz96JAGzvw8NM5aERr57nPS6mPBlhAsgmSHEmIV6
         J49sJITpD6Ny7QuSnHzRmRw++NI35nrm837E+LRQ4jfcRZseZ34f5I5TJfysDyuIZloo
         0EIpzIUzbNEYxXYoXlX6yvrSRME6mQHA7F6M34MGu6MHjV6HxYq8zfTIgw4ksozx/FiB
         LSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ELN6nO6/TLbFh+YCqksiYuaUIBq4eF6bqavXzvhpPLk=;
        b=gwOX7/jby7+hzROrYU6Wayh1nMTkNiYn/EOn/niUYycwxHMwJxvo5aCf9kuR44OX8T
         1Jwp3UtGPpIuhxKJZ7sEm1VMtuAqIkS4d3rbC5z3TAuOncbsTrRRItJP6oTYUVCTmEQP
         oqE/9xVmTsb17lxsgjP9SbwKQt4TiMMk0VxQfjrAjlbfdtMnSy6JhtBfjKLxbV4CdT72
         usBNpfBgjx/pRzOiesD9r1xojCAkkAjgIch7GBUWTNu5kgPIbKpxqRyDMrzOd8n5xZeq
         3yrJqwY1tQftqIeTH9YTlHcmQef/tjeW1+WyD/6b1+fgA3wHH3dI5pNdsdbBrNg3AHfh
         Rb+Q==
X-Gm-Message-State: AElRT7EBXtzgVP0lIG2rFfuKZzeNxeNmwqNXQstS3tZ3uVkq+QT4fnSC
        CfPdc5AOrUik1mEwUeSdKIp+QMx8zOxKp4M8XOY=
X-Google-Smtp-Source: AG47ELsLj7l43rAxfjOufWx1+IoySB+kVgyRWYsix83LVRCIN/AazpLh5o8Y2byvNudccZ+NiB5QzJgGNX1pKrbGLRs=
X-Received: by 10.107.93.20 with SMTP id r20mr9813029iob.53.1521419648168;
 Sun, 18 Mar 2018 17:34:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Sun, 18 Mar 2018 17:34:07 -0700 (PDT)
In-Reply-To: <CA+P7+xoL6TRP0NZJR7gQrVeLoQwK_1D_iDmG18Y=_i=U4uttgg@mail.gmail.com>
References: <CAP8UFD35QP0jwQ22jfUaNgo92o3vG8bV5n=iYnmn1ichxndphg@mail.gmail.com>
 <CA+P7+xoL6TRP0NZJR7gQrVeLoQwK_1D_iDmG18Y=_i=U4uttgg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 19 Mar 2018 01:34:07 +0100
Message-ID: <CAP8UFD0wWiivjzJ29-RPVyOxkmbFACXTwHLyPrMdsUsW__RsYQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 37
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        William Chia <wchia@gitlab.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 11:41 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
> I don't have a good summary yet, but I think a section about the
> discussion regarding the new recreate-merges and rebasing merges
> that's been on going might be useful?

Yeah sure, we would gladly accept a summary of this discussion.

> a lot of that discussion
> occurred prior to git-merge (tho it's been ongoing since then?).

If you want to take the latest discussions into account, the summary
could be either split into two parts, one for this edition and the
other one for the next edition. Or we could wait and have the whole
summary in the next edition.

Thanks,
Christian.
