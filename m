Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DA3920970
	for <e@80x24.org>; Sat,  8 Apr 2017 16:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdDHQHW (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 12:07:22 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37336 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdDHQHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 12:07:20 -0400
Received: by mail-wm0-f46.google.com with SMTP id u2so10812167wmu.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Jo4XAOnV17xWsO7Xg0u84Ea+6PCGUS0Hi9zzDQ0CDJA=;
        b=kho6VOwEHjNHGMV1KM1Smd3ep6vdyoZ88c0aKgC63zXq+a3/6/LP89/axVVGnlqFZK
         I6HBwVc48mf4N211I/W2kMVR+naudrqa1RbHY/l5xWXhh5z/FCoMs/Cudb6Hx6x5jtPk
         w/bAOvKFUcoDX4J+Fmeu+VxISqcg7fxc3k6jbD4dUwj5cNDf2aa8hLODpalJKuEAWlgQ
         klDD5sL5Qsc9zK2h6L4d3uWuk3Xm+fmnmG/fEvhefmMLG4u0Oe+jXNTqDEBQOhcpnq7d
         0y5EMvFBhEKNlHJxxmupDDJXiURsOWBfgTDUVcNiGXxRSZne//LCDqQcJJT45xa8QR7u
         AUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Jo4XAOnV17xWsO7Xg0u84Ea+6PCGUS0Hi9zzDQ0CDJA=;
        b=Ta3yx/ijv2Rcbacwgq2kGQpEFeokfhE/qTTXxR0JaFHhWfvcaRC7D5WJfrquEPKoW5
         z1ecNyAem8KkcWMdBCoABnpnyK63YqGfqmcIHm7FPFuswfK5zqR0xnnJ0vXAunIUif4I
         Fg/UWq54MMFjOfHpwbMFFspYYnRSxKZ1aVNWj+GWxQ231IDJvQ7pUfZyoCcoOdNaxbUI
         Eau/8r2zz/ubjbiRAUoTBGLn4pPw3OV7nslkaHx6elJi+sidC/CSshseqQ4sF81ahT9N
         98DMxPkCG8GWatNbRatIW2ldNER1ijDRxOTFSxHtUsspRaooqx8H7MG82WF4apEoESmp
         9ksQ==
X-Gm-Message-State: AN3rC/5QzkmhOMNGv6gWh7tqazI1SkdiIxq6qAVnvJdfXKdWXDvW4R39
        L6UMvVf1H38SxM9Mcwr8jQINoywqFSvS
X-Received: by 10.28.227.133 with SMTP id a127mr3544042wmh.93.1491667639023;
 Sat, 08 Apr 2017 09:07:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.141.89 with HTTP; Sat, 8 Apr 2017 09:07:18 -0700 (PDT)
From:   "Fred .Flintstone" <eldmannen@gmail.com>
Date:   Sat, 8 Apr 2017 18:07:18 +0200
Message-ID: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
Subject: Feature request: --format=json
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git log --format=json
[{
    "commit": "64eabf050e315a4c7a11e0c05ca163be7cf9075e",
    "tree": "b1e977800f40bbf6de906b1fe4f2de4b4b14f0fd",
    "author": "Tux <tux@example.com> 1490981516 +0200",
    "committer": "Tux <tux@example.com> 1490981516 +0200",
    "message": "This is a test commit",
    "long_message": "This explains in more details the commit"
}]

This would make it easy to parse the output.
