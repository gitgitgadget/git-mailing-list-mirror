Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E244E1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 21:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfGZVNF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 17:13:05 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:33650 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfGZVNF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 17:13:05 -0400
Received: by mail-lj1-f178.google.com with SMTP id h10so52772217ljg.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pVZgRAYlWh1yd22B0i1PVZ5AHsMRE/eSRrmhx619f+c=;
        b=H6rubqBnCh3ivZ3ldybK2cdNdvO0F/5dpAE+9QaSFmhz8eabSwFU0LZqOxAyUhLJBt
         EBANzHkdX5QaqJn9YglpWwd+Lp+hQlvsv86HUfmRVKIsDcr/zJl3/EMbqR/mfTMx/pm/
         +Az0myGmTqGRY6vpzUA66bPgpL7WdYxBp+44sXzJtwXqszlt2nKKLdSD3wGnEkJ2aNUO
         g+1zQuvsmcgBOtb5qjNL+y7M8qITdXpdFTjzcJbGEWWUCYS4GW3RTlXmKur6jKMTGpGm
         dE2fb3bKsmxBWh0eULHJHAI6Z5EwEWUovZVDU/eTSN6fUGEJXZozznBOu5jwCnh6Qw86
         SyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pVZgRAYlWh1yd22B0i1PVZ5AHsMRE/eSRrmhx619f+c=;
        b=lD2NtlD7WGryYl5ifsRmzv3u4KpVvrifZ9r66oBI6a/bqMTCxF4IRODd1QJTFyX1HE
         LEG4ov2fjgZ81C5FXUCRc6119mIQxOQckVv6mFmIV3OhihA5GUATELLaRgbbRU9W2Zg2
         O8fyVzalrGPp6NQ276jw00Jld2bLQC1cDqvEoDGY5gauZQHTXGf69fvLdnIijgBOaWpZ
         RQjclm/IzGaSoYTvFZuz6Y/FViliJglmqLXC6gVZzMCFuuCejbkkXKIV91tl5jfvFiN3
         225MOBIuK/TAuam6+F5bAyT6QTSDa92moBVoft3jfmdOHi1ADN8yD7shzNL405lFtM+P
         4JIQ==
X-Gm-Message-State: APjAAAVEYwxg9I82uCi6BtlKD88Pr6pOPuEx8+hsJcTx70rt6cHuQdXf
        Fbh5EO6oBS1HIdKs68Z7IkRGxiCBjBqWwet5V7lFigSH
X-Google-Smtp-Source: APXvYqyP1xuuvlgbhAjtjRodciKzYyDddoTcpMctCX3CHoyK+eI9oqZ1SGvhyIs8T0mINgNMZt8Vi8JbPsRcjtM06s8=
X-Received: by 2002:a2e:9c9a:: with SMTP id x26mr30441450lji.47.1564175583386;
 Fri, 26 Jul 2019 14:13:03 -0700 (PDT)
MIME-Version: 1.0
From:   Robin Kuzmin <kuzmin.robin@gmail.com>
Date:   Fri, 26 Jul 2019 14:12:51 -0700
Message-ID: <CAAztzVEeX1H6ge0J=S1=zY5UMprzvYyDaL530-7yahhYCKOaog@mail.gmail.com>
Subject: How to report issues or provide patches for the documentation IN
 OTHER LANGUAGES?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this page (in Russian)
    https://git-scm.com/book/ru/v2/%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%=
BC%D0%B5%D0%BD%D1%82%D1%8B-Git-%D0%9F%D0%BE%D0%B4%D0%BC%D0%BE%D0%B4%D1%83%D=
0%BB%D0%B8
I see:
    =D0=B2=D1=8B =D1=80=D0=B0=D1=81=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B8=D0=
=BC
I expected:
    =D0=BC=D1=8B =D1=80=D0=B0=D1=81=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B8=D0=
=BC
And I fail to find the exact file to fix. I fail to find a clear
description of how to provide a fix/pull-request (or a least to report
the issue).

---
Join us at CppCon 2019 in September!
Robin Kuzmin, CppCon 2019 Speaker Liaison, speakers@cppcon.org.
(Please allow 2 - 4 days for my reply)

Robin Kuzmin, kuzmin.robin@gmail.com.
