Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400CA20401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbdFNLpk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:45:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34645 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdFNLpk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 07:45:40 -0400
Received: by mail-qt0-f195.google.com with SMTP id o21so39880583qtb.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 04:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZStsIDbUp1E7tiawKY5bQ4KVwTvJYb5DVtFcEw4Pha4=;
        b=Ho4+35GL/00mY/uZv308PZhp5hh8ENmwjCtNKM9u2c9MDSBmWtihFOGRPOyLhL9UYp
         7e4Msjk8ix8nRLRKJkDE9qnMwLtF2JgEVanEnuNF+q3UOrDVMJQ+qBF8u7DkDYPhoC71
         KNRloy0GYXT/Qywr+LAejRuzefrqi+EnSFxSGQvHKPDJ2YNNr9PCjyZqDKFU5ZWVbEs8
         h7Fk6AfW7VzM2lqhzVm9GeG1fMBFSh+t042FYc9/Yn/oJB61gcNdT5nyGYVcrwg0BFC1
         x4bqRIaIg5FbNNxbN5DNUwdUkdSW6PV8tL/tmKDZyys47PYVQs2vNUjIRz7kcs4Ja1UK
         humA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZStsIDbUp1E7tiawKY5bQ4KVwTvJYb5DVtFcEw4Pha4=;
        b=RrhYOY03K9zTcl258eP2YdedAFFsY7q7oMnzLhsEyAQRZV/7BXmDLm/EG8h/ivdJOS
         RycusRs4FCUmxZ/GT3/Joh4T6FCXQT5zreFJK1yR8a0gpexTXU4cpk+lpvwcQ8cqFnOE
         5wQ33Jy0+T/5biYwHRyK2uJFJfHoKBKlFVCbXIHXOV0P192xME0/imL0pZCUnn71tVvV
         q+R2Wv+2+C6+D8g4PUUsmmhQQsGtKKnRgxnYXd5uuW5SBBvMaY+Pi7wMpTZzPJxtAonY
         /7nUHyvN1HtZfnevbNx8JHkR5Ud1ww1eNbZ+r3dBa03yDdwXGjsGwTHS1/9L0/BT//JK
         pdvg==
X-Gm-Message-State: AKS2vOxlNaAOkh9aeRJ4TmlQgthfy5wLDSVXX5zlCa7R3tzsHyRMbIXX
        +H67KIyVHaHbHX5gXEnYrcmS3rZivPH6
X-Received: by 10.200.57.228 with SMTP id v91mr264044qte.116.1497440738853;
 Wed, 14 Jun 2017 04:45:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.162.85 with HTTP; Wed, 14 Jun 2017 04:45:38 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Jun 2017 13:45:38 +0200
Message-ID: <CAP8UFD15WKRnYktWBLyKkJ2yTrVHxdNNPe=EmUgSWv-XZfYuPQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 28
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>, lwn@lwn.net,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Rannaud <eric.rannaud@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Kevin Daudt <me@ikke.info>, John Shahid <jvshahid@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 28th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2017/06/14/edition-28/

Thanks a lot to all the contributors and helpers!

Enjoy,
Christian, Thomas, Jakub and Markus.
