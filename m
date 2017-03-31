Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7B431FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 15:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbdCaPku (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 11:40:50 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:32998 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933114AbdCaPku (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 11:40:50 -0400
Received: by mail-wr0-f182.google.com with SMTP id w43so109620123wrb.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LJrG2zOSWhb6ZXSSojIMEhCHw+ggxL8haSjUQwiWj8k=;
        b=o96H2bEybKU9ZT6SBwItsNZer+bP/GTNo4nyGG/PajU93aswNBc70x4Kr24pW7BOlR
         AjnRdEWWdtIMnJkWvD6NNlXL4o8uhk/FEHhAcR0/USRDtTbykOaAkvUtfuRXE4+DEZZn
         eM0Ljsl/1+Cty5AX5QQsNIF1u8yp/omh1zBbeAjEOF0c1ExQV/EW6gNLUxnsLjNiXsWf
         bq1p0I8NSc0SSkBOI55BHDPjhI9hR3wOzddgYD4MLOM2c1EFnr7D446DcJ999u2kKLN1
         FxNlHDv/SLx2gcD0PbdtMP3GsjQ9hApG/3YrZG6nS5ml1y4Ornx0ALw93aEK3yHOItBq
         0zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LJrG2zOSWhb6ZXSSojIMEhCHw+ggxL8haSjUQwiWj8k=;
        b=cq9rKF5WOBGXQBOHhtXmt17L54GaNAGAFGtvleCDxJV+teiUDrZUMvv3UA3n5Jzc55
         LrNJHBuKf3mYoQf8l6LC8DCYN4M1xMft/0jsUelKX0Ryd/FyVBGRiZUDvRuV1EEcc0y5
         q9ztzdLa3IjmEY0SpodqNsuhm21qm/Q+37aJUbu4/MLNnFpkaK8ssjd/2wda5KnLQVNH
         G7ARRuZbPgQItEV/tS8bIYYgFn1WKYwJDaWQ4anDaww4xq1jaqPmfNRjomoJefeYMx/U
         tlgtlIM+5fd2qKp3+Xfu7mcuNk7DAK8apZZfPvoe5bQD4OjwvXXP3JyVK6gEEiehMfKN
         c6qg==
X-Gm-Message-State: AFeK/H20bylKpcXibp478p9OLMUwwLyPZ3GhZoFHOlOcBWuhrIZygSfQneUyBEsGgVNdtPdzT05JmOvlZOIGgw==
X-Received: by 10.223.139.142 with SMTP id o14mr3698230wra.9.1490974848099;
 Fri, 31 Mar 2017 08:40:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.135.109 with HTTP; Fri, 31 Mar 2017 08:40:27 -0700 (PDT)
From:   David Parrish <daveparrish@gmail.com>
Date:   Fri, 31 Mar 2017 11:40:27 -0400
Message-ID: <CAPd5SoV1F7MMDSRGzrd-7soty=61vnumQ02UtBJs2fwEyv+V3Q@mail.gmail.com>
Subject: git diff --submodule=diff fails with submodules in a submodule
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I try to run `git diff --submodule=diff` in a submodule which has
it's own submodules that have changes I get the error: fatal: bad
object

Let me know if you need an example reproduce the issue.

David
