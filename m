Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38F22021E
	for <e@80x24.org>; Fri, 11 Nov 2016 09:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756091AbcKKJWk (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 04:22:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:64657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755946AbcKKJWh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 04:22:37 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M3NEK-1cvr7S0yJs-00r0dO for <git@vger.kernel.org>; Fri, 11 Nov 2016 10:22:34
 +0100
Received: by mail-lf0-f53.google.com with SMTP id o141so8033332lff.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 01:22:33 -0800 (PST)
X-Gm-Message-State: ABUngvdbr4gC4HogTavUt+zZcWLIwfWkCRIT88c6DKeZeuh2SoCuhAFj4EH0uN2uea31jA8ZXLzP305j+jwntA==
X-Received: by 10.25.19.70 with SMTP id j67mr1152831lfi.77.1478856153393; Fri,
 11 Nov 2016 01:22:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.74.196 with HTTP; Fri, 11 Nov 2016 01:22:33 -0800 (PST)
From:   Uwe Hausbrand <uwe.hausbrand@gmx.de>
Date:   Fri, 11 Nov 2016 10:22:33 +0100
X-Gmail-Original-Message-ID: <CAHNyMp8sM70SyDC=Ae=HpQ2bRuqJB9DzmjvN=JK7oQYxaJZxUg@mail.gmail.com>
Message-ID: <CAHNyMp8sM70SyDC=Ae=HpQ2bRuqJB9DzmjvN=JK7oQYxaJZxUg@mail.gmail.com>
Subject: pre-rebase, post-rewrite, ...
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K0:7EI7da89GPt6hd7oY4zWXC3DUSLchp/ig5wK+HdE/BErX/Z+VAu
 U1638nus+E7x3A7qCfCEv+vJkKVgy0QEzTrkuWb9rv7N96fy3MXV973ewLGN9osUF8ZDFYI
 3yYZqBB5UZlh1Tyn+fRnqRVA5D9NRH4UeWd1ZIMHEgQUnvH4f7/yLUZFTcwMpn/vevK3Awz
 FPia6eoXNTGxCshh5UHCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9MwXNIJL7iU=:H+OLrbJIliR09X6yelzVT6
 hz7FQBUuGiPXLylNyqv7q27F51xJUlTvDhqAM+HzNIDrmrijjvmyP90QfDKQJteFgHpwRw2A6
 ntEFV3XwZ/6H5UObRGSCe1x+DHjoXxWEK4yppOXM/09+QfjOG1Acj0RU9jWNRP2SKYnkDjhIQ
 MimTTdidX06S1rCI9TxdGX3ln9XKgeR2nv1d809DFDzba6NcvYE3n6euS+VlVgCHlZoQY0ZcS
 FYJAaG/EJgT90FtdSS0jj7LE4MCgV/n2WsTcLdhBesKkbpgDE38imuvHOx5jBRebVDFquMK8i
 dv6Hm8g9C1bgm7o6XmqklGdXqP+yzpJDx1GOfAwHWXkHdFOuMNrgDCsfigXk9tdSPEPvfEeKY
 I4g1rLhWd96RqA9e/lUsdAc/CIG6Iw4Mm07QaPEDUqrAk3We3dD+TC5TmLMAsmDW8nZW8m31W
 un3g0qje2e8hTGH7+L5pKRoktNMEZlFhJ85jZc0WPm2ZzRs1UNMh5IxxYc+K+ChGkp3ULlNX0
 pXkHWhs0AjXBm++Iu6TjBVD4UjljwvwdsL/x2Q3/qmCWfTqwkdfpcYVmmaG9UfUvgVRL82BNJ
 Aoi3fNVwCxcPsZDJj+FkZ9kGLyVDOQBfTXruGS7e9hApwHQHP/afw0+rnZGAfW4dqjkQgKwxx
 hmuR90hy+Y/UbAHJcuxdZw/+EfqZkepLz7aYeNbabx5URX2tM8HDtAD6XLG9vCf1k1SRuf2tf
 wXvmMUeYZmJsQMxoLsc/rZVoRGADlnQV+AmkfYFo3CaMWMC6WzQI/17RE+02a6YP1BxzkSBe3
 NcM8p+W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am using the pre-rebase hook to generate a tag. I am using this tag
to check if my rebase lost any commits or content when i'm cleaning up
my local commit history.
What i now want to do is using a post-rebase hook to make a diff check
and remove my generated tag in case there is no difference.

I use the post-rewrite hook to make this check, but this only triggers
in case of a rewrite happening (which is understandable). But the
pre-rebase hook triggers on every git rebase call and so i generate
tags which could be removed automatically.

Is there any other hook i could use or why is there no post-rebase hook?

An older post mentions ( http://marc.info/?l=git&m=120796177421283&w=2
) point 5 which i think applies to my problem, but as i can't alias
real git commands (which is ok) i would need to use a new command.

Best regards,
Uwe
