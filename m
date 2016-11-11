Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78952021E
	for <e@80x24.org>; Fri, 11 Nov 2016 08:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756054AbcKKI2a (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 03:28:30 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35369 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754473AbcKKI22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 03:28:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so7809279wme.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 00:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rd5dCmOHQF7+d5c9KqXGj529VczrbGONfZRllgILJYM=;
        b=Ai8OVMkAk2vimz9QOBadelMpXTbRO8zt3L171TssyTduPIhqHmS+apUjiVrgQEuDID
         VH63JjdPPJLCbkihgeJAfwwnaWfH6pdDnaICtYhAr/CORykHGCzewDrg8XZhRBow9yYe
         JqhxvJB2yniIfejyJ8hIMxBWFArflLp02ObBeutZnM7qqyEMNQ614znfZy0ICpp74f7O
         VXTG94WlrUvJMt4iYwh7b904JXBDIm2zAaUB6NJ7f/+p8Gu9GTJ2LavxgjHXBLSS46lq
         TduUF+mq6mZPCXrhRWsjtITmVivhWQzrRLbArrb79fLDSiILFz58hJc1fWltTGeI1eVA
         sqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rd5dCmOHQF7+d5c9KqXGj529VczrbGONfZRllgILJYM=;
        b=EMWFQk/V8/o7X/w+sz+oBtli+bSqQqHgPWCM6c2aVup5W/RfePcl8TAqM4TMZHXr1z
         xkHQiug2D1CP9LQWtcq33C4YHePP2SurYLiyipWVroA6mk2l8Jjh5Ii71E3xHDkMNB7Q
         Rj/ZiQy6G9k7kE36nawn7UrQyO4sXF3kYCCnMFvFmgT96vNIVmzP1cWbD1XgUJASREFY
         aC1y+pZFmESiITVJcBEgYLwOFAZCSb7KqojEEe3W8UTvuzIr0SS060+S0N5Znv2iTSzm
         KjTYSSoTmoEsjy9fLM+M43se9jp/C/X1ZJfaMla8yLrVlbONLhC8eZKM/M3o1hL6k42k
         d27Q==
X-Gm-Message-State: ABUngvdk1JLIszpOKjOsbl3NnTM3GaNZspvuX2mW1hr3WgWGeoeiF3zQG10kr8Q3iSjMFQ==
X-Received: by 10.28.5.207 with SMTP id 198mr24522923wmf.4.1478852907605;
        Fri, 11 Nov 2016 00:28:27 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4736.dip0.t-ipconnect.de. [93.219.71.54])
        by smtp.gmail.com with ESMTPSA id l2sm10031448wjy.39.2016.11.11.00.28.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 00:28:27 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [git-for-windows] [ANNOUNCE] Prerelease: Git for Windows v2.11.0-rc0
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1611102237230.24684@virtualbox>
Date:   Fri, 11 Nov 2016 09:28:25 +0100
Cc:     git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>, me@ttaylorr.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2B1E33E-3C31-45A3-8A5B-098A59CD399D@gmail.com>
References: <alpine.DEB.2.20.1611051025030.3108@virtualbox> <B2BEB5B4-5CF0-4CD7-A8E2-50D51E00D2FF@gmail.com> <alpine.DEB.2.20.1611102237230.24684@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10 Nov 2016, at 22:39, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:

> Hi Lars,
>=20
> On Wed, 9 Nov 2016, Lars Schneider wrote:
>=20
>> On 05 Nov 2016, at 10:50, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>>=20
>>> I finally got around to rebase the Windows-specific patches (which =
seem to
>>> not make it upstream as fast as we get new ones) on top of upstream =
Git
>>> v2.11.0-rc0, and to bundle installers, portable Git and MinGit =
[*1*]:
>>>=20
>>> =
https://github.com/git-for-windows/git/releases/tag/v2.11.0-rc0.windows.1
>>=20
>>=20
>> I tested a new feature in 2.11 on Windows today and it failed. After =
some=20
>> confusion I realized that the feature is not on your 2.11 branch.
>=20
> Oops. That must have been a major snafu on my side, very sorry for =
that.
>=20
> I just tagged v2.11.0-rc0.windows.2 in https://github.com/dscho/git =
and
> will make a new prerelease tomorrow.

No worries! I am looking forward to the new release!

For some reason my own build of Git for Windows cannot use HTTPS =
properly.
I need to debug this further at some point.

Thanks,
Lars

