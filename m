Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C5E1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 20:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755280AbcK3Ucv (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 15:32:51 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34991 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753898AbcK3Ucu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 15:32:50 -0500
Received: by mail-qk0-f180.google.com with SMTP id n204so222796759qke.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 12:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=FWnSjjk/CcipOX65FOEByJYz5pnFQadTRupzuETJAms=;
        b=umjWdF5UFUcisiF9kn0ta1nYzHbflvBIFITvWgwriU/CU4jtR7t3ZcIpBb2uG0//+9
         SAt8Szvgz8NLzXeUCekGwHxNZTo7KGlXqAOaZEoVQ43voWyk6HkFJLaU/FtQHpA9iLks
         QZbneT695Lug6qY6aCWoMhdUgeAaTfYv3Z+Xz2lwdDUgZ6IyQ4QeHpXia0az0kjNJMFZ
         eV/ww6nTTB0L4JGl9fN1Fp7PKqa8UE7W5h+aN76lFBMdvrZvfmrLdEH64WsdQumK/y/M
         Gown9O2AbsjKvuGntttvWxMlXUquFKJU9YfrEboc1wC8za6zaxFCOmqxv+nKBaUlNg3h
         rG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FWnSjjk/CcipOX65FOEByJYz5pnFQadTRupzuETJAms=;
        b=arlHZE8gctUPIQqXR+zh4y7pvYyKM4RGycdJU2d2+zmmcFd+XuyhlBRFRkFEdW0Rtd
         z6Poum2PsMpzzduS4w1JQYGqCZRXAEANvDTZiRU9Nr1g1bSJH3LAhg5AxlJfoz+RtmFc
         SBepSJBI9JKtJHlZY9HogiCkthUO0HQyZoL3wGKr6/OJJ0Eqe+NNjc1OGbr46ko5Kvcq
         YDiOHuKGwf1cI+1pxAqcyVBA6rsZAfLqEGWz7b7KeD1b/fPepF+ocA3zaTFwvGRWGk27
         uX2olVJFPdwYU1vD1gb2Ezc7oW+4R1GCCK8xLI+6sgYPBgvefzRDI5ZQp4825vA/7Q/z
         PabQ==
X-Gm-Message-State: AKaTC001t+zVucArsZEzhb+HOq1TvD1KwPwZIBqIueq5J/ez4G1Ssbkr3Zxnqiy2ogK1n04K/VXoGWo+BQ4dEg==
X-Received: by 10.55.106.134 with SMTP id f128mr33490300qkc.121.1480537950356;
 Wed, 30 Nov 2016 12:32:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.176.147 with HTTP; Wed, 30 Nov 2016 12:31:49 -0800 (PST)
From:   Peter Urda <peter.urda@gmail.com>
Date:   Wed, 30 Nov 2016 12:31:49 -0800
Message-ID: <CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com>
Subject: "git add -p ." raises an unexpected "warning: empty strings as
 pathspecs will be made invalid in upcoming releases. please use . instead if
 you meant to match all paths"
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After upgrading to version 2.11.0 I am getting a warning about empty
strings as pathspecs while using 'patch'

- Ran 'git add -p .' from the root of my git repository.

- I was able to normally stage my changes, but was presented with a
"warning: empty strings as pathspecs will be made invalid in upcoming
releases. please use . instead if you meant to match all paths"
message.

- I expected no warning message since I included a "." with my original command.

I believe that I should not be seeing this warning message as I
included the requested "." pathspec.

~ Peter Urda

http://urda.cc
