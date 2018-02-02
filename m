Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090A81F404
	for <e@80x24.org>; Fri,  2 Feb 2018 22:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeBBWos (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 17:44:48 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:44364 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBBWoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 17:44:46 -0500
Received: by mail-pl0-f54.google.com with SMTP id f8so7249605plk.11
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 14:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackthorn-media.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1BFEWZxIrUvw31q2fGStQz64dsawXbleOeTSOA2n0ss=;
        b=XrMR9lUeYN5jyM0G4bDSeeXsPBABjOnTiiQrQEctzfOVkgG/fZJd/AHmbXtvPZ8sE5
         zzw1Deled+whMCCf/WqizRd30GFoY8FsWNCSWcz86P6Tycf//G/1OUye78HKdt0u4OzU
         oQ/WpXVjBi4DFCGd1zCt3bEMwBCTX81XzvnEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1BFEWZxIrUvw31q2fGStQz64dsawXbleOeTSOA2n0ss=;
        b=LR+1Jt4AMCyrXp6a7ZFvNR7QUw0a/GePM6Y0scN2SRKiuf8UmAzioHCAOItrlrkTV4
         kGUrupyoWIoYOfepT/e3e2fi2ozAWX87/gzPAt/FM9MT1DBJtkxsP11a4L/NTm5r3vTU
         sWBENuPKM8d3FEzqaGl8DbUt4WTWibJFvWT5l+fenuqC4FxM5o+nrW/1/GBxW+dvcrRF
         a3drhqIf1/Kb3zPjgLmFtIJANat8ala90SVVlhWVkNMJmPIBvF9cTYMpLSVgRnfYP6l/
         sLFUfGTny+B6E1A4qBGj8I6L+MsxS16hVNausP5DiCFzTJsbXeLQMW2PiM3FNJy3v0g8
         6hpA==
X-Gm-Message-State: AKwxytcRANyrPjQLY9i360ffM/F2tf0oVKN+XRQ7hn4AMOncQnnIqeKS
        Hj16pn3FSxaGX2Bt4zsEG00tsbQWsGg=
X-Google-Smtp-Source: AH8x226LR48Ka3oe/WCEL11kGyyp5OEyz+TWehK4WxIbZlker6A8hGAEh8OVSPXvJLCY1jpRKAQSqQ==
X-Received: by 2002:a17:902:b406:: with SMTP id x6-v6mr27355596plr.150.1517611486018;
        Fri, 02 Feb 2018 14:44:46 -0800 (PST)
Received: from [10.10.2.117] ([38.88.196.250])
        by smtp.gmail.com with ESMTPSA id 184sm5372748pfd.156.2018.02.02.14.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2018 14:44:45 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Git on Windows maps creation time onto changed time
From:   Keith Goldfarb <keith@blackthorn-media.com>
In-Reply-To: <nycvar.QRO.7.76.6.1802022216370.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 2 Feb 2018 14:44:44 -0800
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B8B61C6-0EB6-4134-BDA9-FA7750B79BB2@blackthorn-media.com>
References: <CCB76F06-DBA9-4342-8830-402F8AF9854A@blackthorn-media.com>
 <c1e419ae-feae-5a31-ead6-20b25fa92f85@kdbg.org>
 <040E3C3E-BC8E-4658-A882-5149D10AD408@blackthorn-media.com>
 <nycvar.QRO.7.76.6.1802022216370.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Feb 2, 2018, at 1:18 PM, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> You cannot assume that the inode numbers are identical between file
> systems/operating systems. That's simply not going to work.

Yes, I agree with you, I cannot assume this, so I checked. In my case, =
the inode numbers are indeed identical.

> I know you really want *so hard* for the same working directory to be
> accessible from both Windows and Linux. I have a lot of sympathy for =
that
> sentiment. Though I do not see much chance for success on that front.

I=E2=80=99m certainly willing to accept that there are going to be =
limitations by using a filesystem from two different operating systems. =
But regardless of the problems caused by that pattern, would you agree =
that the Windows code should be using the actual inode number (well, =
32-bits of it) instead of zero?

K.=
