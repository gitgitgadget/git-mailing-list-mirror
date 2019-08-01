Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9AA51F731
	for <e@80x24.org>; Thu,  1 Aug 2019 01:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfHABFE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 21:05:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33227 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfHABFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 21:05:04 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so21706861iog.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 18:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2Pz1jeZiDPW2K8iKFBQpBwogCFTBq7DXw0cZ3Qd8UE=;
        b=fdUOEQbGeTV04OZoOiWupP3Rl9uLZul2hScAWoIG6RrhZagmz05iL4YiWA6LvVsos1
         OxNu3ql7/3TCjyLh1OW7rluXm7oF2Q1KpP6kQVrGB/SqJdasEzXgDdoXQBC+AqWuQvtr
         1W6alAmgN3Dkd0ogOBt2Y4DuoUBuQ+9UiVP+GpXops/o8MIx3Omdi5zbmZpGyDMpdRpR
         m7aUdzL3cdDsdleadwOw/0UkggfvVCK4vvrNa1swfzCwjA4FEgq1IaEAMi/P9kYrbqjf
         JpWqceSsnrfasEg+Eqt1mf00Dh+svaQ3ZQMGuaOKBx5YqxZBbC1IQK30urnCc2GB5Qv/
         V6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2Pz1jeZiDPW2K8iKFBQpBwogCFTBq7DXw0cZ3Qd8UE=;
        b=O1aSX39KkMfRtLV77t752mrnINZ10kprrEoS9xMm2p5963oqeXRch6u1YkOb0CAyTV
         gzNWh4aHnbN1oCqD1ZecHHNZM2xoFsxS/M8as0rZ9vCQ4QJs0iLT4S+D/gihLHAsbQur
         u/P8b5K9DESKfwElOrBnN343MIenILzi9Rn1ibFkT4BWs4h4/sTua/CXgd/S2vbskNP2
         BKPhQQukwEQt17K+dg3HSEDILEaTusGkB8H54YE0qUlzDohblAgZ7Ti5x6/JH/96Fzuk
         Nae4bgEFgXEN646u+jL0iECMSBeII+83okqULoWmZkUsaJE/BQqoIgblKEYf6wNOiptD
         y/8Q==
X-Gm-Message-State: APjAAAXRxEbpXK1Nzifs7r8X3l8G+FWR9zg9XmuaERyGM3Le16dZyk7p
        c/wY+Bi0ofWqVxH1+9/4kiQXsAbrL+He0Koxaa/Y9A==
X-Google-Smtp-Source: APXvYqyzOZbkvrbWfG3lnBGpvLzb2w0p8uoe7X52OMnHryVKoDbCUxi3K0XiErLgxKQh8nnLQodGXO/r2/4LFmhRgK8=
X-Received: by 2002:a02:c487:: with SMTP id t7mr70726336jam.99.1564621503509;
 Wed, 31 Jul 2019 18:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 31 Jul 2019 18:04:52 -0700
Message-ID: <CAGyf7-FnqiTDjSRcxhaJZtfws9XqJ4a9-OGwVY+juibVuwBMBQ@mail.gmail.com>
Subject: Re: [git-for-windows] Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE]
 Git v2.23.0-rc0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Users <git@vger.kernel.org>, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 5:43 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Mon, 29 Jul 2019, Junio C Hamano wrote:
>
> > An early preview release Git v2.23.0-rc0 is now available for
> > testing at the usual places.  It is comprised of 420 non-merge
> > commits since v2.22.0, contributed by 62 people, 23 of which are
> > new faces.
> >
> > The tarballs are found at:
> >
> >     https://www.kernel.org/pub/software/scm/git/testing/
>
> And a corresponding Git for Windows v2.23.0-rc0 can be found here:
>
> https://github.com/git-for-windows/git/releases/tag/v2.23.0-rc0.windows.1
>
> Please test!


I've run the full test suite for Bitbucket Server against 2.23.0-rc0
on Linux, macOS and Windows. No test failures to report.

Thanks again for these early release candidates! They're a great
opportunity to test new releases in advance.

Best regards,
Bryan Turner
