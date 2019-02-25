Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B2420248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfBYVyT (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:54:19 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:53062 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfBYVyT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:54:19 -0500
Received: by mail-qk1-f202.google.com with SMTP id k21so3756190qkg.19
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=3aaD+co2DwM/rkyJWKugpDYN1dN0nXmCKO6e4owRv+I=;
        b=F6lSngsb1oKVX7TORyfRhqsAg6bvVJHe8kzTrLnaDZfkdNKokOyzye4TykF4uOZT2N
         B8zokGpvGMj/+fBiSxbyWASiFqb7/t6jmYuZ5AhOBvA0Cw89wDuaeBpD3dgIFlCh7Qi+
         ooecmpRyMzLJLVr5WpABWllx8C4rhyCnu0g24tVJZr1da+ufe6vfDvgcXxiXI6sYno8v
         SBXFoqvkVKPYxo2RMdhkrvvcXPA4rYE4EGxBONKXC0T4fpJ95ViJ4DOWmDaeqF6KKaW1
         weUJRltki+QjlvwEPlRilzt+G+DLas681z3Mu8x5R8NFn94wSXcZY+/OaSMgTyY+gaYJ
         fsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=3aaD+co2DwM/rkyJWKugpDYN1dN0nXmCKO6e4owRv+I=;
        b=bwe3+TxTo/zpdAL7Iui/+Yz20JkQMKZQW+brBhXCBRq6a/PEUrq2eOeZ1s05QXSYxA
         jlSHn24LYAkhuhVMUlVLX/Dmd7badlHRDtUlic/ukBIfHEJ/MhAnMfrKj5EFvtrnGfCT
         C0bJuE+4a9NZkfPPa7EOqaVwF4UzLeysnuQenJA9DF8pdsSuxWj0xnf3Xvt0t07K70Ap
         Cqk/rZ2gdANnBU6ZIDDCLqGlcS52GwEWxmuaC258DhDqiojpyedwOrXq/Br+ao8wPm+8
         cK6UPp/o5nu2yqv+K1gSSAJ5YH0yaMCQmtPD1Jx6NUwX5oW0Vv7X2obi5HBpkNy3o4k2
         utbg==
X-Gm-Message-State: AHQUAuYcLyaPUnvHy6wt1r1vnBbG5Sy1l+Q6DEbV08y/OM3d3cEKvDEx
        AGDPb8yWZYOmZfnJ4OZp/sy/zNjPgvQhoNoqlSl3oGw418gio0M7B9IvptLQGwk/j37XXLWFPUS
        IOtGFf/wHCEJlibKx4pqZVWV8ZmOaoDrfqcz7YAzsIsrN5Gpi0MUA5DnfhRjn6F8iGFo8VEJP6W
        P2
X-Google-Smtp-Source: AHgI3IYMjfYYxz+5722L+QY/kwbvzm0lGdxrXtblBmDRiiqEUCQe6f6UNxfr0Hy8+7s306quKyV0FQ4Y5dmEPMU4jffj
X-Received: by 2002:ac8:fc7:: with SMTP id f7mr11999254qtk.20.1551131657822;
 Mon, 25 Feb 2019 13:54:17 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:54:05 -0800
Message-Id: <cover.1551131153.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 0/8] GIT_TEST_PROTOCOL_VERSION, this time on master
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a version of this in Junio's Git repository as
jt/test-protocol-version, blocked by js/protocol-advertise-multi. After
chatting with Josh (the author of js/protocol-advertise-multi) last
week, it seems that that branch might take a while, so I have decided to
rebase my patches on master.

This necessitates patch 2, which contains additional updates to t5601,
so that all tests pass with GIT_TEST_PROTOCOL_VERSION=3D1.
(js/protocol-advertise-multi eliminates the need to do that, which is
why these changes did not appear in the previous version.) When
js/protocol-advertise-multi is merged, we can and should revert patch 2.

I have incorporated a small suggestion by Peff [1], and he seems overall
OK with the patch set [2].

I have based my work on the existing contents of
jt/test-protocol-version, so most commits include a "Signed-off-by" line by
Junio. Let me know if you prefer it to be removed.

[1] https://public-inbox.org/git/20190211201959.GA9072@sigill.intra.peff.ne=
t/
[2] https://public-inbox.org/git/20190211203827.GA9010@sigill.intra.peff.ne=
t/

Here is a range-diff.

1:  7ed58eb98b ! 1:  4dcd898813 tests: define GIT_TEST_PROTOCOL_VERSION
    @@ -8,9 +8,8 @@
         configuration is in place for all repositories.
    =20
         As of this patch, all tests pass whether GIT_TEST_PROTOCOL_VERSION=
 is
    -    unset, set to 0, or set to 1. Some tests fail when
    -    GIT_TEST_PROTOCOL_VERSION is set to 2, but this will be dealt with=
 in
    -    subsequent patches.
    +    unset or set to 0. Some tests fail when GIT_TEST_PROTOCOL_VERSION =
is set
    +    to 1 or 2, but this will be dealt with in subsequent patches.
    =20
         This is based on work by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.
    =20
    @@ -39,7 +38,7 @@
     +		retval =3D version;
     +	}
     +
    -+	if (git_test_v && strlen(git_test_v)) {
    ++	if (git_test_v && *git_test_v) {
     +		enum protocol_version env =3D parse_protocol_version(git_test_v);
     +
     +		if (env =3D=3D protocol_unknown_version)
    @@ -52,7 +51,7 @@
     +	return retval;
      }
     =20
    - void register_allowed_protocol_version(enum protocol_version version)
    + enum protocol_version determine_protocol_version_server(void)
    =20
      diff --git a/t/README b/t/README
      --- a/t/README
-:  ---------- > 2:  1c865e4ae9 t5601: check ssh command only with protocol=
 v0
2:  1b3c299528 =3D 3:  227a88aa8c tests: always test fetch of unreachable w=
ith v0
3:  526670b1d5 =3D 4:  8f510c5c78 t5503: fix overspecification of trace exp=
ectation
4:  1548be81a5 =3D 5:  9aaabdac52 t5512: compensate for v0 only sending HEA=
D symrefs
5:  1da961b33a =3D 6:  6c29e64bc3 t5700: only run with protocol version 1
6:  3c22aaad5b =3D 7:  d4638e9418 tests: fix protocol version for overspeci=
fications
7:  188754ca3f =3D 8:  629a243c7f t5552: compensate for v2 filtering ref ad=
v.

Jonathan Tan (8):
  tests: define GIT_TEST_PROTOCOL_VERSION
  t5601: check ssh command only with protocol v0
  tests: always test fetch of unreachable with v0
  t5503: fix overspecification of trace expectation
  t5512: compensate for v0 only sending HEAD symrefs
  t5700: only run with protocol version 1
  tests: fix protocol version for overspecifications
  t5552: compensate for v2 filtering ref adv.

 protocol.c                           | 17 ++++++++--
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
 t/t5601-clone.sh                     | 16 +++++-----
 t/t5700-protocol-v1.sh               |  3 ++
 t/t7406-submodule-update.sh          |  5 ++-
 15 files changed, 128 insertions(+), 39 deletions(-)

--=20
2.19.0.271.gfe8321ec05.dirty

