Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31D91F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfAPWmW (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:42:22 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:46582 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732830AbfAPWmW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:42:22 -0500
Received: by mail-vs1-f74.google.com with SMTP id n87so3392760vsi.13
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=j/4cl3OFL0aL6galZSJbp5c1/8Yrs707s3d8DAsqrTY=;
        b=BBvyCn8MZ/hkHlhv2xZCmlsxXjOP5a1kFWdwBwiyIzxhAtPsehAO6CKC1tX6YC85Uz
         4eMslSNhPSqbiQLgcbfcKuUAmUDjYMicwlnSImyEkrgmQit0ZwE129bRHiIh9QN2FnLv
         Oo5BWuITDfOgMzPlZWWrf6Mt6oFzSUsmbE/eSe7ahCrY9fuw2cMZ0PWUxDPJEDrL5FKy
         ObvVRb/ZrFwB2y7l+A0qh/ZpohMYOdUCjC0/JrH31fc0UOwyMvtAXcOvRfz9F/eWjfMu
         aTqa0J3hLVMithl4hXfhfGJQ1L2N8VcoOqpQysgHXpID5eCsTX1YFYBV6XHVu+igeUUi
         jQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=j/4cl3OFL0aL6galZSJbp5c1/8Yrs707s3d8DAsqrTY=;
        b=DEy8SMVPfSun+AN5HU4hd/WtacybymIwduPlKLYqmkdj7/oosyN3aXKgEQuVfGzHtM
         R6XBhsIVL83ZyPzE/qRF7chWmvzVlyrLn0w9Kw93Ex8e0zVXWgL9MA7JjcMQQee0PL0b
         j9Bc7FOOk82IE6QKylByVmP8WV7oLLkk+xye88hNXSnLFcg3W6rklJ5JX3Jhql/Qckp4
         ogdLgkF4Seflk4F5B4eAHfIUGjNm0v9cjooR0Mzpg7DD5GLVzRKTzubjhvuDkDHSJ4mp
         SamcKN3jaAea6e7575sPDFs67/47jen2oAMMDFy5YL8/zyCFcKoK1nIb2E3PoDMQjch6
         bRZg==
X-Gm-Message-State: AJcUukczqJu9/20eXH+ibqtCIkuiQp31MOKcrCrUuDhzZxOnPcmtImlE
        sfOIwK+/f0p19kSNQU9So6x1FyB/rKWTNfj9dtPvXyNOo7XhbzxZv10+d/48oa3HetXLTekeHZN
        ZfXiB5zSbbjsjQC4LuUIrJjCk9TkQs0OpTw1g8wO6NSG4SqSClVlH/4vWNY9zFztElrst3QKSwp
        do
X-Google-Smtp-Source: ALg8bN6ea48AxJXKJgKoVlxePfweFYbesq1YVaLufjifIi5nE2yE96lcqFxd5Qn6UBXErtxSlXfS9sN2Y1R+g0zrv0x8
X-Received: by 2002:a1f:9d53:: with SMTP id g80mr6911060vke.3.1547678541218;
 Wed, 16 Jan 2019 14:42:21 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:42:08 -0800
Message-Id: <cover.1547677183.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 0/8] Trying to revive GIT_TEST_PROTOCOL_VERSION
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var, are you planning to revive GIT_TEST_PROTOCOL_VERSION? I have
updated the patchset in light of some new branches that have appeared.

This is on master merged with:
 - jk/proto-v2-hidden-refs-fix
 - tg/t5570-drop-racy-test
 - js/protocol-advertise-multi
 - jt/upload-pack-deepen-relative-proto-v2
 - jt/fetch-pack-v2

One notable change I made is that I made this envvar determine the
minimum version. So, if GIT_TEST_PROTOCOL_VERSION=3D1 and the test
explicitly states v2, v2 is used (but if GIT_TEST_PROTOCOL_VERISON=3D2,
all use v2). I think this reduces the number of false negatives, since
there are quite a few tests that use v2 specific features, and that are
already marked as v2.

I included one genuine bug fix (the last patch) and the rest are either
overspecifications (which I didn't investigate too deeply) or false
negatives. There are still some errors when run with
GIT_TEST_PROTOCOL_VERSION=3D2 which I don't think are false negatives -
I'll continue to look into them.

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

