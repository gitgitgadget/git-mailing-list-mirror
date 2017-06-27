Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0273320401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbdF0Rfn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:35:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36024 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbdF0Rfl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:35:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id z6so5598161pfk.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zgCnpzjNJJVPp/qr/5BbTaqVg3axokLR2AtYsQXw8wo=;
        b=KOIQA4ELMImetzWbGZnFWZl6PnHtazodCSNpHyiElbyfPjSinfSot8ZZ/QK8pTlC8c
         s6b1swI7cnX9inNHp+SV0/afiYndUQoP7MI8FxUOAJqkF+PHwdPmrX26bxsyz2hAQdus
         vtAmFNLM1OCCRLyGJLaHz0W7PYEavWVKhFYzaJnApe6/ZNeYtLIGE0eMmj6QTaxkMbJr
         yt6+ahpnqo8C0J6lHB13n1OXAxozUSlLBMqA+MVhjmStE69rWT3gBTESCQF7Fjm+8cXP
         g/zcjOrqz1pf/tmWW6wGduZ4Rcy0p3GRMLc+S3eKYWSMXoZMRrjPtcKZaJFMGEWz++r0
         PkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zgCnpzjNJJVPp/qr/5BbTaqVg3axokLR2AtYsQXw8wo=;
        b=MOQYArtQKf3ckQJyLbEuUKqubw0rsgIrDlyn/fD2cXws1jgZbFmtBAtZG252y0SVuW
         Mg9eWx149p6aqT0Vf9A/eNo1PmXWGyxHBe963dKdI2okRZ71P2PrYX0ab5VS3qjzJ8UB
         DrdUQs+v4fGM6Du7TNGKCYXiazY10BHFQT6d49xEC1pO6Yf4i6/17soquUjxyODwuw1I
         8yORcaEpoC80KI5HO62MVQBxeVbFeMYVri7XbQCNsgNca7U+c6C6KQizetaLkFZ5xvR3
         SXyLOLMNauFLN+MXdYy/r62llMnXjmV6MuCCetlPkIqk9Hx0WKf2yIomO3wxI/OQRYNb
         5k+A==
X-Gm-Message-State: AKS2vOy78RUpZG8lPcdjv22GLGPcOz+jqpoCvvBlKxnY3uwKp2Gr401d
        +wHuIlv1XzkAz5TOIFQ=
X-Received: by 10.98.17.213 with SMTP id 82mr6462782pfr.224.1498584935952;
        Tue, 27 Jun 2017 10:35:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id v69sm6719043pfd.63.2017.06.27.10.35.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 10:35:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Spelling fixes
References: <20170625102041.32015-1-ville.skytta@iki.fi>
Date:   Tue, 27 Jun 2017 10:35:34 -0700
In-Reply-To: <20170625102041.32015-1-ville.skytta@iki.fi> ("Ville
 =?utf-8?Q?Skytt=C3=A4=22's?=
        message of "Sun, 25 Jun 2017 13:20:41 +0300")
Message-ID: <xmqq60fh2v15.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ville Skyttä <ville.skytta@iki.fi> writes:

> Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
> ---
>  Documentation/RelNotes/1.7.10.1.txt         |  2 +-
>  Documentation/RelNotes/2.12.0.txt           |  2 +-
>  Documentation/RelNotes/2.14.0.txt           |  2 +-
>  Documentation/git-reset.txt                 |  2 +-
>  Documentation/git-submodule.txt             |  2 +-
>  abspath.c                                   |  2 +-
>  builtin/grep.c                              |  2 +-
>  compat/regex/regexec.c                      |  2 +-
>  contrib/hooks/multimail/git_multimail.py    |  2 +-
>  contrib/mw-to-git/git-remote-mediawiki.perl |  2 +-
>  contrib/mw-to-git/t/README                  |  2 +-
>  gitweb/gitweb.perl                          |  4 ++--
>  mailinfo.c                                  | 16 ++++++++--------
>  pathspec.c                                  |  2 +-
>  perl/Git/I18N.pm                            |  2 +-
>  refs.h                                      |  4 ++--
>  send-pack.c                                 |  2 +-
>  sha1dc/sha1.c                               |  2 +-
>  submodule.c                                 |  4 ++--
>  t/helper/test-strcmp-offset.c               |  2 +-
>  t/t2203-add-intent.sh                       |  6 +++---
>  t/t3070-wildmatch.sh                        |  2 +-
>  t/t4213-log-tabexpand.sh                    |  2 +-
>  t/t5614-clone-submodules-shallow.sh         |  4 ++--
>  t/t6120-describe.sh                         |  2 +-
>  t/t7412-submodule-absorbgitdirs.sh          |  2 +-
>  t/t7413-submodule-is-active.sh              |  2 +-
>  t/t9300-fast-import.sh                      |  2 +-
>  28 files changed, 41 insertions(+), 41 deletions(-)

Whew.  These are quite a lot of typos.

I see some _("misspelled strings") have been touched, which would
mean this requires translator work, which we do not do for
maintenance tracks, so this needs to be applied to 'master' and
never merged down to 'maint' and older maintenance tracks.  Besides,
this includes a patch to Documentation/RelNotes/2.14.0.txt, so there
is no chance for this change can go to the maintenance tracks as-is.

There are some changes that touch strings t/ outside comment; if the
tests are depending on exact object names, this patch could break
them, so I checked them carefully---I think all of these are safe.

Thanks.
