Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0604B20281
	for <e@80x24.org>; Thu,  7 Sep 2017 03:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbdIGD1j (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 23:27:39 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34357 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbdIGD1j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 23:27:39 -0400
Received: by mail-qk0-f171.google.com with SMTP id b23so24253102qkg.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 20:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=conNkXfuJZdyBdkaeFT+NgvempFUM1lmuK/uqftt0zw=;
        b=W3e0p96Dcns9jue1SWUGP34XlVTEbZv1wK6bqxjK9mJ/ISrGhJPPk2aK35Rz3hieTs
         wkAvPlmmR5ghEc9B8bVMRP8M1uT3dbLdboITRgGIHMZZKx610AVCUDSUijB8TymFrF1o
         Sbc9jKAwh62ptWqV8FEHtu9bndU08WqRfyHmyFExjKqDPCif7fZmQ9LT9QsB1I04+Kgt
         xr5CZS36aOaF0145HgiGDBuBzgy9tyZJcX70WmB3lmVYEFS8igqn6tS3+PsKDOPETyem
         Lg0TEmFZODDRc+t5B6yz//JYtvu9aUCZxBAHGYVVJPMuzQkSv7QDJZ9I61P8oEzNqUdh
         pgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=conNkXfuJZdyBdkaeFT+NgvempFUM1lmuK/uqftt0zw=;
        b=LPNcoMi1AsNcouFElIeCPIkS7BcY+zp5VApRqichSGuw7bqZq8AP9TIgftfwwzZuqd
         E2vk9aiNKnGExjMJJEpPtNaQ9wbIrG84bMfz5m2kslQ0rs4Hitk/KyQhBlYtXBKNAg0E
         r4RFJOMsA8K3a2fp4ufjIE2ZZGrJct+lFQJ5qtTC+7xRz7lbMd/xihxjfFzUGTGhRbHN
         Y1mGxXKUhPAaSm4b+1N0rbS1//+oe+ifExP+qJpf9hU1bcaG6hZcesjLnuTHjweH4pdI
         Pcsj2Pgdy1VvfRnLXByePmn+rXs0PjGtjEWpf7BmEdPQh1wZdV6O19FTe3iIXqSTDxz+
         RKpw==
X-Gm-Message-State: AHPjjUiG8I5YMvz9uruUIMef9tUGpR2zHV/ylBztJRCZA+5s4L0+Rg6q
        2/5sS+jdvBevP/rxB65UOSYde81Htg==
X-Google-Smtp-Source: AOwi7QASr8GvnhtMwbgirWvTQ9F1O7eDUX8k2pSEK38QUxBv11bKvamTDeWzChtewf4pjnry7ndNWUQ49xKTeAj2sSY=
X-Received: by 10.55.116.134 with SMTP id p128mr1728729qkc.50.1504754858102;
 Wed, 06 Sep 2017 20:27:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.46.59 with HTTP; Wed, 6 Sep 2017 20:27:37 -0700 (PDT)
From:   =?UTF-8?B?5aSP5aSn6Zuo?= <xia.jason23@gmail.com>
Date:   Thu, 7 Sep 2017 11:27:37 +0800
Message-ID: <CA+zMtjmhrE54=ke6vVDGOcrbHkdPuE-Gf5cwQEp8LL2h+xen0g@mail.gmail.com>
Subject: Branch name support & character
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to merge branch a to branch b so I rename branch b to a&b, but
when I push a&b to remote repo, '&' is took as & operator for shell,
and git push fails. So it would be better that branch name support &
character for me.
