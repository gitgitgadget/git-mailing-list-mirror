Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8729211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 05:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeLDFnh (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 00:43:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41256 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 00:43:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so13678459ljb.8
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 21:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpHbtqoQbXWld4TPDQns+7ASuzq93WgBp3IlEk3ZPVs=;
        b=HUm4R5dsDQUmp7b7g8OTMo7ewhS+OIGDws7/xQUTbPqQX4lML0GK10IkLjxPMYLDnU
         t/2jiBgfX6bMFnfmSK2wDIwVC8IbRvrpLyR2hREVfQQOddJZKt30ZdSJy9qhG5J2KKUn
         MAR9wTTn1oFYtI3HJeTGvB+ztJP3G6pY7zy+dBUsTvu3zmvzDeSi5bv+HDx1ldhga1uP
         fjZM+59eZ+JzExiC5pXBK4RZHpxcuCOXHORD8DFZSJVWVuuB9gOMQpClU8GiKGVBIpR5
         qFemBtggn0Qcl5RR++87nq3gUOjVDW9/wUs8sq8NVorTMzrFBndJJb0ReCgnzsFDOsQ8
         pbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpHbtqoQbXWld4TPDQns+7ASuzq93WgBp3IlEk3ZPVs=;
        b=qiFzDYWbcAjOQJoHw/B0Qq1mgvKLxrxEDhDaQwG8MAY7v/eGbX2l85Fd3t8pQ0nSqG
         6HWip/feoy1SBwh+EfxYHh5rQ3IGicxOruETDkGdPFRtSxJzHfS0HXuHwPMTdZi1zCSP
         Mxit+O5yFMYiCxOOF+TnynO82lknyhda6mSvpfe+pfuo9GGNVIAtXZV0bF8zV1A1i01e
         SQHN+WfrFaGoT8Hrus5cyECygGU4YhbwS1DJ6HsCaDVxZfPN97QS3S8mDG1TC4kkBZL7
         8dsC2yM5NmkaKrfuEwKh8mgs623wDV71BrXg4Ef/6Arz5YZKQiT6vBjhBiXE5WvjqsEb
         c/BQ==
X-Gm-Message-State: AA+aEWbRH2BAmFZLatR1oJJFCfyvBHtr3byX91cMkvf4hLW7v7XyTq8s
        KXxkRuOMRJ9IEyjAtf8UMq8=
X-Google-Smtp-Source: AFSGD/XrKJrDU21a4P5uOaz0T/eFuDffIJBypkVVHHVupMQ1ylv/94pFw3vSTV44+v/dBlImwaq0hA==
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr11496365ljg.64.1543902214888;
        Mon, 03 Dec 2018 21:43:34 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id m77sm2779217lfg.3.2018.12.03.21.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 21:43:34 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] RelNotes 2.20: move some items between sections
Date:   Tue,  4 Dec 2018 06:43:16 +0100
Message-Id: <cover.1543901498.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.1.gc81af441bb
In-Reply-To: <xmqq36reghdk.fsf@gitster-ct.c.googlers.com>
References: <xmqq36reghdk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Dec 2018 at 03:23, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin Ågren <martin.agren@gmail.com> writes:
>
> > Some items that should be in "Performance, Internal Implementation,
> > Development Support etc." have ended up in "UI, Workflows & Features"
> > and "Fixes since v2.19". Move them, and do s/uses/use/ while at it.
>
> I agree with the early half of this change; I think it is OK to
> consider lack of preparation for Travis transition and lack of
> better testing in the maintenance track as bugs, though.

Sure. Here's a resend where patch 1/3 has been simplified accordingly.

Martin Ågren (3):
  RelNotes 2.20: move some items between sections
  RelNotes 2.20: clarify sentence
  RelNotes 2.20: drop spurious double quote

 Documentation/RelNotes/2.20.0.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Range-diff against v1:
1:  d69f63b5f6 ! 1:  961bfc2ad6 RelNotes 2.20: move some items between sections
    @@ -3,8 +3,8 @@
         RelNotes 2.20: move some items between sections
     
         Some items that should be in "Performance, Internal Implementation,
    -    Development Support etc." have ended up in "UI, Workflows & Features"
    -    and "Fixes since v2.19". Move them, and do s/uses/use/ while at it.
    +    Development Support etc." have ended up in "UI, Workflows & Features".
    +    Move them, and do s/uses/use/ while at it.
     
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
     
    @@ -35,33 +35,3 @@
       * When there are too many packfiles in a repository (which is not
         recommended), looking up an object in these would require
         consulting many pack .idx files; a new mechanism to have a single
    -@@
    -    two classes to ease code migration process has been proposed and
    -    its support has been added to the Makefile.
    - 
    -+ * The "container" mode of TravisCI is going away.  Our .travis.yml
    -+   file is getting prepared for the transition.
    -+   (merge 32ee384be8 ss/travis-ci-force-vm-mode later to maint).
    -+
    -+ * Our test scripts can now take the '-V' option as a synonym for the
    -+   '--verbose-log' option.
    -+   (merge a5f52c6dab sg/test-verbose-log later to maint).
    -+
    - 
    - Fixes since v2.19
    - -----------------
    -@@
    -    didn't make much sense.  This has been corrected.
    -    (merge 669b1d2aae md/exclude-promisor-objects-fix later to maint).
    - 
    -- * The "container" mode of TravisCI is going away.  Our .travis.yml
    --   file is getting prepared for the transition.
    --   (merge 32ee384be8 ss/travis-ci-force-vm-mode later to maint).
    --
    -- * Our test scripts can now take the '-V' option as a synonym for the
    --   '--verbose-log' option.
    --   (merge a5f52c6dab sg/test-verbose-log later to maint).
    --
    -  * A regression in Git 2.12 era made "git fsck" fall into an infinite
    -    loop while processing truncated loose objects.
    -    (merge 18ad13e5b2 jk/detect-truncated-zlib-input later to maint).
2:  eccb7edd08 = 2:  3027a34938 RelNotes 2.20: clarify sentence
3:  78f3043b65 = 3:  a5e2df91b4 RelNotes 2.20: drop spurious double quote
-- 
2.20.0.rc2.1.gc81af441bb

