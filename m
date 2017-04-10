Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016A1209FB
	for <e@80x24.org>; Mon, 10 Apr 2017 19:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbdDJTBQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 15:01:16 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35843 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbdDJTBP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 15:01:15 -0400
Received: by mail-lf0-f41.google.com with SMTP id s141so40190107lfe.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wphyg6bx0kIRPfZgQdbmWjgexHDLnVrmkZUlx/djMIw=;
        b=gDDEGgHsJF7rOpgi2Nv0IBV+qIckwDCg0GGtPfuAESIDev3C1uFog1umojw/zfh8Mw
         H8aSUFsRhYBPL+IqdjbBraxFa2wJWka0rTNI3Fo+E3uvPsx3+MBsbk9EsbSaTkhAi2jR
         izxkLMK6j9SORSkuRiYUDvuXoxXw8bydGNXL68ngbhCGDT6QpSiH3wLF+DbOeduZUvAa
         Fn8fVQ9ecdnYvuXqP65Klcd0aajGR2GOVAercxYRT9Czf1XalL6I9Qg8hvqMLCTX5e9S
         wJQx+KMAF3HTVLCj68LuljIpCD6tpj64HgcEeAtRBXXRBaI6ihcPvaftZjEgZyDlqpb+
         QRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wphyg6bx0kIRPfZgQdbmWjgexHDLnVrmkZUlx/djMIw=;
        b=RsOR6db3feh+tPMVwESq9EBlXEW4QrVjEJ8tlUjbRntpJLtGGmUBfhmz+Ofx0Au15C
         O3ZxoAkS0EgRVQCFKXHSCMZIxIUl4clOdn5xnXXMthM6MALhlQA8VmVfLJcjn4XXvUaz
         fgkUMyTeEm1VBZuEQTbTPStv6JaWFuErqnONR2WNggdXqwT5ZlPKLaJe+x1tKTESZQBU
         gIKqtYxM6tR9YEk994ZiEQWyQR2Rh+0EwU2Pwpv7PS6ORdIJ79XVfJ+uB1jF2/86XLno
         X1egVxIlhnz1hIYyjfBPZIjSpikYmI3KsgKmr2YfgRqrCbOq5Ylmd82vkqSRxVfAWXNV
         NLmw==
X-Gm-Message-State: AFeK/H0L7lAhr936SkHnjY7ZsnCL4BzcveKWRzjTg7QoNAwE/74q/hlrOrA+2l3bkIPpZg==
X-Received: by 10.46.21.23 with SMTP id s23mr13695559ljd.15.1491850873996;
        Mon, 10 Apr 2017 12:01:13 -0700 (PDT)
Received: from kicer.localnet (095160130254.rudaslaska.vectranet.pl. [95.160.130.254])
        by smtp.googlemail.com with ESMTPSA id x21sm3029183ljd.15.2017.04.10.12.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2017 12:01:12 -0700 (PDT)
From:   "=?utf-8?B?TWljaGHFgg==?= Walenciak" <kicer86@gmail.com>
X-Google-Original-From: =?utf-8?B?TWljaGHFgg==?= Walenciak <Kicer86@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: broken text encoding in commit author name
Date:   Mon, 10 Apr 2017 21:01:12 +0200
Message-ID: <1877970.a7lV4V9TVC@kicer>
In-Reply-To: <e1836f50-1318-b72f-5507-b395be02e88d@gmail.com>
References: <12228342.8FuY78Fyzc@kicer> <e1836f50-1318-b72f-5507-b395be02e88d@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dnia niedziela, 9 kwietnia 2017 00:07:52 CEST Igor Djordjevic pisze:
> Hi Micha=C5=82,
>=20
> For what it`s worth, looking at the timestamp of the broken commit
> example you`ve shown, could the problem be related to amending commits?
>=20
> If so, are you amending through the command line, or maybe using some
> tool (like "git-gui")...?
>=20
> There was a similar discussion recently[1], not sure if it`s related
> to your case.
>=20
> [1]
> https://public-inbox.org/git/CAEPqvoz8s=3DCVLABuXx-zOzryrXwr_cb39G2TYJvvF
> XRYzpCBFQ@mail.gmail.com/
>=20
> Regards,
> Buga


Hi,

yes indeed, that's the case. Amend from gui ruins my commits :)

regards

=2D-=20
Micha=C5=82 Walenciak
gmail.com kicer86
http://kicer.sileman.net.pl
gg: 3729519

