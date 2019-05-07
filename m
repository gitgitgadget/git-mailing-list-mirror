Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2EC1F45F
	for <e@80x24.org>; Tue,  7 May 2019 21:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfEGVbT (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 17:31:19 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:45518 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfEGVbT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 17:31:19 -0400
Received: by mail-oi1-f201.google.com with SMTP id v13so2356203oie.12
        for <git@vger.kernel.org>; Tue, 07 May 2019 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=illObNRvchh2VKdxI8Yx/r44X4UDQrMbRc0ZD0rhfdE=;
        b=p0tpg5whPrIPjIwq3uI/6zsb8rYNOutQybbQFtBJvrB4t0udNSUWQolglzjkIyUbMW
         ywQwmihNR1p6YQkykRGjaNRbUSmX39H9wP9tcEI27BSBtvOoCqWLIoFp8zaqfRZTENos
         e6T2WOX8jbNcgYhGJwdtSiQTm2qOWZG2Jw7ysPqt3Q9uwgGcUYZdimwIzmexlQjvse1U
         ji1n+H9cITPIg4sqFV2rJfViw7vCVuvdnslOPYHzTwwuuH15nVRxpz/Iyj6kt/HD6BzW
         t7fFRexcOBlpHGMuEJkRn0bz4Ubu/UHBjvOYtWbrW5BWPDsiOG5mhczv5494kbN1KECX
         q6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=illObNRvchh2VKdxI8Yx/r44X4UDQrMbRc0ZD0rhfdE=;
        b=NoNc7sKmidpM/9thboR3Pj4g1sWt+k12eF69DrMiwubxkx+EsVsx+an0ENXsC6urTy
         jZjLnyyQv2ZWhp2gz55efZy4pwZGaaZd0mr80+PhrM+jsdbJaFLuB68Ry6pZ/YdckPJ5
         DS/Y3nt1FFEU4/2MD3RZrb9he7tJ4k5UeDgT+s4kwhXkFXyrhMK5F1xTtOKOHVy1bCdn
         TnkQFoFyLR48JaKHA+lxBlMJvMpKVxvhGFjnza3RYHydHvM2Q6TATH2qqtRHt7QJ1ASc
         q1lVw39smClKikFJ+nBn1pwZ07aa56JP7BJLI4yto/WeiVmUHQcjZX0La7PL9tUcN5lV
         zoow==
X-Gm-Message-State: APjAAAVPOO5rLITHJ5gKm1R5xqWokXWQCEp4gFxvRIJS7kf53JKIqj4k
        1JnRVkmL52WyIMT0flc/jXZCaktEvDAudOVYSjgApr6SGxoTm5J4LEmj1K51W1fjdV4p5hWfJnN
        jE2g4NFMDxWnbehOoZtHh083+jmmWnEiDNBXkRH1et0tOTEZsCwV9T6w9QJpJBgNa78s+7mq/tw
        ==
X-Google-Smtp-Source: APXvYqxvJwG5tHgsoZFLYVMJt7yIV+i6eUHLY9sJqQvuiYaTIsUfYXwGGeA4cOpxRju4uw0z2A+2b614hEmm13gInTw=
X-Received: by 2002:a05:6830:1193:: with SMTP id u19mr20913452otq.305.1557264678245;
 Tue, 07 May 2019 14:31:18 -0700 (PDT)
Date:   Tue,  7 May 2019 14:30:38 -0700
In-Reply-To: <20190423193410.101803-1-emilyshaffer@google.com>
Message-Id: <20190507213040.151799-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190423193410.101803-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v5 0/2] documentation: add lab for first contribution
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phil Hord <phil.hord@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v4, I've made one major change and a handful of minor changes. The
major change is contained entirely in patch 2/2; patch 1/2 has only nit
fixes compared to v4.

Major:
- I've added anchors to each section. These anchors are custom-named in
  order to be compatible with asciidoc as well as asciidoctor. I figured
  it would be easier to review the naming choices if the anchors stood
  alone from the main introductory patch.

Minor:
- Alphabetized Documentation/Makefile
- Fixup headers - a few renames for clarity, casing, and a missed
  monospace, based on Phil Hord & Jonathan Tan comments.
- Removed 'extern' from the addition to builtin.h
- Replace "cheating off" with "mimicking" in a few places
- Clarify instructions for writing commit message to remove ambiguity
  and include requirement for newline after subject
- Remove unnecessary explanation of `git commit --amend`
- Remove braces to bring code sample into Git style
- Typo, word-reversal, and early line break fixes
- Add neglected argument to `git send-email` samples to actually include
  patches

Emily Shaffer (2):
  documentation: add tutorial for first contribution
  documentation: add anchors to MyFirstContribution

 Documentation/Makefile                |    1 +
 Documentation/MyFirstContribution.txt | 1110 +++++++++++++++++++++++++
 2 files changed, 1111 insertions(+)
 create mode 100644 Documentation/MyFirstContribution.txt

-- 
2.21.0.1020.gf2820cf01a-goog

