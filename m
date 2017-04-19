Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209481FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 13:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbdDSNNw (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 09:13:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34946 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934448AbdDSNNu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 09:13:50 -0400
Received: by mail-lf0-f66.google.com with SMTP id i3so2382585lfh.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 06:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WdvZo92ajGlElO7ug/p5ntUv1yzimUudjgbS+bM+fKk=;
        b=strkUbaY3oTj7RjUgtI/14u7eNfZZ9p2ea7y7W9t9s7lG9KRhItGeJn31pDw01IPBo
         uTRAjn1k5xnQ0+zEGvt6BJxo7rIAMMEwefvekMzeythLIpylLHlauUxFo8Q9c9wkHwcb
         05hZWgtQqmoEDwHPouRvhyYYaqqW1dYgMsL8I+tFSP052HNzjPVgnk7ubC/F+NkXp7OK
         Sg9ih3rXDhc9QgkHQrwYfJRNd4GEUnmujr01jye94U6EMtTnJ1fub9sJauAFeXbOmEGm
         Kpovs3u9BItNCFs/ksJqxc7cK/GHI878s+goLNI+pq9BsDOz/Q2fXvTXdLkAmMjsu82W
         kexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WdvZo92ajGlElO7ug/p5ntUv1yzimUudjgbS+bM+fKk=;
        b=JOkkfO9XVWdeS7tLXrd1QgsuJPHVHRxNXCTV/ZlALRXls47T+3zOwj/twpAuF1O9fG
         X4L73nvVf+IyPIymRSytcKODHzIQKf6GbgQcNFGWTqYAvz53uBU1Hb6tPJXIY7JP/C8e
         Wz+LLmhISF+JC9DvpgTaIhtbWZq0dJyVbeK/2/q0FTiDoXrEWwpERjYP6+VSmYVq7ZPE
         UlyGfo1XF4V3ZUd5iR+arcPhXDtlrpReTgozP0/AE/2Phq6ddI8DGwC6xNmIFTT/eZUe
         ZLCUCyUdNMjlZwILFiZDrpDHV5qEWo7zy/EsN4kSo5G6ox27+kKSAk6ZJ/HCm78hlmVt
         mPZA==
X-Gm-Message-State: AN3rC/6sZb23Xz4cRz/oubww37t1kRYKwA8DBx43pb3By8Fl36L+d6sa
        f6KazzFRcbe/eORv+4wnIwSsLe/wug==
X-Received: by 10.25.196.77 with SMTP id u74mr1060714lff.81.1492607628487;
 Wed, 19 Apr 2017 06:13:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.67.78 with HTTP; Wed, 19 Apr 2017 06:13:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 19 Apr 2017 15:13:48 +0200
Message-ID: <CAP8UFD2Uj2SEZwy5KO8q0WQmGi505esmAofOXr+Lq9KYs6H+rA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 26
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>, lwn@lwn.net,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ted Ts'o" <tytso@mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        Werner Koch <wk@gnupg.org>,
        Peter Lebbing <peter@digitalbrains.com>,
        Christian Neukirchen <chneukirchen@gmail.com>,
        demerphq <demerphq@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 26th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2017/04/19/edition-26/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
