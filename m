Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685221F404
	for <e@80x24.org>; Sat, 17 Feb 2018 03:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeBQCyw (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 21:54:52 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:43546 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeBQCyv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 21:54:51 -0500
Received: by mail-vk0-f47.google.com with SMTP id x203so2917355vkx.10
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 18:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C0ETDisZvffU0l/Q5wSfX2YdxhrhVHwqMDMm+kSU7mQ=;
        b=qs9AS5NO4PDNLbJJqcHM+AGO+Qk4fHaVCkPqMwmvW5ppppeHRmH4Cq4TK9ju2nm4xU
         o+oBN4jhTVMU6o7bdlgFa2M8mASVpQrg2LZUbsrD3UFAhs7ZGiOWZ46rTEahzy3EJjlM
         /tVgnRVlqzqSp8Z7bzcPR3gccfe5Uha+7Zzf5azeZmrVWvcycmcHjmwayCP9R8je/88/
         xYNURwTgu7POndc+mJ+qXpM9wsDXbKGGlit5szmTVKwAaHoQ4ePfdiHE517SOOj09FDp
         47/VIvvM6b2AyoGVwEpHGu8NJb/QkjAntXaOZ3JrZUriUSn22xPIikAx1nnurb8w3v/a
         k8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C0ETDisZvffU0l/Q5wSfX2YdxhrhVHwqMDMm+kSU7mQ=;
        b=OGzUwELc+Zlzv4dym3OxMOWMZVvGIHqd/5OZ9sAUNGsbeBZ5gEJLJoqwCu8NHKUbSH
         4YnMho8oVDZ5IcYtOiuoNkR3UEhQOcpjhqmZoCWKbCtEH83luwnmBTmI4OzDfKb3IimM
         a0p149OJIagxsAZXH+Dxgbs4CRtEnY0mArVIxgKLUlgiauEl5zKl6cp6tARjc5K5M0Oa
         uigZjdijC10eT/yhRWNavgw1IvX0Z5p0kPO0KPJCmKX2paWc7bfHVzQBmskxp4pki3rm
         46cGFdYD26peQ5y6EGIbeqFCuCz30/Q9M18PlzjaGgtmVEWj6O23vIX5fQcr5gErGL+D
         /P+w==
X-Gm-Message-State: APf1xPAfKwF6qJbnTwijvHDTNqGifEONP8Z9Gm6kKGXorv7L1OA1Y0qh
        OmNqt+SGzqGkTu90NvmX6nxpGXlGmxLtWkWPUZCcWQ==
X-Google-Smtp-Source: AH8x225Q6l0kaCJR3iaw3PbQSxnl65e6vjlAXVKt/RfeMQBFgM36murh1jsxs+3U+E64ZGoVN0cuL81ejBorOUcLDp8=
X-Received: by 10.31.63.6 with SMTP id m6mr6636789vka.43.1518836090306; Fri,
 16 Feb 2018 18:54:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.32.70 with HTTP; Fri, 16 Feb 2018 18:54:49 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1802170018250.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1802170018250.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 16 Feb 2018 18:54:49 -0800
Message-ID: <CAGyf7-GK+HgYx0AjRQXPhbxNTaohN1K2NFf3eWPjLsxHC6CvtQ@mail.gmail.com>
Subject: Re: Please test Git for Windows' latest snapshot
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, Git Users <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 16, 2018 at 3:30 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi team,
>
> I am unwilling to release Git for Windows v2.16.2 on a Friday night, but =
I
> have something almost as good. There is a snapshot available here:
>
>         https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__wingit.blo=
b.core.windows.net_files_index.html&d=3DDwIBAg&c=3DwBUwXtM9sKhff6UeHOQgvw&r=
=3DuBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=3DxZghHWteeNbJ2bu5ySDq9Wwq=
nfX8X7FZ_CWsV9gAyJU&s=3DNzSYCFSWWokPP9A9FA_EmJO5yu8qtRKw5M-Ep_qooUc&e=3D
>
> That snapshot brings quite a few updated components apart from Git proper
> (such as an updated MSYS2 runtime), and I would love to ask y'all to give
> this snapshot a proper "tire kicking".

I've run Bitbucket Server's full Git test suite (~1,500 tests) against
the Portable Git snapshot (e1848984d1), no failures to report.

Bryan
