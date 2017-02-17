Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2956E2013A
	for <e@80x24.org>; Fri, 17 Feb 2017 08:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755887AbdBQIYM (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 03:24:12 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37496 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755882AbdBQIYL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 03:24:11 -0500
Received: by mail-wm0-f41.google.com with SMTP id v77so4711945wmv.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 00:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NsnpbphATdj9eQM+E+HbmK8nuNlC6MX6BsMOf1oLJ04=;
        b=MiXGIdASVMK04gm/yPXbtOBt/0O1HGP/lALyZhs6H4I4w4YO7qXuoM6vaaR/mZCkaf
         yIdcHfSUKEB2evma39zDHt5Yw5DVBBQNsFBtFzdYm0B4BKZ3jAv6uBNsMz2bQ2qmpYLC
         dtig4wMsH30ZbCPC3kgUMQg9+ofh1A6Ij0AbSX6AWNgGnmKRzM+yY+gqXc33EF+yGOFa
         +NUWuopDhaFNGiP6eykIyZS/t+qHYAwpn5E+od5PysU3IcLi9+8/zdbOxlliic9kgdLJ
         GEJykVwRiFp0mkKHV2hzwnUu7dwcYwYegL1ZaJvSYhD7GlMQdCkHGgGlU82+kFCSjEs/
         q26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NsnpbphATdj9eQM+E+HbmK8nuNlC6MX6BsMOf1oLJ04=;
        b=cB/Xd92glxr4vi2r78ow8pWK47u8LpVw1rFxIdd3xbRPEfcDedzG22114xb6txKxdN
         exPyAqfYmJ3u62280dla7MinUVgTGy6DcDayWN1Gkpbo2TNY+bv46/ktW8jHScNhv1p4
         qk6qunDO0NpvyAwTSW341kSMQHQ2Puwg//HdnRNWQUkGLGGkvhatGQ6MZoPqVwgUexJb
         0+58czSGRU4udJ0WXXSn5uzC7GP51uz3+YP6x/Ve3dwPimv4w+uSQcvWzwI71GYlR7Lc
         HQnn8GYUPK2eLSuIaJfMvTZuVRZW0CSN5z92dle1wW6EybI8wIAGO2g6/sAV8CNjn+4A
         4H7w==
X-Gm-Message-State: AMke39nQpGpE5SdZYXfbW8HQDgeylKO7AERoswqswNVxBjoxmGzTPv7bCmHXi+RvAxOeIxAuzF0hgnwxtbxFyg==
X-Received: by 10.28.129.147 with SMTP id c141mr2061888wmd.12.1487319844769;
 Fri, 17 Feb 2017 00:24:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.62.208 with HTTP; Fri, 17 Feb 2017 00:23:24 -0800 (PST)
From:   hIpPy <hippy2981@gmail.com>
Date:   Fri, 17 Feb 2017 00:23:24 -0800
Message-ID: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
Subject: git alias for options
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git has aliases for git commands. Is there a (an inbuilt) way to alias
options? If not, what is the reason?

Thanks,
hippy
