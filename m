Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848B1202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 21:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934013AbdIYVOV (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 17:14:21 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:49060 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdIYVOU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 17:14:20 -0400
Received: by mail-wr0-f182.google.com with SMTP id 108so10135842wra.5
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=O4zKUlxD5sXxDjtq1C0M3+88iH0b0Y8IjQKisYHr/Us=;
        b=KakeoGWnqdOhfNa4ozUAVQoHIBowk0m85f5IwBlGp1F3FLwFJUnXSxuafWBtj+8IpS
         sMkqYI+Gxd6wwDmJJORxbgLx3uazlFLfQV7IChpJWV6ZqX9zNJpFu/VQYDIOTDA0h5h1
         C8Nb3dxx8+BJ1KHCYl++szeu/MxerkI8kRY3IMoJtpUVk0w4lshNCLNAdKjTocK8zRIC
         Jn+38sOF6UW8g4w+vwKtc7HJhaCMGHemXYkIKMzkTlHaXIfsZvRdat0Il/1mne0cl3o5
         cYxvs/N8sgLPs6uMsF4LTfgu79h9nFyY08ikQEmBKuBubnwOZKsO/t/N70VKRaeASJnB
         l1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=O4zKUlxD5sXxDjtq1C0M3+88iH0b0Y8IjQKisYHr/Us=;
        b=JXBgOEdMfFyBO93ykWWMTtPKe5G3gc4YWNBKguad+XM4QvwgR+ixGz38YMBkTl51Be
         7uuswjj7g4w5YkCv20PBUcYMKm6gWkIlVyDKHj6hJQzkQdd9pff2QgBaDT7A+J+YjNB6
         RGftFcvY0IspHqhWpT2ApQ5xnMXtqg6tHneEwdVUxSlEd7EFmSM5jwFmbI8kjSczUDAq
         rRKU9d0w3aqZIB5RxG6SIr5ZVeoPjIaFy6h/0x38Ehi64ciNWBhxita1+RsF7EB3Ix49
         G3LDdhzDS3VIYUgsDBI2Hjy8US7gYbVHFj59FQ3ogzhAL+DROoKXYtFoZ8Om6bAdNq3v
         5ceQ==
X-Gm-Message-State: AHPjjUh0kVreEDmg71YYlL1JmhnCpMZInkWB3bYXcmw7qvTSpICT9bWj
        c4AIfA+tlKYK53Iu1EBA6tduRfuT
X-Google-Smtp-Source: AOwi7QCqUL74CT50WR1Ud/+G2BOn02uDm+U3VnEp8D8jmI413Y29jMYxJxjh04f9I0MN8pdfCf+U5Q==
X-Received: by 10.223.145.5 with SMTP id j5mr6970924wrj.114.1506374058998;
        Mon, 25 Sep 2017 14:14:18 -0700 (PDT)
Received: from [10.32.249.241] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id j73sm650202wmf.15.2017.09.25.14.14.17
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 14:14:18 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: macOS Git installer on SourceForge
Message-Id: <31F80F26-5EEE-440B-8E5F-A7E1403B75EB@gmail.com>
Date:   Mon, 25 Sep 2017 23:14:16 +0200
To:     Git Users <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

one of my colleagues made me aware today that the macOS Git installer is=20=

hosted on SourceForge and advertised on the official git-scm page:
https://git-scm.com/download/mac

SourceForge had some bad press as they apparently bundled junkware in
their downloads:
=
https://www.howtogeek.com/218764/warning-don%E2%80%99t-download-software-f=
rom-sourceforge-if-you-can-help-it/

Is this a reason for concern?

Thanks,
Lars=
