Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A2BC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiG0UDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 16:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG0UDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 16:03:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15AE5A3C0
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 13:03:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z22so22806069edd.6
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=V9VzEJ4MuJzXFFaYHnrpjV0o+H780lhhkmoMqKmEITM=;
        b=Mz0ZEQT23BJuN2Zhn70HcI9x7D3iEF0fUXRvKSgwd4kOlWAm1bcIrfH2h/o/FPG3la
         V+Ns5V8Rl29osxEae86Z3waQtl8RYDrJMWZlYXbrP5+e6+ujCFCPUvRnUXdyctcKl0l5
         uvWYAY6munGdokg2SS3tLTMgbRgJasrnpOYU9VL9XyMDe6RM1kqqRLgQEXpOnHwIKRgE
         hhoF4Q38NiTa6TPKLDXZv8zwe9ZOHCmFA/fYDhg6AyMlKtrCOcxEwf2NkXrGITYMh84M
         BkhaPjtv1jorZLdgcBC4Cr7PQx/zuCIed+lS8PJazfLJew95lx5JmjEl1N8x+LtDnajN
         0d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V9VzEJ4MuJzXFFaYHnrpjV0o+H780lhhkmoMqKmEITM=;
        b=aIZCnBBFLUke+FbpJRfg7v07oZe9U5dwXKKhWj17bS1Ll3jXN3Lnw70EBuBg26QbA8
         lXWnesDTAhJXz5IBQpFaTQFWLPohBEkY2NX/msEURZZOfo6aKMvZYqqLkuAUTjT6XEoT
         mx7fWOD4oqlb7GsMLB/3epZDetEF82T1ShmmOYllyjJP+OmXDipRVfAm+MfNB6lLOM+v
         mb1dVopYUQLntakXfVodyzLHy9p+UEaLl9gDvCa+I4a7vZZiBrFrt7GJ3YB6wNRZM0/4
         CBRiELe3g/egjP5d2n/P+R6DOG+wjqCaSQqE5IhHdRbnJLvy2ZSSwFh+BfzGmy8/QQNG
         PTiw==
X-Gm-Message-State: AJIora8y9kSjgOS3qgytmaFA/H4LkCyDcckFlYbx0REWpeogKbeTi5Lf
        NkfJM60O3eDpVIa5C+WYVeKGnu2UOl3oE6xEwu6SLRt7Fs8=
X-Google-Smtp-Source: AGRyM1s+erGqCn/EvW8jSfRc2vQ2sXtC8cwIo8llOa9teFz47BLhQqyy6IAtzohK0siLCSAbLcH+c6uHpi7OGjuHuwc=
X-Received: by 2002:a05:6402:5508:b0:43a:896e:8edd with SMTP id
 fi8-20020a056402550800b0043a896e8eddmr24818498edb.203.1658952226047; Wed, 27
 Jul 2022 13:03:46 -0700 (PDT)
MIME-Version: 1.0
From:   Eric D <eric.decosta@gmail.com>
Date:   Wed, 27 Jul 2022 16:03:34 -0400
Message-ID: <CAMxJVdH6=dP7vwruSnKFVTT4ZgygLK_2fu5TKoRia+WyMzATXA@mail.gmail.com>
Subject: fsmonitor: perpetual trivial response
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsmonitor daemon was started in the background (i.e. git
fsmonitor--daemon start) so I could enable trace2 logging.

15:36:37.860862 ...n/fsmonitor--daemon.c:969 | d1 | th01:ipc-server
      | region_enter | r1  | 124.965540 |           | fsmonitor    |
label:handle_client
15:36:37.860862 ...n/fsmonitor--daemon.c:970 | d1 | th01:ipc-server
      | data         | r1  | 124.965809 |  0.000269 | fsmonitor    |
..request:1658950597810367000
15:36:37.860862 ...n/fsmonitor--daemon.c:786 | d1 | th01:ipc-server
      | data         | r1  | 124.965892 |  0.000352 | fsmonitor    |
..response/token:builtin:0.12336.20220727T193432.938608Z:0
15:36:37.860862 ...n/fsmonitor--daemon.c:822 | d1 | th01:ipc-server
      | data         | r1  | 124.965969 |  0.000429 | fsmonitor    |
..response/trivial:1
15:36:37.860862 ...n/fsmonitor--daemon.c:974 | d1 | th01:ipc-server
      | region_leave | r1  | 124.966000 |  0.000460 | fsmonitor    |
label:handle_client
15:38:40.079662 ...n/fsmonitor--daemon.c:969 | d1 | th02:ipc-server
      | region_enter | r1  | 247.186960 |           | fsmonitor    |
label:handle_client
15:38:40.079662 ...n/fsmonitor--daemon.c:970 | d1 | th02:ipc-server
      | data         | r1  | 247.187067 |  0.000107 | fsmonitor    |
..request:1658950720017776200
15:38:40.079662 ...n/fsmonitor--daemon.c:786 | d1 | th02:ipc-server
      | data         | r1  | 247.187328 |  0.000368 | fsmonitor    |
..response/token:builtin:0.12336.20220727T193432.938608Z:0
15:38:40.079662 ...n/fsmonitor--daemon.c:822 | d1 | th02:ipc-server
      | data         | r1  | 247.187448 |  0.000488 | fsmonitor    |
..response/trivial:1
15:38:40.079662 ...n/fsmonitor--daemon.c:974 | d1 | th02:ipc-server
      | region_leave | r1  | 247.187491 |  0.000531 | fsmonitor    |
label:handle_client
15:42:14.719673 ...n/fsmonitor--daemon.c:969 | d1 | th03:ipc-server
      | region_enter | r1  | 461.821373 |           | fsmonitor    |
label:handle_client
15:42:14.719673 ...n/fsmonitor--daemon.c:970 | d1 | th03:ipc-server
      | data         | r1  | 461.821429 |  0.000056 | fsmonitor    |
..request:1658950934652816400
15:42:14.719673 ...n/fsmonitor--daemon.c:786 | d1 | th03:ipc-server
      | data         | r1  | 461.821467 |  0.000094 | fsmonitor    |
..response/token:builtin:0.12336.20220727T193432.938608Z:0
15:42:14.719673 ...n/fsmonitor--daemon.c:822 | d1 | th03:ipc-server
      | data         | r1  | 461.821486 |  0.000113 | fsmonitor    |
..response/trivial:1
15:42:14.719673 ...n/fsmonitor--daemon.c:974 | d1 | th03:ipc-server
      | region_leave | r1  | 461.821497 |  0.000124 | fsmonitor    |
label:handle_client

Note that this is a slightly hacked build of mine where I disabled the
check for network filesystems. I also added some additional logging
that tells me that the query is successful, it's just that the
response is trivial. The sandbox I am using is on the network and
being accessed from my Windows VM.

-Eric
