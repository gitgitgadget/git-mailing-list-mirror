Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79EE11F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfJ3UVW (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:21:22 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36848 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfJ3UVW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:21:22 -0400
Received: by mail-wr1-f41.google.com with SMTP id w18so3812767wrt.3
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FoQ/QHyXVnd3enKJg10FGUzWOB3LuzxM1zrEUqDKSE0=;
        b=fw5I8ZmWEPWWai5f/6fOv+hJuy+n/iBu+ZXcHdmqyIDmow7KxCwOwPJMbkCcs4wc1i
         61Uwgj4+W1EDlyfnKhfpj6/mp9GYEfCwNFxJafJj/OgAmCMjVXhOkze3/+ySHYG1a4l8
         riDBGobhMtLPwD9Ujzhqsp5t+sG1a/XOGGQRzG4T1ph7QpzERMomp3WSFeFyiz6ytCi/
         lYZtypAdW+IQUsNus9BE/T2lgEanQSoKK85Bj6xFNP86hfkof9d3VWLMyPBe0NNDHlp0
         DNFDffYqBn+JwTXiGIbSZZokN5v2cp9TXfInomm45eoMmbV6IkAxq4bwqs9t64mUMpCv
         Om2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FoQ/QHyXVnd3enKJg10FGUzWOB3LuzxM1zrEUqDKSE0=;
        b=qeFUfeXypdjK3kAHcoHQM3IJ4gTwEgXwzzNtphBZlpiXbSUue2lpFNSdVPC06Lwiy1
         xgj9dTIlo222sKSnLEZMhs/OX0EyJPmz47SgroFsAdE5owZRFpYcYJotnjGt75ucGF+O
         GhMgoA9ezsHNe5bx61YmB/S8GAvuDepMUNc5vws9fKuGu1JMAwSUU71wuOglEmklRUTR
         FqQowKnVLEdWhTuAyC+6gpR7qp11PVWTXbC31YzfNHv2An2By1P23rYnXHaLNehTyB4Y
         HtzVBPISJ0p3/T8of+Z4/keKtU4cX4OZFwAEhyRtrAci5b27IEZpegXO+NgNDhrW/lpc
         PD+w==
X-Gm-Message-State: APjAAAUDzBHzL5WsMqI59w/PMlCSHeO9hyJZPJGOax9HKciIYNwB5gss
        4bJk6ePvTssv+6PjDUweO/dnSrh/
X-Google-Smtp-Source: APXvYqw9oMEbV26ecz7EZ9JZlMJ/0pv+tfhv/JGkJ/NV+ZTyWsFnSOd19HbAUWismxfFjgVeHvhQxA==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr1623667wrr.108.1572466880492;
        Wed, 30 Oct 2019 13:21:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm994354wmb.45.2019.10.30.13.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 13:21:20 -0700 (PDT)
Message-Id: <2e1ebe70820fd4cbc40df1f89779c77b9ceea881.1572466878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.440.git.1572466878.gitgitgadget@gmail.com>
References: <pull.440.git.1572466878.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 20:21:17 +0000
Subject: [PATCH 1/2] RelNotes/2.24.0: typofix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/RelNotes/2.24.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.24.0.txt b/Documentation/RelNotes/2.24.0.txt
index b7083cd6b2..26e018078d 100644
--- a/Documentation/RelNotes/2.24.0.txt
+++ b/Documentation/RelNotes/2.24.0.txt
@@ -316,7 +316,7 @@ Fixes since v2.23
    to access the worktree correctly, which has been corrected.
    (merge dfd557c978 js/stash-apply-in-secondary-worktree later to maint).
 
- * The merge-recursive machiery is one of the most complex parts of
+ * The merge-recursive machinery is one of the most complex parts of
    the system that accumulated cruft over time.  This large series
    cleans up the implementation quite a bit.
    (merge b657047719 en/merge-recursive-cleanup later to maint).
-- 
gitgitgadget

