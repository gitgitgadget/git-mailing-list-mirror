Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2272047F
	for <e@80x24.org>; Sun,  6 Aug 2017 11:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdHFLQr (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 07:16:47 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38761 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdHFLQq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 07:16:46 -0400
Received: by mail-wr0-f176.google.com with SMTP id f21so30251996wrf.5
        for <git@vger.kernel.org>; Sun, 06 Aug 2017 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DYlBzZmwdhuYPFMR6JJmrI1MhFFioosll+1p81eWlss=;
        b=E+jNera+V6AZORk27LCd8m+TAlLoAcx24BSrL6FPn4CgHUHtFEj2yovb2dWNl/pF0M
         lFby0ajZdvNNcnjC6bpzaKCSqhoFEzHGjP+SmD7V6wqjxfvG4F5DSW4HwrcolZqTe/lF
         riF3iwwKEXd5P/+qwkUhQbxi0WDpXDDxDFrgSVxHm+TfdcH0xlvaVzSdqCGiGFwxVHAw
         69NbHABAI3QL12YD1694M7hEkzTv52c+7UffwOlLyXp9qMPSBdmm0Gg3InNRwGEDTPeC
         5EQ08eXa6yM1UoBKcZCB3YAIOXy7NsYlPbyRj1pGsGhrx280kFiwUV1eXYSSlbDSxZ/O
         sTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DYlBzZmwdhuYPFMR6JJmrI1MhFFioosll+1p81eWlss=;
        b=au2MxiZL8+1/GXws9A5QvbfFPcFDi2eYgXX77LYhm8PUlKxmyvuA3Lz9TdTE3Zgi+H
         93UFw72IKhaYEmVVfoXh9EgHQPR5KfZYrn8r3DU4FIAIdTrde11RJSYzKpWHeQKeE+C2
         aTvN3sWBDiG4Q2Edn3U5FRg31hulgCcPKMd1BEESupKkbxuDwh12ZBv/GBFrHSOrznNj
         x1PI6nNA8uQNFnyw1PbOXdo3YFWbURUeLz/Jf9lHa4uluikxz5NZ1tEgcuUS6gImZBiF
         ozPSfHqcaUEM5imaAzyr24t8/5dU8sTIsllUO/USDiPXcN+rkHJvSoHKSt8N/4GDf8oC
         0PRQ==
X-Gm-Message-State: AHYfb5h42w9gUBvUi5zqEswVnCSEtk7AjGrJsTgGzqtPKtm+5pXrSXPZ
        KJXTd0ebEKfbZA==
X-Received: by 10.223.177.25 with SMTP id l25mr6327965wra.14.1502018205407;
        Sun, 06 Aug 2017 04:16:45 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB6221.dip0.t-ipconnect.de. [93.219.98.33])
        by smtp.gmail.com with ESMTPSA id r76sm1975520wmd.1.2017.08.06.04.16.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Aug 2017 04:16:44 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.0
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170805230001.3232-1-johannes.schindelin@gmx.de>
Date:   Sun, 6 Aug 2017 13:16:46 +0200
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <978038E7-74E8-4F9F-A3B9-0BAD82C80FFE@gmail.com>
References: <20170805230001.3232-1-johannes.schindelin@gmx.de>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Aug 2017, at 01:00, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Dear Git users,
>=20
> It is my pleasure to announce that Git for Windows 2.14.0 is available =
from:

Thank you :-)


>  * It is now possible to switch between Secure Channel and OpenSSL for
>    Git's HTTPS transport by setting the http.sslBackend config
>    variable to "openssl" or "schannel"; This is now also the method
>    used by the installer (rather than copying libcurl-4.dll files
>    around).

Does anyone have a pros/cons list for this option? AFAIK OpenSSL is =
still
the default in the GfW installer and I wonder why. My gut feeling would =
be to=20
go with the SSL implementation shipped with the OS. However, I don't =
have enough=20
knowledge of either implementation to make an assessment.

On macOS Git uses the Apple Security Framework instead of OpenSSL by =
default.

- Lars

