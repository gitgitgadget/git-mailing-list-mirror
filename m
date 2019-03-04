Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477CF20248
	for <e@80x24.org>; Mon,  4 Mar 2019 05:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCDF04 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 00:26:56 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:45525 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCDF04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 00:26:56 -0500
Received: by mail-pf1-f174.google.com with SMTP id v21so2124543pfm.12
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 21:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Es0qMr2Eg/Fp+0sKzhhZ+bXkMDYJkRYemlg0bu+ETrI=;
        b=Uc9MtrfWwsNiOIq11phUKaYsWI4u8PleHCC7oJRlflzxmrCFavz8SGcrY9YwSTKVUM
         WKOCAgcmtDYsdxRL1owvfSNyxv9UJ/m56LnsJ16zCGrEEq+SEpft7yfOVtgF5boBejqS
         1bbVVqtyKnY6iRtm/QdN3J3j360WL+5L+w7gEN+G8S1G4Bg575/cFq33BC+AWzVzfNzX
         p/4+mIXO4MVYebhRQeDm3/cQHD5d7/RKE4t58ccvsmu3B9u0joIC7hthuEghdPXjurBB
         mOYUIQpWTjfFIZqsoqpCL6TaD3pCKarTswfy9RyQaNtRuAC3C7LggNtYC+qLFZScDTKx
         gVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Es0qMr2Eg/Fp+0sKzhhZ+bXkMDYJkRYemlg0bu+ETrI=;
        b=TVpgDCvdtkOy9VfNzyoI7vw+7+aNlZggB/dHg4YZ6Qfqb0vGqBZc7ZNLRps8ZgTDJJ
         hQ9VEVg0ry3GWkOXJsFplIbF5e33LSX99iTeMzXrbm0A5zMXTraSL664K7w3z4OC+d3Y
         zMPXipctu8vEkrR7pu4e1zxLwW4PWsKLgyd07J3wb6pmFUt0+Qd+4G9FLzH1or9bA6SZ
         5uddyfbL5ARTd2t0Y/sraMRsZS/ISb16MpspU5k0TWZVM4JyNU5Y5lghGTVVJpd1xmYb
         iL2h7vYHQ5tPmoFZ6CPoRfTRe+MQ21M5rbGfBequ7KjQXHatdZfzT/g+IpoFrfE46VvI
         Pe/w==
X-Gm-Message-State: APjAAAUv9gq0tm6PLxEHtWJeb57GMP7EhnVsSPXYG92Z5NQGLPqWLLFK
        d5gdF/ED5IUxzNBOnpQ3xBVSChdV
X-Google-Smtp-Source: APXvYqzBrQhk1OJ0cyCeeBEzJnjbmj8ri9x60K9qh3w0W4+UV2rd6E4/rAwuCBCGFJw/bw3Zmnrwhw==
X-Received: by 2002:a17:902:59d6:: with SMTP id d22mr1582524plj.307.1551677214813;
        Sun, 03 Mar 2019 21:26:54 -0800 (PST)
Received: from [10.5.50.129] ([106.51.79.180])
        by smtp.gmail.com with ESMTPSA id j20sm6875338pfh.141.2019.03.03.21.26.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 21:26:53 -0800 (PST)
From:   Umang Parmar <umangjparmar@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [GSoC] Query regarding microproject
Message-Id: <636CE77F-B137-47EC-A39B-8D70B8C15A22@gmail.com>
Date:   Mon, 4 Mar 2019 10:56:50 +0530
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I am interested in micro project "Add configuration options for some =
commonly used command-line=E2=80=9D. So can you point me out to =
implementations of some current commands which have configuration =
options and also for which command to add config options.

Thanks,
Umang

