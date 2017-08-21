Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46C6208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 20:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbdHUUsu (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 16:48:50 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:36818 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbdHUUsu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 16:48:50 -0400
Received: by mail-it0-f53.google.com with SMTP id 77so36621460itj.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8Y/TbUtgGwIDRzML33/02wHq7qm0jwEFXIW4Q4w7A9c=;
        b=eZctHAVNyOqqCHCPXAnc+HsCVhiviIhX/gh4sjagdG6FoVAmY473Q0BiR4Pd4motOs
         fB9KMsgT+645bh9IZ9KyB9MzX5xJJddaaqxcSS+EWozJRkRTrfn8cwGryx0TmCRoCQ3X
         xJAXhVPAnbSy/GGrDJJbL3ND4QCLSGlA3xD2QlNhcBANS8rer0lD44GNlPwi/Gx2TFLd
         BuFRBdWxzVtylq3X9hRVzT72L3bSdqERXt0jxuZnQAKv1Hy9ozQ7mwJgyJjrH64jIkI2
         YoKDQ/KiASGdMhDHWxMQo6vry9McWIE9VOrmRWORcIT4qPxZ8nEyVg/kbX84I0NXGNz/
         6nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8Y/TbUtgGwIDRzML33/02wHq7qm0jwEFXIW4Q4w7A9c=;
        b=P8qLVe0B7LXJpN+PQRupL9uu1olnzbJp+XrrPesnsNG2OuSu0hyTrSksAPYaGrHJDI
         45VB3FoNQpdx50U8aQlFjYVzruIEfv008ZsN1rpRDe2D05xIVIQuFaco+hpFjj1G0H1T
         BoByR3HNQGEkx3qO7hxddqt9DM2nPkMUFZALW5I9PVL89wXS7I4IDx3m8iWcZ3QjujeR
         bNM2IW7w5MJSoke3GCD0bBSgu4Lq4izawra7CQTvu4yqWw9vKk7vh75tBSpuvHcy8R9V
         TAfFt+i5/IJt2XD7tzuc3MzUAvuVRu1T9blNVVY/KBQt5d7/aAncvIBwPvuDjathi6wn
         uDdQ==
X-Gm-Message-State: AHYfb5j4hTNMb5InSUVLH/LrUBsuiqA97A+cgahUvxhSYX2C+lx8AHN6
        3gpFptnTlBbnpKDc1pBdDUp1SToX/eUh
X-Received: by 10.36.228.10 with SMTP id o10mr1538405ith.149.1503348529149;
 Mon, 21 Aug 2017 13:48:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.149.134 with HTTP; Mon, 21 Aug 2017 13:48:48 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 22 Aug 2017 02:18:48 +0530
Message-ID: <CAME+mvWq2tMfBVwJQyXsn2E2KJ3QFLuTkG+s_vbkYvO2Fy0ZYw@mail.gmail.com>
Subject: [GSoC] Update: Week 14
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SUMMARY OF MY PROJECT:

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script. My project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
Link to the complete proposal: [1]

Mentors:
Stefan Beller <sbeller@google.com>
Christian Couder <christian.couder@gmail.com>

UPDATES:

Following are the updates about my ongoing project:

* add: Although much time was spent by me on trying to debug the
  patch, the attempts made were unsuccessful or were
  rather partially successful (since while fixing one issue,
  they invoked a different one). After getting   suggestions and
  help from mentors for the remaining tests, now there are only
  two tests which the patch is currently failing at.
  The current status of the patch can be viewed at [2].

* update: porting this subcommand is already underway, and
  porting of the functions is_tip_reachable() and
  fetch_in_submodule() as completed.

* patches: a smaller patch series is floated on the mailing list
  for the maintainer's review.

The small patch series which recently was floated is pushed on Github
and is available at [3].

PLAN FOR WEEK-15 (22 August 2017 to 28 August 2017):

* add: One of the main aims of the next week is to resolve the
  the two tests which the current patch fails at.

* patches: will be working on getting the smaller series merged, and
  once its done, will prepare and float the next patch for the
  same purpose. Till then, I aim to stay more active on the mailing
  list as well for responding to the reviews.

Since I am a bit busier the following week (due to college academics),
I will resume porting submodule subcommand 'update' in the following week.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/
[2]: https://github.com/pratham-pc/git/commits/sub-add
[3]: https://github.com/pratham-pc/git/commits/week-14-1
