Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01703C433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 10:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238852AbiAYKCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 05:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiAYJ7j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 04:59:39 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BDEC06175D
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 01:59:39 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id x193so30055948oix.0
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 01:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=+tP0Q6b9GEk9zxgdQyKmOmnHvkiJ7+MiGACkN4kZtrM=;
        b=oHOlhYZYFnG4nBLIeJUOELmPLDDeCG28S8I5HSqhN8WlrBS3uc3hLirbLCWLoETnnf
         fqwut0iy4yOrMtZNGPuDHA+yepxr74VuT2HBALNoByU9ee3u0QJEiOD4uC0lq5kzlYim
         L5YlRgB+xiet8a/qHVvHgil6LBypYYH0cOw5Z6bUnjxLrY6ws/So7M4eGPwiwpT8QA4B
         6jl4NcVD4HExDwly5cOM9xbsjU1Pmhu9B0N4WGQSQEiYbevU3FKxEoZ2oQPX4gqCYxQ5
         CkPMe05Kb3w2mPGsonRc7z1otrDQUFFutCT/ypH8BM912kOpw8dix3qeViutpuyH/ZDH
         uAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+tP0Q6b9GEk9zxgdQyKmOmnHvkiJ7+MiGACkN4kZtrM=;
        b=6Tz4C6Xkfu1lLD8KLh46RJD6/RvJ4vhBdU+rhwGVAmBVbSs+kNScGG7WpXVb8btXL7
         aDZC8HypVF68wK6qeeQd1tG/RY60MGTILVo4c2Mpkl/zl8H98QIfRSaHEhpSsz680rCu
         pWD35dfd8brkr6avss2lsyiLalQFCHF0cjB5WlZ9loxlou22v5WXQ5ZAhPy40RUJzUzJ
         SqeD7WJldcXjy6ZyyzZkCGLqT9Vpkklz2/AHQ02Ve1QnYpj8YS5Aw7UXcbKU1JeXkEqJ
         fClVMlg7Jli99XVwLcqwJ9E1LTOD48n1VnOXJFHnveE6ZbikOUDMoXcleaJl6y6uqWZO
         Ls4w==
X-Gm-Message-State: AOAM5338s6vbM+xz2ROReYU1zEldTne3VfdasfNF522KQ0osHlwXo7eY
        A30xGCBcPgNy5s92dBXScJxFOOzT3eRG+HTnP+b6J03yhdBhYQ==
X-Google-Smtp-Source: ABdhPJxmFoeI+fbjugWloSG7gfmEyirGc3wmvnYYYDbDZr8FAv9a3HHhePnoEE8o+nNG7SbzDyf/h1woeZMHgFT1c7w=
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr182861oik.78.1643104778188;
 Tue, 25 Jan 2022 01:59:38 -0800 (PST)
MIME-Version: 1.0
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 25 Jan 2022 17:59:24 +0800
Message-ID: <CAJyCBOQDBMcowKZgMp2iCbWpaMJGxNH9EtbQ8e0zB67k1g9uYg@mail.gmail.com>
Subject: =?UTF-8?Q?=5BGSoC=5D_Add_=E2=80=93no=2Dsort_option_for_git=2Dfor=2Deach=2Dref?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git community,

I'm considering if this microproject
[https://git.github.io/Outreachy-23-Microprojects/#add-no-sort-option-for-git-for-each-ref]
 is a good option for now. I want to spend some time on it and see if
I can come up with something.

Sincerely.
Shaoxuan
