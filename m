Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E391F461
	for <e@80x24.org>; Wed,  3 Jul 2019 04:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfGCEeq (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 00:34:46 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:40470 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfGCEeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 00:34:46 -0400
Received: by mail-io1-f47.google.com with SMTP id n5so1624806ioc.7
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RR1vtALeuLaj8Q/xVieJ6ODo3MS8Uc+sgDZFn+dmamQ=;
        b=n98OOTaLocTiFsXI98Qj/oYvzOLF/KGvT9IZRZV3Sg3xRvgn3UBnRUyrnadjeUeGPD
         dSrLyfoTvIp1AKIkvNE/sSJ/0pelePbjoWm07RI2R1+j7YyRBMtHCCu6q1KYJkkhrdUX
         g24fEJxh+GV1MSC0Px4fwAQ69UAI/mSHVCR6WU9HMGO0FFT9ARKZORSWrIAWa49qa9BA
         ALrDR2vW2W41Oss0Jg48YyrHs4ODaMv1O+3D437flNmgTKgVvk/RMDVxpc7am6jLT7zk
         qgfHLZXoDalasRhOOlQPBJYFO+GhUh5hnnpa7Md4MH7eKajng7P6PbQZm76cas88xZk9
         vZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RR1vtALeuLaj8Q/xVieJ6ODo3MS8Uc+sgDZFn+dmamQ=;
        b=efdaOCyh5FZ04MMOGUr/6pBS/ME2RhFd8jtrxnE6FYNKibtEzm2dDQLQ+ZeHp01WRk
         2hCvMFyVExxoII4Bwx8g0JbvE/cZFhfteFG/cU6dG0WvmIF1ezNdK6ws534dNN99wfbq
         f8BXR+SDyfPT7WC9ieJO+3C681GA0jokht4EN3rtz0oZgUU9/0c6XQ8dcqjJ5e4dmWPD
         DY+p382UPEDWArstO2RyTdxyKvKqITU/Erg+zH2IWx1hTdyIgQcLK3N/N+p/S4KYAwcC
         Z8sfcsax3betIgKhH7gvHZf5NncJBcGNXcrOkuOf6iaOQsVPsnt2KMpfQWfzZyjnwWi7
         O6jw==
X-Gm-Message-State: APjAAAUMMG0VMGGEyqLpbZXz4hb8DxBlxBCzsjtcyGEv9eYWrn4+idnE
        bCJJJ6Vgz83RzCGMzZ1dYaXuRoIcfHPZtszaZUveU70yzVg=
X-Google-Smtp-Source: APXvYqwnVbwUEMCTl55N5T0CcRNCraBpNpv3j6hkJjtlAQCWQHVhXHgiz7HPaDz2XhYP07ctcWSYOMZLChOlA5/QgNs=
X-Received: by 2002:a02:c646:: with SMTP id k6mr39667536jan.134.1562128485558;
 Tue, 02 Jul 2019 21:34:45 -0700 (PDT)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 3 Jul 2019 01:34:34 -0300
Message-ID: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
Subject: [GSoC] My project blog
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I've been posting about the progress of my GSoC project at
https://matheustavares.gitlab.io/gsoc/ I should have sent the link
earlier but, please, let me know if you have any comments on my
previous posts.

You can read my latest update here:
https://matheustavares.gitlab.io/posts/week-7-race-conditions-on-delta-base-cache
I've been working to allow parallel decompression when reading objects
for git-grep.

Thanks,
Matheus
