Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA2E1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 06:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeDUG6f (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 02:58:35 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:42240 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeDUG6e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 02:58:34 -0400
Received: by mail-pg0-f48.google.com with SMTP id e12so4899953pgn.9
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 23:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W4wgxf6lSpstibZzN3N3OHUMRwRq5zUL8DWAzs5ANto=;
        b=WSHwpXagPZrhuQrE1J1C8AcKPu8iY78KhcR3ZDDvFeVpNIMYMHgHtj0x8pTeUS2CRh
         YmhnWXhlZ5xgAFHzY4ZQW98eCo8p2gwu2hsAZaf+Vl1OOZw2/LBWDqECSjI6UOhxmj+o
         J7ZpOqWhtPzv5FCAh+1Er6vln7UDkqli0YV6wkCfvUEQxpX6Ejh1tosfkFeGkKdEKH4e
         hlsBK+gszezseNYXKjPtguqJgoarT4FNLT8N6s90acR3ir8baSIl4Uv6E81Unx3kqyoB
         Se8rKOHGEsD3PrvONX+jshiXX05Zp9Gkc6ljE/nW45Jr5wdARuaaH29x37ogcbaL3bPZ
         3Y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W4wgxf6lSpstibZzN3N3OHUMRwRq5zUL8DWAzs5ANto=;
        b=FeFpDUrl8rPgQXoZQmc92x1Lj6cuz4Nx2o1srMRFkdd4JPL9zrUgmzkqy/w1LD66g7
         A1fve/bUDHoKKSFMl1wJjE4vhWI3Hq/vPHWts5e0kbMuE92kZtVFKprcPke18ew4EJM7
         95ouAwbQAj7uy6wPEAc19OJ/fpIzGFAlm3Opmlbpde6V4LI2Gyzg/oUPN2jhQNg34UTB
         jnr8e26GM5UIdcnxmN7qeiCB/tFxqK3MXFQfnwsuCoTtXzgh02IPClhv6exvWYJni8S/
         V9TekjzKAXU8raShnfQCYRXRe/08dK1avSF7pDGi8oxqvKhz3tZxMoaBJKcAQzFRhD85
         9HEg==
X-Gm-Message-State: ALQs6tBCArCAY/bS67WuGfPQqe0m8qBZa6NIRjmc7TomuE1YKxa0mYrt
        TXO/QPu08v5vGBDQEFjlTHC3743u8KkdhQb+q24=
X-Google-Smtp-Source: AIpwx4915y7Vri2P1zAdmUhD/LzkTzFs8KmUT61+XzObhLLhLY1ID46UITZEDomRLcOapkjMWVRqY/s+Dv2aAHXMUGc=
X-Received: by 10.98.237.17 with SMTP id u17mr12189261pfh.78.1524293913845;
 Fri, 20 Apr 2018 23:58:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Fri, 20 Apr 2018 23:58:33 -0700 (PDT)
In-Reply-To: <CAPig+cSKBAq3h4CAe4phFoG+APDV_qzApJgCpYK6AZrjW-+xxw@mail.gmail.com>
References: <nycvar.QRO.7.76.6.1804202258071.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180420221231.4131611-1-martin.agren@gmail.com> <CAPig+cSKBAq3h4CAe4phFoG+APDV_qzApJgCpYK6AZrjW-+xxw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 21 Apr 2018 08:58:33 +0200
Message-ID: <CAN0heSpu0sJkpr1DJCYv_Yu7zsZ2ewO-z_ERYbX29yf3y-Rn9w@mail.gmail.com>
Subject: Re: [PATCH v3] fast-export: fix regression skipping some merge-commits
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Isaac Chou <Isaac.Chou@microfocus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 April 2018 at 00:16, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Apr 20, 2018 at 6:12 PM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>> Re-add a commit when it is not yet time to handle it. An alternative
>> that was considered was to peek-then-pop. That carries some risk with it
>> since the peeking and poping need to act on the same object, in a
>
> s/poping/popping/

Thanks. I remember looking at that and going "hmmm". Apparently I left
it at that, since I see now that my spell-checker would have complained
about it.

Martin
