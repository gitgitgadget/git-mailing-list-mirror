Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F5C1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfBFAV0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:21:26 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36748 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBFAV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:21:26 -0500
Received: by mail-pf1-f201.google.com with SMTP id p9so3901015pfj.3
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=70tnuwa58iIZvXpXeWnGjMVXPquAxhmB//hY2e/FJV0=;
        b=lazkxDk0FZpVXJOK7GovjC447uyMx2ci96/Xevg1rTL+2LTV31OtDoxPnJOIyyAhMF
         ekpPh10NIrOFnnYo5H118ElWGKe2YB6GPvgSVThBfT4LEQrtGT16fCCQId2bw2XXIpmj
         CKv/ZIP9FgxPmKMME9pIu26tH3lU9C6ZX0+kXiJBWAywE/IaCb5IkXRF58t0PvWhcAQY
         zQmpwU0BWmJ3xJXvvsDy46Kwk0WycpX6fKvGAnzjnDfBjOLlNdqIlAbV2QdmnekSPMFN
         SDD7KccJgsbU/17LKjkP6fcVJ5EtcX5UMI9NL+BxQHI41i281TNgWTAaFpf8Tc4RpThc
         cxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=70tnuwa58iIZvXpXeWnGjMVXPquAxhmB//hY2e/FJV0=;
        b=EEIHHPcyq8B1Sna0jVue4ed1dq/USVBU2aZRBzxWoyeOkatI1I1uGwVOez2vDNLEEx
         t8rH2pdZ9HRDZOYg86oNk/MieSW25zuwoNDnAoNdU9Y6e83SPs2hGuRA2fy2kTG5iEca
         7Np2oLwOM0fglZXkwNzCLfMiwyCIr2Hy+l64DHCINbNGwpjHv3G6VDdkGIGJ369jjfqR
         UGd4v3ffJWPpTogaIleoL707hfLEfQhpBLuxqMItfZpVHTn28lSocOPWwWaG2IS6jU8a
         YFhFjkAdCWN0wQyrpVu1tlStWq+naf65F6wfhWT6kRXeRITerdShKMEQChaI88UzHjKM
         j6Cw==
X-Gm-Message-State: AHQUAuYcTx+lnf2cI9qc/Ik61ZGszR0MhygWgPp/3Ehb4IMPh2C3wEnU
        qH0G3u9rrfj9E2l8LnlFx64f/QjppnEZDq8p8hW/I8mpNZmQ46qPXEgUjOv+PbQOi96u1oPOrzS
        BidC/5pco3X+h561uTYIi+ZbTY58n8HmW82C7NcfSKLOeXFseTLLprbt7JzXz2EZMaVehRMmz+A
        GJ
X-Google-Smtp-Source: AHgI3Ibv0mRyZYT8BP8wiuqpr3gLFUq1ooe6lqro9TQtRFkCRGmqnqj1Ya9Fk3NF/w7Kl0WZolT0zlCElo2o8Do+v3/P
X-Received: by 2002:a17:902:3303:: with SMTP id a3mr2316853plc.127.1549412485805;
 Tue, 05 Feb 2019 16:21:25 -0800 (PST)
Date:   Tue,  5 Feb 2019 16:21:14 -0800
Message-Id: <cover.1549411880.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 0/8] Resend of GIT_TEST_PROTOCOL_VERSION patches
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on the latest master (8feddda32c ("Fifth batch for 2.21",
2019-02-05)) + js/protocol-advertise-multi.

This is a resend of [1], which was built on the result of merging many
branches. Now that most of the branches have been merged to master, I
have rebased it on master. The only branch that I needed to merge was
js/protocol-advertise-multi.

js/protocol-advertise-multi has not been merged to next yet, but the
general idea seems good to me, and I am making review of that patch one
of my priorities. But if anyone is concerned that this set will be
delayed by js/protocol-advertise-multi, I can extract the parts I need
into a patch in this set (most likely just the part that unconditionally
calls ssh with SendEnv in connect.c), although it is difficult to
explain the necessity of that without reference to
js/protocol-advertise-multi. Let me know what you think.

Besides the rebase, this is unchanged from [1]. There is some discussion
there between =C3=86var, Junio, and I, thinking that it is OK to merge this
even if we didn't eliminate all errors. Right now, only 3 test cases
fail with GIT_TEST_PROTOCOL_VERSION=3D2.

Patch 1 implements the test variable, patches 2-7 eliminate false
negatives (with explanations), and patch 8 fixes a genuine bug.

[1] https://public-inbox.org/git/cover.1547677183.git.jonathantanmy@google.=
com/

Jonathan Tan (8):
  tests: define GIT_TEST_PROTOCOL_VERSION
  tests: always test fetch of unreachable with v0
  t5503: fix overspecification of trace expectation
  t5512: compensate for v0 only sending HEAD symrefs
  t5700: only run with protocol version 1
  tests: fix protocol version for overspecifications
  t5552: compensate for v2 filtering ref adv.
  remote-curl: in v2, fill credentials if needed

 protocol.c                           | 17 ++++++++--
 remote-curl.c                        |  9 +++++-
 t/README                             |  3 ++
 t/t5400-send-pack.sh                 |  2 +-
 t/t5500-fetch-pack.sh                |  4 ++-
 t/t5503-tagfollow.sh                 |  2 +-
 t/t5512-ls-remote.sh                 | 18 ++++++++---
 t/t5515-fetch-merge-logic.sh         |  4 +++
 t/t5516-fetch-push.sh                | 22 ++++++++++---
 t/t5539-fetch-http-shallow.sh        |  5 ++-
 t/t5541-http-push-smart.sh           | 14 +++++++--
 t/t5551-http-fetch-smart.sh          | 47 +++++++++++++++++++++-------
 t/t5552-skipping-fetch-negotiator.sh |  5 ++-
 t/t5700-protocol-v1.sh               |  3 ++
 t/t7406-submodule-update.sh          |  5 ++-
 15 files changed, 128 insertions(+), 32 deletions(-)

--=20
2.19.0.271.gfe8321ec05.dirty

