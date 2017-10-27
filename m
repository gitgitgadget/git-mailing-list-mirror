Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE6B1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 12:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbdJ0MLO (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 08:11:14 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:45534 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbdJ0MLM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 08:11:12 -0400
Received: by mail-wr0-f180.google.com with SMTP id y9so5986357wrb.2
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OweJvE+OeXkTg7uFDmRgySHQNCf2qPf/B5WWX3aP8Dw=;
        b=BbKloLw2dTpbWWJg0KMz4nmQw/bjMGpqR9TI6Hu1BwN0/seyJClZZq7teYI0YEsFBV
         b9MF+fYWe3zYVPEbeRZExYcLxELGap4XXE69eQHZLZp0jdKuOumhlSgXwqm3bHV+7ByL
         6GZwhcBOUQGdZbkVAf3EB8/dd5Ekcn41qWBzOYKwqbcgfty0c/yFMWOB8p+bBCMPk6Tj
         O+IzOxGBTlugLmUePS524xcYxvCVuUm2MrlCf2Ck7Iv1LWpxRSnfaA9MpyUGmm98EA0+
         XQCjGvvbV3oG8EOkD6F6GKgj1yGDQWXuCPDRt4Rrt4zIBZkqhHx/m2XWhV/rf4O5Aetk
         FqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OweJvE+OeXkTg7uFDmRgySHQNCf2qPf/B5WWX3aP8Dw=;
        b=ZomIL7d64gM2xr5xh1gfDJpa37Sh0UsBdXG+uez/MJtTWMc5/739C19uWA5eM6feZ8
         PyAIoAoHx3Ygc0lv2ed8cxw5jxllFyx5yPHKOLRt4LbAPk/Ixyia8vFOU63FFCS/ItqV
         p6Z/aSrBR/XTF0co0Xu3/F8GHthB+fzPakJFiX1W/LrEZnwQSUu8tC0JCr06kiwvAkHO
         yEmwNiQXyBXEY+R3yhKWpZcI2Ivm1imRIvhCh4GV0/lZLeNhLK5l/RISdEgY6K3GADO2
         l9EDcmSyKKLuYewnioqAfilWsXvkxVF8O+UZ4VsyeR/RuRGHKYYS6q+7CTOxn2239nrI
         HpTA==
X-Gm-Message-State: AMCzsaWOA4+9ifI0tULkqMGAvrUM+ZSXyG97lGW0fa+busOZPgMI0emq
        5mosaPRmAKyA8VnUs12JSmw=
X-Google-Smtp-Source: ABhQp+RsulBqVWAHMghUkgFRtFAXRWYXcdWwfHhb4UlTLAxpJfU2iDa1i0br+Dh+zaRQqV5ZhARowA==
X-Received: by 10.223.172.242 with SMTP id o105mr251563wrc.242.1509106270856;
        Fri, 27 Oct 2017 05:11:10 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e131sm1299247wmg.15.2017.10.27.05.11.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 05:11:10 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [git-for-windows] Git for Windows v2.15.0-rc prerelease, was Re: [ANNOUNCE] Git v2.15.0-rc2
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.21.1.1710210020290.40514@virtualbox>
Date:   Fri, 27 Oct 2017 14:11:06 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <18E24F0C-D518-46B6-A8D5-71B0E1B05DE0@gmail.com>
References: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710210020290.40514@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Oct 2017, at 00:22, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi team,
>=20
> [cutting linux-kernel]
>=20
> On Fri, 20 Oct 2017, Junio C Hamano wrote:
>=20
>> A release candidate Git v2.15.0-rc2 is now available for testing
>> at the usual places.
>=20
> The Git for Windows equivalent is now available from
>=20
>    =
https://github.com/git-for-windows/git/releases/tag/v2.15.0-rc2.windows.1

Hi Dscho,

I just tested RC2 on Windows and I don't see my "Filtering content:"=20
output if I clone a Git repository with Git LFS files (and Git LFS=20
2.3.3+ installed).

The feature was introduced in the following commit which is be part of=20=

your RC2 build commit (b7f8941):
=
https://github.com/git/git/commit/52f1d62eb44faf569edca360ec9af9ddd4045fe0=


On macOS everything works as expcted with RC2:
    ...
    remote: Total 15012 (delta 0), reused 0 (delta 0), pack-reused 15012
    Receiving objects: 100% (15012/15012), 2.02 MiB | 753.00 KiB/s, =
done.
    Filtering content:  43% (6468/15000), 33.30 KiB | 0 bytes/s
    ...

Do you, or other Windows experts, spot something in the commit linked
above that could cause trouble on Windows?

Thanks,
Lars

