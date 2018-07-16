Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0CB1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeGPXfX (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:35:23 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:53458 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXfX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:35:23 -0400
Received: by mail-vk0-f74.google.com with SMTP id x78-v6so8283069vkd.20
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7i0DCVZEtm5ehOBM3XGYNDKimLLbCSuTjeKKpIr7j3w=;
        b=pE9wsSl3Sh+UPRg5fgnOVPQJsyQrL0cB9HFbIEb3kBtXGW4etHiuvvrQYIB8wb9Vbb
         kHT0lzy3cc7YrzJB3V/jurf1liitxoWdREROS1bcM3pKdFaOyuabl7/4exAe44bmaHyh
         Gvy4OxQPz1+utjAWcDbUVuRUtRD22qcvxV+VpWJ0nv7nEodvAhYTtnRDAHi9rlZ8PYo7
         FzdYfrRB3NBSsfFD7gCBt1A0Sds0OU2s0HBXmPx+TQKyYIdDQMSgRjWy9kzo+aEGH48G
         ReGR+iren/jeopA2ETZRFbSbV6Gx/EDX4T5snn0z1AA0EVTO75TGYGXJ5iS+RbI/YiSC
         hdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7i0DCVZEtm5ehOBM3XGYNDKimLLbCSuTjeKKpIr7j3w=;
        b=UYEr1EI586K2RyhRl3+a3JqL6uK8z2xbvVP+u1k662BVxP9PZb3qKHI9x8bZ8uyoS1
         DMwTXDr9TDzmjSTbUil6c0elL5WVkdqC5TOxf9KD1biYKwJbiaoonbMGe5z5MmfU7Us3
         LJklnBNwR2XgbooQghUra4j9Q4u2C7kKCoWe1JYt/KciHXPejoAlHUTm//kTtoXTnc58
         PExeJLM4MvAYt3CIyhQGK/+mHMwNson4Ob/jlfIaO9MeqCeoePoF8TKo1uyVY0GVf6U4
         2KeT3paY8biRZyXZoVDCLbSuTAAcw4pj2vHhOPxBt82NTM17A0aohplSpw88JePjAc5t
         uyFg==
X-Gm-Message-State: AOUpUlHZaEg795pjqhT3sFPV2PwFtoCBezGVN7EIhbIRO3pwjEzER4Di
        BFL+dkJrpOsMKwYE79nF4NYLCBdeJJdu2N/Q7jx3pO9LiRXFGoiDslm4NW8dTaYHvq//l482fqH
        sPVl9CtO10CGmUlQiFpnHYgTPrjrt6tdPh+Dl+5t9TH2W04rg/aHPqiFGZm+/
X-Google-Smtp-Source: AAOMgpfsGVhPRToJ1rxtTmAmcNwHHrGAvzYPHGp+/W1triKCOClWqYPEChUUZuukEA7+/YPVr/ErQgaFBXbF
X-Received: by 2002:a1f:9b84:: with SMTP id d126-v6mr9025156vke.65.1531782347740;
 Mon, 16 Jul 2018 16:05:47 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:05:33 -0700
Message-Id: <20180716230542.81372-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCHv5 0/9] Reroll of sb/diff-color-move-more
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resend of sb/diff-color-move-more
https://public-inbox.org/git/20180629001958.85143-1-sbeller@google.com/
that fixes an errornous squashing within the series; the end result is
the same. range diff is below. (As the latest cooking email said
this series is going to land in next soon, I hope this is not too late
of a resend; otherwise just ignore it as the end result is the same)

Thanks,
Stefan

Stefan Beller (9):
  xdiff/xdiff.h: remove unused flags
  xdiff/xdiffi.c: remove unneeded function declarations
  t4015: avoid git as a pipe input
  diff.c: do not pass diff options as keydata to hashmap
  diff.c: adjust hash function signature to match hashmap expectation
  diff.c: add a blocks mode for moved code detection
  diff.c: decouple white space treatment from move detection algorithm
  diff.c: factor advance_or_nullify out of mark_color_as_moved
  diff.c: add white space mode to move detection that allows indent
    changes

 Documentation/diff-options.txt |  30 +++-
 diff.c                         | 253 +++++++++++++++++++++++++++++----
 diff.h                         |   9 +-
 t/t4015-diff-whitespace.sh     | 243 ++++++++++++++++++++++++++-----
 xdiff/xdiff.h                  |   8 --
 xdiff/xdiffi.c                 |  17 ---
 6 files changed, 472 insertions(+), 88 deletions(-)

-- 
2.18.0.203.gfac676dfb9-goog

1:  7199e9b5608 ! 1:  7d58ad461cb diff.c: decouple white space treatment from move detection algorithm
    @@ -207,9 +207,8 @@
     +	EOF
     +
     +	# Make sure we get a different diff using -w
    -+	git diff --color --color-moved -w |
    -+		grep -v "index" |
    -+		test_decode_color >actual &&
    ++	git diff --color --color-moved -w >actual.raw &&
    ++	grep -v "index" actual.raw | test_decode_color >actual &&
     +	q_to_tab <<-\EOF >expected &&
     +	<BOLD>diff --git a/text.txt b/text.txt<RESET>
     +	<BOLD>--- a/text.txt<RESET>
    @@ -224,9 +223,8 @@
     +
     +	# And now ignoring white space only in the move detection
     +	git diff --color --color-moved \
    -+		--color-moved-ws=ignore-all-space,ignore-space-change,ignore-space-at-eol |
    -+		grep -v "index" |
    -+		test_decode_color >actual &&
    ++		--color-moved-ws=ignore-all-space,ignore-space-change,ignore-space-at-eol >actual.raw &&
    ++	grep -v "index" actual.raw | test_decode_color >actual &&
     +	q_to_tab <<-\EOF >expected &&
     +	<BOLD>diff --git a/text.txt b/text.txt<RESET>
     +	<BOLD>--- a/text.txt<RESET>
2:  5626d523b70 = 2:  f08353f2a02 diff.c: factor advance_or_nullify out of mark_color_as_moved
3:  e2f1e573699 ! 3:  3fde7cf2194 diff.c: add white space mode to move detection that allows indent changes
    @@ -339,30 +339,6 @@
     diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
     --- a/t/t4015-diff-whitespace.sh
     +++ b/t/t4015-diff-whitespace.sh
    -@@
    - 	EOF
    - 
    - 	# Make sure we get a different diff using -w
    --	git diff --color --color-moved -w |
    --		grep -v "index" |
    --		test_decode_color >actual &&
    -+	git diff --color --color-moved -w >actual.raw &&
    -+	grep -v "index" actual.raw | test_decode_color >actual &&
    - 	q_to_tab <<-\EOF >expected &&
    - 	<BOLD>diff --git a/text.txt b/text.txt<RESET>
    - 	<BOLD>--- a/text.txt<RESET>
    -@@
    - 
    - 	# And now ignoring white space only in the move detection
    - 	git diff --color --color-moved \
    --		--color-moved-ws=ignore-all-space,ignore-space-change,ignore-space-at-eol |
    --		grep -v "index" |
    --		test_decode_color >actual &&
    -+		--color-moved-ws=ignore-all-space,ignore-space-change,ignore-space-at-eol >actual.raw &&
    -+	grep -v "index" actual.raw | test_decode_color >actual &&
    - 	q_to_tab <<-\EOF >expected &&
    - 	<BOLD>diff --git a/text.txt b/text.txt<RESET>
    - 	<BOLD>--- a/text.txt<RESET>
     @@
      	test_cmp expected actual
      '
