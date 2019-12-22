Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E861C2D0C3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16C9206D8
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLVAHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 19:07:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46156 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfLVAHA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 19:07:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so12880720wrl.13
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 16:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1R5gZarPdPVKIc52+j/VloSKyWIARuABYuoPI7Jfbsk=;
        b=Na1MwICZpwQYxrGqjpKFVzAPyYesJcXP9tM/k8v2wGAO4j/O1zqIvlYOuhzh2ECHrS
         hcDJ3u/E7OXcNCaLUIPWdbOkJ91wI5qLt4bvgwLHKAhpSOxeJksMhsSxLt8gIaFW1veD
         DGUN+K04ePGL/iXRotrQZY/JOSUnu42WZgEwSGcm06qmitub1wMBaKTWdY+PensZvR+V
         qizcK/wuLQ9KBhkyCJsyxqKgjT7PAriMCe244MJoVJg5pH0JmjJ6VokeW72orVUYAToK
         87RT0jQXCEjJ8tSet5QFZzYz35/HnJzj9IIZgvznA2mgnJdQYT4w1OMESHAM/JGVtK/s
         x7lA==
X-Gm-Message-State: APjAAAXe2aT7WotKe47A6HniwE420Uz0Ss9jIlms6dCrhne3OAI3w/cz
        39x9NzoYOVarrHtXRd9PIyoKzVOrecw6vZFZtYYF+aVu
X-Google-Smtp-Source: APXvYqxyGJvf00fq3TTeaKiuFAMCuI9y/uqEDSNTYG8FjlIxyKgtTldIcXaFsESkhxYSqnH8A6d1WkBEZc4VTsdwpo0=
X-Received: by 2002:a5d:528e:: with SMTP id c14mr23477866wrv.308.1576973218637;
 Sat, 21 Dec 2019 16:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net> <20191221194936.1346664-11-sandals@crustytoothpaste.net>
In-Reply-To: <20191221194936.1346664-11-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 21 Dec 2019 19:06:47 -0500
Message-ID: <CAPig+cRtAZs=OH8GphXpy-TU7B28iW=VM2XPdJ3K8drQdoaFFA@mail.gmail.com>
Subject: Re: [PATCH 10/20] t5319: make test work with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 21, 2019 at 2:52 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This test corrupts various locations in a multi-pack index to test
> various error responses.  However, these offsets differ between SHA-1
> indexes and SHA-256 indexes due to differences in object length.  Use
> test_oid to look up the correct offsets based on the algorithm.
> ---

Missing sign-off.
