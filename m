Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFCBF202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 17:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbdJYRE1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 13:04:27 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:52384 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbdJYRE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 13:04:26 -0400
Received: by mail-wr0-f169.google.com with SMTP id k62so675668wrc.9
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F2ynmMvik9GEupfIUCe65kMe9jSXt03Z85fvxN8firU=;
        b=aj8O2dIY5s1b2gANAqWvIF7eJ1wZyqFnCo740WEQr+cods1YIYEztXUMdRTomSdICL
         kJxxLl9nXdFQozJOQFKYfWLiAyZ+kWeKqa/QBbuejNrsiaQO5imoWwsj7ytgH6gq3wZ0
         zeEKCSbpW0kHeoGMQdF1ajK0UOXlZ72cfGA8SwaGPOZtmRugmcHKD6a6vpRmozzUNbLg
         dtenJYuQTY/qP0RnVvQts7+iB2OVRx0NFNTxt3yUMrNdcRXJ4/HP9FJ/UPp0oi+Z4X0a
         h5OUE2tY4vruTLEW1HuaHXuO9oKAkIYW4OGYKWA/K0c/DqFIl9YuxUo0qSd5qNdBDypG
         sKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F2ynmMvik9GEupfIUCe65kMe9jSXt03Z85fvxN8firU=;
        b=VWhPD4RgppcD/kwBA4PcKYT11fwtGSp69tRwo9uRwZEM2W2NHtLhG/uTqqnbOYN4VR
         dt7SWN/qIsOdZghREld2J4min4CIuI9K/4hR0xtSqG7VfOpt0I2zyte+uxbIJz9sdSBp
         QtYbGIFd2uBK/lCQ5b8Pg+fcXEM4UXv1MmwAlvWKi5HwDwnmTuAAYRF9ngcjPqDrkNIz
         wzsp93tTwsfb+denDlfeZZneUtB417UvFRUQkImBWUcrNQomV2cBvG4ZynEAeYjeDva+
         omwvvbYJ4uCKIYeCNHSjSfM7GgZDEIPxA9bsBmrownKtRbzyMo4iBfALVyRsr8a9+lZO
         z1Og==
X-Gm-Message-State: AMCzsaWSq/NsCaVLl0bOLKXZSUyS8/wYJYyweVeL3ayoFLpqabBUuZYQ
        0f8WOaGA8Yq9WkvxX/5cqU6Xw/Yw
X-Google-Smtp-Source: ABhQp+TNwFqy7Zd96Y+pLFilRTwkDelGrlxn8PRV5tVs4EJEBnJlg5FO3oF3KakBiZBGA87+yAtyDw==
X-Received: by 10.223.134.106 with SMTP id 39mr2840338wrw.134.1508951065251;
        Wed, 25 Oct 2017 10:04:25 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v28sm2484122wra.14.2017.10.25.10.04.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 10:04:24 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Consequences of CRLF in index?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
Date:   Wed, 25 Oct 2017 19:04:23 +0200
Cc:     git <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <07309D89-F536-4DA8-9214-B605007845C6@gmail.com>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com> <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Oct 2017, at 20:14, Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
> Hi,
>=20
> Lars Schneider wrote:
>=20
>> I've migrated a large repo (110k+ files) with a lot of history (177k =
commits)
>> and a lot of users (200+) to Git. Unfortunately, all text files in =
the index
>> of the repo have CRLF line endings. In general this seems not to be a =
problem
>> as the project is developed exclusively on Windows.
>=20
> Sounds good.
>=20
>> However, I wonder if there are any "hidden consequences" of this =
setup?
>> If there are consequences, then I see two options. Either I rebase =
the repo
>> and fix the line endings for all commits or I add a single commit =
that fixes
>> the line endings for all files. Both actions require coordination =
with the
>> users to avoid repo trouble/merge conflicts. The "single fixup =
commit" options
>> would also make diffs into the past look bad. Would a single large =
commit have
>> any impact on the performance of standard Git operations?
>=20
> There are no hidden consequences that I'm aware of.  If you later
> decide that you want to become a cross-platform project, then you may
> want to switch to LF endings, in which case I suggest the "single
> fixup commit" strategy.
>=20
> In any event, you also probably want to declare what you're doing
> using .gitattributes.  By checking in the files as CRLF, you are
> declaring that you do *not* want Git to treat them as text files
> (i.e., you do not want Git to change the line endings), so something
> as simple as
>=20
> 	* -text

That's sounds good. Does "-text" have any other implications?
For whatever reason I always thought this is the way to tell
Git that a particular file is binary with the implication that
Git should not attempt to diff it.

Thanks,
Lars=
