Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440151F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbfHHOTC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:19:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34896 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbfHHOTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:19:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so2629318wmg.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mMLAYOINYdxl5pm247RTLgrP3gxVkmoUAR8gJCki3Ck=;
        b=i2NOcWBnTlymvyTlxLnlWGrY57tPI5vD30017aUXxAT8G9TiFzi7FOgLDPa8zgWfcI
         vGqsdaNrwg6O/ZeBrWk87U2UwTv8btVHSTBU1dAbOWsZwZ9CwO+w5RlNYQTzHtfzbP0M
         CqtgTR9K0HZAT8100OP1E1lt7MMaZel/ITR00NrU/6f0mglJdIDk5Bal2gP00kv71RiM
         NbIr8VzonvgcByvioHhKzPBqJHQrf9LiK7GfbnpZwS9hYekqDiy1jpeXKGFWTjasv7Q5
         zkQ9AjjjYVyC2eVrY9jAzznIvnBQR8MHgIPg4LSzf1i10QcUboZMUV+cXYYGU23Tqmvf
         GitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mMLAYOINYdxl5pm247RTLgrP3gxVkmoUAR8gJCki3Ck=;
        b=ZDG3k4a+6V/yDdayd69XB3oEvfRxvefLofu4OMq2quSf/u1WLWR5OigtjHO2BF3Ix6
         RqZNE+eyPnZd8gl+Eobch1KV+lESNncUUu4nqMXSibuv6gyCi7lIuos5mV4E2Go7wOzn
         YacAPqLFDullVQizLk1bhhlTCU9xcwkKqJk+p7ZzDk/LAb5AQXodlvRbVfW4nFljA2RU
         r7x9P+SeUEiTsg0PmM1hhMiiYK5MPcszSRmGpnDBdw5OiPdRiXKHSRA5/YS0zmPqy4Cq
         TGATnsUuE9diniGwxs+lplbE4Y0+mljrtA8Lfhac3tR/bmutA3FE4elI9yEqCQoi23Tm
         HXuQ==
X-Gm-Message-State: APjAAAW2NFPGdLZxLzbmueJ0L5xPaqdhHj2zGTHbrM5sfigv9i/Rjb8N
        pJDJ+FWqjmUW4QCGUAp1QnpbTM4t
X-Google-Smtp-Source: APXvYqwPhiHCKT7gEx8gWfHrejTR+MfX8iKSLFSHHZmS0ySETkNoqwnl6XLVU7qkKj5wbeOuoC/n/w==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr4607854wmi.16.1565273939584;
        Thu, 08 Aug 2019 07:18:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm2415893wmc.36.2019.08.08.07.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:18:58 -0700 (PDT)
Date:   Thu, 08 Aug 2019 07:18:58 -0700 (PDT)
X-Google-Original-Date: Thu, 08 Aug 2019 14:18:51 GMT
Message-Id: <pull.298.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/7] trace2: clean up formatting in perf target format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2 of this patch series cleans up some whitespace and column alignment
issues in the trace2 perf and normal formats. It also removes some dead
code.

Jeff Hostetler (7):
  trace2: cleanup column alignment in perf target format
  trace2: trim whitespace in region messages in perf target format
  trace2: remove dead code in maybe_add_string_va()
  trace2: trim trailing whitespace in normal format error message
  quote: add sq_quote_argv_pretty_ltrim
  trace2: cleanup whitespace in normal format
  trace2: cleanup whitespace in perf format

 quote.c                 | 11 +++++
 quote.h                 |  1 +
 t/t0211-trace2-perf.sh  |  4 +-
 trace2/tr2_tgt_event.c  |  5 ---
 trace2/tr2_tgt_normal.c | 33 +++++++--------
 trace2/tr2_tgt_perf.c   | 89 +++++++++++++++++++++++++++--------------
 6 files changed, 90 insertions(+), 53 deletions(-)


base-commit: 026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-298%2Fjeffhostetler%2Fupstream-2230-cleanup-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-298/jeffhostetler/upstream-2230-cleanup-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/298

Range-diff vs v1:

 1:  38b53da31f = 1:  38b53da31f trace2: cleanup column alignment in perf target format
 2:  834ee95cd2 < -:  ---------- trace2: trim whitespace in start message in perf target format
 3:  d2f7cf3908 < -:  ---------- trace2: trim whitespace in region messages in perf target format
 -:  ---------- > 2:  db35099712 trace2: trim whitespace in region messages in perf target format
 -:  ---------- > 3:  09dff12a7d trace2: remove dead code in maybe_add_string_va()
 -:  ---------- > 4:  d5b5a70c1b trace2: trim trailing whitespace in normal format error message
 -:  ---------- > 5:  5059776248 quote: add sq_quote_argv_pretty_ltrim
 -:  ---------- > 6:  bb64bb2513 trace2: cleanup whitespace in normal format
 -:  ---------- > 7:  a6e5e7c70b trace2: cleanup whitespace in perf format

-- 
gitgitgadget
