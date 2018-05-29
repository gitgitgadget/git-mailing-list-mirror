Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE371F42D
	for <e@80x24.org>; Tue, 29 May 2018 17:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965168AbeE2RBV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 13:01:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51900 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965031AbeE2RBU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 13:01:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so15026631wmc.1;
        Tue, 29 May 2018 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=jE0IsQZPGwMQ+pB0GYtCzeNt1aIQwozdUQAYArI+1P4=;
        b=BwUGNuUh/qIGcLhOgn0UNeGqwBX1RcPhmP0ffx4Zk+xw3iG5Xr8UsaYll2vuzO25KW
         7B1mczRLHs72AYEPGI6E7xq2r1J1B401tWZTEqWMhayKYLmuH8BRoFP32X1kYFgNIEAE
         Dxd+bxK2NEgb2YrFjZnhA9wKiBvVdhzjpX9B1bK2rCFxE4bMBcdMHdeQRoJgm63B7e9f
         X+hVL3/+mVJ0XWJ+8pe1s5u4uyaYY4r4LAvrgCTqUWZJDcw1XOVx3WoZgXRZuxbtXn92
         Qy56Gxkffd3A6Yh4Pq6MVgwlNMIQPA9FUp2w+OkeOk34PpP1vGoOb+TPNdg/sLXwomvr
         oeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=jE0IsQZPGwMQ+pB0GYtCzeNt1aIQwozdUQAYArI+1P4=;
        b=HZP3rkQ5iXJxeUD9hCxuODwmKJKFhUN1ZtwR2CB9P1ZPb36YDFmzt+xfZMMfOzl5u9
         pxZhRuFi2fY4Z0hFmYYCoVHAzf1WiQ3BQdHq9HNzTdPw2yyQp0Mlg5h80Rv9fvoRR1a/
         OsCnNqdud6S2tD2k2tNK5xAyvJWaYURdBSCzH5IUQXzdbZGBBtWr1KLTDg/rHdlNnyQV
         qQ2tL3R3TuMbv500EoSrrbTfY+CrFZFHJL1PQElhfsDocPRo4S/ijEuMCATB2TtaJa1q
         pfRe0Qz6/EqMT613Mm9J8UbIGyDlUhds8uqx1vTFYK7U3UvdVZoeRSbMvRa0ytEVn51u
         nysQ==
X-Gm-Message-State: ALKqPwcWXdfFmruWm/F7Xynb9fnbX+lLkCCgJyvE5zDQVmz91EYq2zdD
        piKQSQeqRUY/1NWu7XKrRf6qJRtA
X-Google-Smtp-Source: ADUXVKKpCP/lio/OAwQo8nq9Q174U9hQfb84g3lwKnzLw4q1DmlGMoXfAjmSD6OIqZDw8aoyg+ezXA==
X-Received: by 2002:a1c:da50:: with SMTP id r77-v6mr10807877wmg.105.1527613278549;
        Tue, 29 May 2018 10:01:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k126-v6sm26284734wmd.45.2018.05.29.10.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 10:01:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.17.1, v2.13.7, v2.14.4, v2.15.2 and v2.16.4
Date:   Wed, 30 May 2018 02:01:17 +0900
Message-ID: <xmqqy3g2flb6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.17.1 and updates to older
maintenance tracks are now available at the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.17.1'
tag and the 'maint' branch that the tag points at, as well as the
v2.13.7, v2.14.4, v2.15.2 and v2.16.4 tags:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.17.1 Release Notes
=========================

Fixes since v2.17
-----------------

 * This release contains the same fixes made in the v2.13.7 version of
   Git, covering CVE-2018-11233 and 11235, and forward-ported to
   v2.14.4, v2.15.2 and v2.16.4 releases.  See release notes to
   v2.13.7 for details.

 * In addition to the above fixes, this release adds support on the
   server side that reject pushes to repositories that attempt to
   create such problematic .gitmodules file etc. as tracked
   contents, to help hosting sites protect their customers with
   older clients by preventing malicious contents from spreading.
   This is enabled by the same receive.fsckObjects configuration on
   the server side as other security and sanity related checks
   (e.g. rejecting tree entry ".GIT" in a wrong case as tracked
   contents, targetting victims on case insensitive systems) that
   have already been implemented in the past releases.  It is
   recommended to double check your configuration if you are hosting
   contents for other people.


Git v2.13.7 Release Notes
=========================

Fixes since v2.13.6
-------------------

 * Submodule "names" come from the untrusted .gitmodules file, but we
   blindly append them to $GIT_DIR/modules to create our on-disk repo
   paths. This means you can do bad things by putting "../" into the
   name. We now enforce some rules for submodule names which will cause
   Git to ignore these malicious names (CVE-2018-11235).

   Credit for finding this vulnerability and the proof of concept from
   which the test script was adapted goes to Etienne Stalmans.

 * It was possible to trick the code that sanity-checks paths on NTFS
   into reading random piece of memory (CVE-2018-11233).

Credit for fixing for these bugs goes to Jeff King, Johannes
Schindelin and others.

----------------------------------------------------------------
