Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6FE1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 03:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeCXDCv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 23:02:51 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:37252 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbeCXDCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 23:02:49 -0400
Received: by mail-io0-f173.google.com with SMTP id y128so17331626iod.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 20:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jV2sPjXDPv92PWPIkLvtT6hrpX6cldV1jYdnjoH37JU=;
        b=nSz1VR8zJ1zsCTuZ3qyc1/6HdDgFdSeLCW79IPYUK9q+AHjPUFTONcGL94juIHxTUD
         Rr4OPdQmpEVrOSWPzsS5lf1vEgQDf70jjx53W49ZkUKio7SLDh+23mlKyT3vmaKg/sCx
         8r68AN+7TJq1XeXvVWObgPA3AHE+GSJUWXVDASjBEeXrzWlqapM+9KH+eCQtDbXbBFpe
         l051ILsn7YscAuLnXsR9CUhLGU2a1a07bnz/XQjp4YouygQoyTICnExbccpPnVK+FMdb
         qqbVFOpM2yzk+be53rnB5u48fAWb+D1idW6ZU17brvvrzER71JanBbJwolI5ItE1bwvc
         x3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jV2sPjXDPv92PWPIkLvtT6hrpX6cldV1jYdnjoH37JU=;
        b=F7yQu/X0phNg0yZnXAmMenhvJe6NJG8z29EDh/Ph5WkS4jrBRtHbzE/CbWnHYz5Usu
         9RvLy75nWUUyBQqpvaO1hC1kxuYyJpBaxHnx7iJvEpCAvlnLa3SrYFrQLPEP2MgyfrJD
         16Ltm/v/XDEEjYJlksSujBoJG8Id4sRj0BwmsmqoZ4lOcuARNaxVFj31XxAjw606xNWn
         EQWCzRhv4NwjMRAzPYtRFEp7AMRMLDoukSi49PV3RuOH+VHaTri0Vxr9acRRiT+bQmuu
         43NbwZX4V2MwWTWvoljzxEhnRSJX5q4wnKbqmIfMQHqPiOOYbDX5iW3ofdzsaV5BC95g
         V6HA==
X-Gm-Message-State: AElRT7GgV4+Im5SHpW96mD8A3Xli+kwAdn9YWTeH4eB1gsFvNW69eXt0
        52QNTP85TSZ5VnxsHSUHVBEEy5Vp8b53EfRKnDFFBg==
X-Google-Smtp-Source: AG47ELuIZ5TmiKuIpTvULTCaDW7AHbVTkYszj8ig1d5I7z6s+t7akQ01UPxzQS9KnsGPS/AL3+WhQkiGIppZM4F2Eo4=
X-Received: by 10.107.44.83 with SMTP id s80mr33149726ios.49.1521860568592;
 Fri, 23 Mar 2018 20:02:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.97.20 with HTTP; Fri, 23 Mar 2018 20:02:48 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803231845520.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqtvt9nr7p.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803231845520.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 23 Mar 2018 20:02:48 -0700
Message-ID: <CAGyf7-H8Zv=97LDnGAkfr-Xd4mYpRp3Fz0y+E2P34XcGPneUWA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.17.0-rc1
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows@googlegroups.com, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 10:47 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi team,
>
> On Wed, 21 Mar 2018, Junio C Hamano wrote:
>
>> A release candidate Git v2.17.0-rc1 is now available for testing
>> at the usual places.  It is comprised of 493 non-merge commits
>> since v2.16.0, contributed by 62 people, 19 of which are new faces.
>>
>> The tarballs are found at:
>>
>>     https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.kernel.or=
g_pub_software_scm_git_testing_&d=3DDwIBAg&c=3DwBUwXtM9sKhff6UeHOQgvw&r=3Du=
BedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=3DyXNBIWf9n-gxAIgQyCzXfuKaFkHQ=
aMmwUdtiNBNE8XI&s=3DE_Z2M418iwz-HyJg5D0VyTCvyMMd4kGIvYccgJkyTwA&e=3D
>
> And Git for Windows v2.17.0-rc1 can be found here:
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_git-2Df=
or-2Dwindows_git_releases_tag_v2.17.0-2Drc1.windows.1&d=3DDwIBAg&c=3DwBUwXt=
M9sKhff6UeHOQgvw&r=3DuBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=3DyXNBIW=
f9n-gxAIgQyCzXfuKaFkHQaMmwUdtiNBNE8XI&s=3D7ePu15Fwlwuxo8JGcqj-pBNh1wSZYAfYm=
boqBvJOyA0&e=3D
>
> Please test so that we can hammer out a robust v2.17.0!

I've added 2.16.3 and 2.17.0-rc1, for both Linux and Windows, to the
test matrix for Bitbucket Server. All ~1500 tests have passed for all
4 versions.

Bryan
