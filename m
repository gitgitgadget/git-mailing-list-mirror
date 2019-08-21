Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B05A1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 04:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfHUEEv (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 00:04:51 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:34623 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfHUEEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 00:04:51 -0400
Received: by mail-yb1-f169.google.com with SMTP id u68so487329ybg.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 21:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Cwx0p1TKxiAKSNXXzWTNfc0UIJKMCJ7cMZ0aCAErrLg=;
        b=HFHi4HMDrT3TWoY9sgvSeIPsGH9HbUz0begVrDekrTAQEdlfB7t5tl4qCO/abXseBr
         APPUMzrsbKA1ENWIoHZTevFADzBjerMyKQsru1XrfiZ9U9+26XzckMC6nydg3IWZ7AnA
         0vQyS6Vyw6t/yLgwNIWBrao4lqMDUud0BGzacWDJaR+vovKSohESU3lDNpDs5o2ZMnA+
         WMi6DgXEsuN4Gnd291mBQasm8T4xrQO2k7mWANTtZT1+0SHTa7No15MCrlCh2WoLgR6K
         Z2sJmCU7ty18QYJSlvvPbSggdZsbrYwlUnwuQHi+GQ4SOxJlivySK3tuIa1FSfxMEQId
         VFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Cwx0p1TKxiAKSNXXzWTNfc0UIJKMCJ7cMZ0aCAErrLg=;
        b=maxF9+qfSHH7hgbN8wPW6YwG1Nqr9dmvqDajVhLSrYwXzemiEBVVK+464cGpaztKq/
         fW3Khx6pV/S5iKj7eEG0UlZS4wHwD88K/bybGQolkWNVbuPVUjE9FBjOHbgVlUUhB4e4
         fCFOkzyAQ7dNXBWK8Hk2PZoRSm9CEhvXNjdsqjzahzSxhp7xYOqEycNIy6bxjR9k8JVa
         gg93PSDv2Fa7e1YhyQtQ1CdMiR6fPXa9lrmkaB/2lDA4p81fh+jtImm8Hf0ebusCYenZ
         obofiRTosDQ6CKneu4jA6lfcu7KeyN8QV6CT7AK/uwXOE9a4XLlggQYzJZYTDcaXD89R
         OSWg==
X-Gm-Message-State: APjAAAXhYRFqIem3ucZqp/WvjBiONsJ60JiGEZmL53tSYW0uL0YvmptQ
        aNYDXx8z6EPheZKTFEt7mLzghBQceLmeFnJ2Tfprr4M=
X-Google-Smtp-Source: APXvYqy76sSIlyLu7aEuTusbNLejtucFdztBkpagHS+VjtDZclPk3f+9qwAI9bvpB0MjB/TfKEX3uTDFHvNPvSn8L8s=
X-Received: by 2002:a25:8452:: with SMTP id r18mr22584779ybm.410.1566360290233;
 Tue, 20 Aug 2019 21:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCsJ5fygkaB-=EoYC3EJ3HrBbGUW+cdsXTddUUEyBzT1TB+Zg@mail.gmail.com>
In-Reply-To: <CAJCsJ5fygkaB-=EoYC3EJ3HrBbGUW+cdsXTddUUEyBzT1TB+Zg@mail.gmail.com>
From:   Wayne Walker <lwaynewalker@gmail.com>
Date:   Tue, 20 Aug 2019 23:04:39 -0500
Message-ID: <CAJCsJ5fVFiF_GOX30f7dF4D=Fh0gu0p2wPFtCC7EJY+wpSNU2Q@mail.gmail.com>
Subject: Re: git grep failure?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore my previous email.  I have found what causes the
problem.  The files that it isn't matching against are symlinks (known
to git, but git grep apparently doesn't grep what they point to.

Sorry to have wasted anyone's time.

Wayne Walker
