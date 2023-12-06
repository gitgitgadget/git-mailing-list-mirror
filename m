Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="TqyudQv7"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024D2696
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 03:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701863536; x=1702468336; i=l.s.r@web.de;
	bh=6dp/H8/n3Sf0DL5jnLphpHtiL4BPVggEQTU9/WwvbT0=;
	h=X-UI-Sender-Class:From:To:Subject:Date;
	b=TqyudQv78PQkENtgEmwMbzPAfFNvlob8pI/3hUxkD6DPPP0XqO+U+PCjaUCFciLh
	 iBBtgP/hm/dkx/4Yxh1nd61KwdYwFpZQ6rP++ZXbpddSgDwzOOQM8SbvDevmNssle
	 XgowYnM98fdH/w8QAzFIzqalOqjarBnGg8T12uQ65ORfYoORirJtbkZmBYHWo1eUF
	 QvZFXqC9tKFeWVLsm6ZGy3O4Y9jNfhOh16kzGTUbhWddaIJZ77UGxQ7L14JvBOLLz
	 YEpDRYbuCsgwBqLfZ1MCH3mIZKpbMHFozoKcOgRPWPoUdzJidBFDgew/fCVu8jbRa
	 MWkqj+knpPDAEpaFEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.29.38]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MN6Bb-1quYcP17oL-00J2eq for <git@vger.kernel.org>; Wed, 06 Dec 2023 12:52:16
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 0/7] standardize incompatibility messages
Date: Wed,  6 Dec 2023 12:51:54 +0100
Message-ID: <20231206115215.94467-1-l.s.r@web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:lqsxaosgEx4o92BAgKGybGXQ3OOouYZdDox7j2qpoIk6XORg5hL
 iYjZzfVPNQ9CBCYKHRRVK0igEdzOyX5HwE3+zK8cuwiB6Es2rx7vA6XtjHhrDx1bKM4XSMF
 /+QJDFPhy6eLhxuPhYakr1GaQ7eVfkFsujP91IiONUecT6f/ipwQdsncEeVDQx/NTI0NCa1
 LirU2WkRandK9i2/dqRNw==
UI-OutboundReport: notjunk:1;M01:P0:5FtfCNVGP4Y=;Pdw2IQd7cdbAihCIuOuD5HPOz01
 Hp0lE3t+wFUjFpTWW+a7w4TBMWtV27Q1rVbUiLv6f9cVcOxGHXhH8nCAYOkweqpHSIarKQvXr
 GqE2l5w2fcEc/x6/Lki1YmwTpO8TbgVo9/GWsmO8VHNhB23spwxL0MycLh6zjk3k+sLJFr8SL
 K2RC2EWSGdaE5eWT7U3q7q0o4LbeiOqCc5LdcgcY5TUz0qyMmbRFb4ec5paJ1+Gl4exZSHMqO
 di+WPzNqyicyv3WDSkxrOr6Rckagqv4U6PLZ6M9XKAuTR+IxzG2c4M+vkDAMJFgdKTKdNTy2i
 w03tnkG2ZIBBW2g08anJ15vprFpi9fRse3x4UDPnAeSqzvKq5xV0Gl/HEAn67pnowtDYxZzZv
 zS0h5qCGHHzpgzQn6WqjKr0KecQsRG6q6mmFt3XtiP+tD3wcIYTdIvyqiTE6PFKiSmPadXRKc
 IWOmDu5QDoUYd/gctm1fIu1LEUvTJ5PnPtbepegBLmpka+hAdROLPT1yyNHJM5mnmrv0fg4cm
 Pp/rmFLf0iFWPaSQKwupsPV6vk7Qe7PebgWsD2BNsuAGLckYJb2DmKvdb2+W2ONOPYaQCE/3s
 MEoH+4HEub4FLoMeyHOkVFnDIl4WO+YYqZxbDa9dhY2LFNDqLc2Tdspg2v0yJlb8RdSMJ0VJQ
 pY9/+LCfnJZLt/9gptXN7Rf6Vcao7L/M/W+1KEtThAz1yo+qiGJGF3lo+4ug6TuTmAWThDAmd
 QPWLej6vaKTetRm8+drql+meDLg8Qqz7+ugbmPaasLX3ZUq1ovdGwk9XTroMhpoWChTBxIchP
 huZiR9R1k5IM5TmLnNdvUx97OwoCY4ghFav4D/PzAo0pD+zANJuV6BYvIt786VdhhtZkS4DEL
 V5Xr5buHm9wfT05RHBgbM8F5izwW8xV4JcEqP2q0hbozdH5JF68pW2BJNgypKxOBva9UzVyyv
 Z9y5Aw==

More of what a699367bb8 (i18n: factorize more 'incompatible options'
messages, 2022-01-31) did: Simplify checks for multiple mutually
exclusive options, reduce the number of strings to translate, improve UI
consistency a bit.

  push: use die_for_incompatible_opt4() for --delete/--tags/--all/--mirror
  repack: use die_for_incompatible_opt3() for -A/-k/--cruft
  revision: use die_for_incompatible_opt3() for --graph/--reverse/--walk-reflogs
  revision, rev-parse: factorize incompatibility messages about --exclude-hidden
  clean: factorize incompatibility message
  worktree: standardize incompatibility messages
  worktree: simplify incompatibility message for --orphan and commit-ish

 builtin/clean.c                    |  2 +-
 builtin/push.c                     | 12 ++++--------
 builtin/repack.c                   | 14 ++++----------
 builtin/rev-parse.c                |  9 ++++++---
 builtin/worktree.c                 | 21 +++++++++++----------
 revision.c                         | 27 +++++++++++++++------------
 t/t2400-worktree-add.sh            |  2 +-
 t/t6018-rev-list-glob.sh           |  6 ++----
 t/t6021-rev-list-exclude-hidden.sh |  4 ++--
 9 files changed, 46 insertions(+), 51 deletions(-)

--
2.43.0

