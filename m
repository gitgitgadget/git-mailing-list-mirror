Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BF61F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHKBV1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:21:27 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33475 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeHKBV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:21:27 -0400
Received: by mail-yw1-f73.google.com with SMTP id c11-v6so14925754ywb.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=z5LapM6WjuO26m7GaPXe9B0EsNoqj8Snq9X+KsVSW58=;
        b=lhqnuosHVlJP0Sx8PXPYXR+gQBhAz9/lPz6Owhh0JNELN6F3VMdmzAep6N18B1EyWE
         ++qC+4ItHkSEHNOJ56gPc3yuwyy1YgDvb6XcmFdETF91xGTQl2CYyDA7SkVNRuapB+nt
         +heeR3eliVdjoUZX15RDlzlFFiVoziXn42tUnRlOjgfgomIGGbea7g8SAPiIOfgJd6tT
         eYfZFlZ5N08RhK4nopE6/tvB6bdFXHM6dec4hQwjvGVB0rnw1YZV0KrZYGy3zBUgcCxi
         Rb78/INxcxq/CeDEFKlkt/v3E2c3i4zSJj5bzLYNPCJ0L4W4UJj9u4laz/OU7N+GqtmS
         PbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=z5LapM6WjuO26m7GaPXe9B0EsNoqj8Snq9X+KsVSW58=;
        b=eEl5ndDSdcLFmgv72EEyHfP35VE5DWAMU2DGz7pTJsY7Scl72JWkjlw9UaJzQqAksN
         58/viEMjgxmC4K+gzpvw1jp5ZB4smWAcRTjhqa25KhyTkYZ9x6JB329tUYYbes66ozK/
         UTl4LeUsw9G4rJ1kSw87UmI60LbmUTyflWgWZwEcLHdG+ZwPXTVilQHQdDtQ0dAboLxb
         83Wr/f6+tFB4QuD7sPG8j/lI9qUIYn5TWi4gxIvRDxh55m+l5SlsGf1R21MJGF1t3Y3y
         iciCz3bPC8Pa527geNH/LzM6dr91v2RoqUHumzo0CSBJu3t6rJG5GUAU0jYtISvilbZ3
         ChEw==
X-Gm-Message-State: AOUpUlE7eBY8EcndpUkfLnV9mhO5A4IWxsWf20laOuf8c1aeKxs6KbEV
        V1Yk1FlVWufxYxoEOoGVLWFBFbHicQZq
X-Google-Smtp-Source: AA+uWPy+5+ZvlEwjrTwHYaTtG5QZbOuU+BZXgkP7SpgGbo7GkxJtcUYuQrYNODHimV1x2WaiZlvCKmJRw9jc
X-Received: by 2002:a25:f206:: with SMTP id i6-v6mr2299136ybe.39.1533941374733;
 Fri, 10 Aug 2018 15:49:34 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:49:19 -0700
Message-Id: <20180810224923.143625-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 0/4] Better colors in range-diff!
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves colors of the range-diff, see last patch for details.

This is a partial resend of
https://public-inbox.org/git/20180804015317.182683-1-sbeller@google.com/
and is also available via

  git fetch https://github.com/stefanbeller/git sb/range-diff-better-colors

It applies on the (just reset) series of sb/range-diff-colors.

Thanks,
Stefan

Stefan Beller (4):
  diff.c: emit_line_0 to take string instead of first sign
  diff.c: add --output-indicator-{new, old, context}
  range-diff: make use of different output indicators
  range-diff: indent special lines as context

 diff.c                | 43 +++++++++++++++++++++++++++++++------------
 diff.h                |  5 +++++
 range-diff.c          | 17 ++++++++++++++++-
 t/t3206-range-diff.sh | 12 ++++++------
 4 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.18.0.865.gffc8e1a3cd6-goog

