Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025F11F462
	for <e@80x24.org>; Tue, 11 Jun 2019 10:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfFKK3S (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 06:29:18 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:37226 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFKK3R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 06:29:17 -0400
Received: by mail-qt1-f175.google.com with SMTP id y57so13858594qtk.4
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FO+pIYweJG86iqp2UomyYAnaXhDbnyMDHmwos/OG/9U=;
        b=YMw5BkfkBPFEHVDjyAsDRtTXpqpI8fpJMciKJ9oLeQZDQ4qH1EyywZsiSS3KtGnP03
         iewqoe2bmonQoPkkW3txPIlsX0XLXpar3Qw0k+MhMmMGLfAP+zWhnsCbi0n5W27459HH
         d73GVylJF8KvO+QG3sKlJ481lf69BGce/WZNqkHlKG2hjgcIIkG9ho8+GAHZM1ffuoCt
         PYSzOn54svDezdGSwl35fv2l/hEHzXGrnqn/oMGUS75OyC3g+Y4NOQCqMVZoXdH/v11f
         MZm6H5jTJPgxbfIWaXK8EAtelPbZNlCHTVgyG8P7h2Ft7Rf8O++gUz/d2OEzWpmUjXaY
         gOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FO+pIYweJG86iqp2UomyYAnaXhDbnyMDHmwos/OG/9U=;
        b=Nk3P3/VdTRKZ2Nfpknd0g4ODOWbUYfcFXvbcsleKNg5KzjMnQcf3SzkF/ETzDIxaTw
         T21H2UgSD8YggRtmq+1Z9eDnJvhhIe2VC4SPHG8atj+qOS2Pvoq+J3pbrecWJrxXM3OL
         137F65a+lJiWLAo+AhSf5T2HocIidURc83RwyoWpZazu8g8t3XtxAQ7KPbwCcGm5m1Rs
         FejQmVCugzmMJkz9Gn99PkN2/uur0KkaIdWY/ROJSck7nKc9FU8vSQI2HaH/Pme8IVfz
         lMcKxsNNEx0b0xnyfLgPci0r8gKvMEvE/UWxbw4DFkTQ6Ck4l8k91wmQj5Pd5FLCMTsF
         4oCA==
X-Gm-Message-State: APjAAAVXJtJBT5cphSARkEJpW+odycBp4WYb1g2Rc+49okwbhJz/+3G9
        qs/SLdSX3EoUlS8qTrqVoqpzqPM5OIfx/N3omxuFgIWQ8m0=
X-Google-Smtp-Source: APXvYqw7kSZqq00vUWb1HB7UJ/aIFlKZdnQQU3QsILEDaSlD4PHcEJSgEI1HWEUZqQYgyifecfBzJt0wKpVcMCsypG8=
X-Received: by 2002:ad4:5388:: with SMTP id i8mr49255518qvv.166.1560248956585;
 Tue, 11 Jun 2019 03:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFF4x5LfJ7qY73JE-=mah5vx9PdeNhc0i0X6kQohPpvDTCd3Sw@mail.gmail.com>
 CAFF4x5LfJ7qY73JE-=mah5vx9PdeNhc0i0X6kQohPpvDTCd3Sw@mail.gmail.com <5cff8197.1c69fb81.4940.6de6.GMR@mx.google.com>
In-Reply-To: <5cff8197.1c69fb81.4940.6de6.GMR@mx.google.com>
From:   Xeno Amess <xenoamess@gmail.com>
Date:   Tue, 11 Jun 2019 18:29:05 +0800
Message-ID: <CAFF4x5LFYQqHnUSzqd1R9NJ=ZVKs3yFqZA=RdrihVx74BtKWMg@mail.gmail.com>
Subject: Re: Delivery Status Notification (Failure)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not all people can afford stable network connection...
I'm now suffered from connection lost and have to restart the clone/push fully.
It's OK when dealing with a project of several MB size, but when I try
to clone a 2GB sized repo I never succeed.
So I wonder, if there should be some way to resume from break-point for git?
For example what if we support something like Content-Range in http,
and make the download be split into smaller files, then make some way
to auto-resume if some file block failed hash-check?
