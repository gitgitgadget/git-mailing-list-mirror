Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6DDA202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935018AbdIYP7f (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 11:59:35 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:56785 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933355AbdIYP7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 11:59:35 -0400
Received: by mail-qt0-f170.google.com with SMTP id l25so7345938qtf.13
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q5NcPVk7YC08izeJGCW6+HoFtcFU7npCEfnX1cQZjHU=;
        b=tHlWI4a7e4gg0YLOjSyNwXtoil05S+q+e6KTP5bVyolNYj2E6NjtmV5utzBhBs2f4b
         MrH7O2LlEff3aLs97An/Zz7i31zp8+Oe9guQcu0zPz2ISHKR/k3W4xWV9llgwjrA3KIk
         1Lbh34UtWmdYvjAa396JwKSiNxGwIRr6LC6UP/wvg5jLA5/oIvHymHHhZccNrg+iM3tc
         HHdVmGaPWwFEI42cn1in2cDQshruRm+8AIuBH4XaVcT8c0G9MCgAS9Op65tIeauYOVIP
         RdHVNISjXoijY8srtskd8tgbcv9Dp406EqxQlXB6TBiZICJbZJ161rCaxqXf81EcKRtI
         CPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q5NcPVk7YC08izeJGCW6+HoFtcFU7npCEfnX1cQZjHU=;
        b=mNB7s7lnlraT3p6ZDSZ7ZxyDMAzje6bdweoCmUonO1vQc/A2z525HmcCpsi6FFje/8
         9eCgD50hn3PcDTmXYGC0ozRYR8zGnEshDJIoGQoBPANgZJ1WwOjPNT4Lz391RF/1tsVR
         GC2mK5pX1PeZb7NSwIB3gawA/P0MZzWZ864mAQEpGumZcNKmjuXJtAMuE71+6/ajBsuW
         jSHA0/tPbsIJykjbXUWG3xXXK6KR1WYcMnkLCHmJG/4qpRAopkeLcYl9N99a5Ksw3zYb
         IWl6U/KqBWnL/XlPeYmzBqLyINZ9NNWdhZRJrdeITOqhTPrIl5oTW5htUN0sdJu8fkHO
         rUVA==
X-Gm-Message-State: AHPjjUjKXnPrYEnfufuitujzo8uint+xbGxTtLEQt6dY9ahkc2Mc2PSv
        ShtkdcHFGu19UbXTGcZQVgIVyAk0mZ4=
X-Google-Smtp-Source: AOwi7QDSoJHHFjh9c3AP9wbhYeXMcUx3TUuR7z5KeFsCQmkPg5WRCpVSdqD+Aw1C0qYUDurwGbLYPg==
X-Received: by 10.237.37.182 with SMTP id x51mr11980961qtc.9.1506355174004;
        Mon, 25 Sep 2017 08:59:34 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id h19sm1439510qta.26.2017.09.25.08.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 08:59:33 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, bmwill@google.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 0/4] Assorted comment fixes
Date:   Mon, 25 Sep 2017 17:59:23 +0200
Message-Id: <20170925155927.32328-1-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I followed Peff's advice for string-list.h comments.

Han-Wen Nienhuys (4):
  Fix typo in submodule.h
  Clarify return value ownership of real_path and read_gitfile_gently
  Document submodule_to_gitdir
  Move documentation of string_list into string-list.h

 Documentation/technical/api-string-list.txt | 209 ----------------------------
 abspath.c                                   |   3 +
 setup.c                                     |   3 +-
 string-list.h                               | 187 +++++++++++++++++++++----
 submodule.c                                 |   3 +
 submodule.h                                 |   2 +-
 6 files changed, 168 insertions(+), 239 deletions(-)
 delete mode 100644 Documentation/technical/api-string-list.txt

--
2.14.1.821.g8fa685d3b7-goog
