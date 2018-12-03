Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29EE4211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 20:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbeLCUWF (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 15:22:05 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38234 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeLCUWF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 15:22:05 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so10187969lfg.5
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CGLmUoMhnIkwjn6z38Dr+vvLoMaLR5nkn223ZxjdqY=;
        b=DJLjIOSrMxFU6m+HVGzmSoxQ6Y7TxQ3Clff1cG7YX4bDSOxycrZFcatxiDz2RT22F9
         t9IXPLzBSr4OHHuqcrnjxqMmo0F3fEBmYuKcUnG0kn0JKj5qFtyY5QTwdIc+reoOQ8z/
         hXwZckPBjRjN+GqnlMbIsCvej1trhm/ao8Lk2qXNoFPwqdaCgy9b1N4bpqN1Yv48OApQ
         j9YhrQA/7zp0PyFDoEYIo9/aB5aW8xGOrm6zGB4kK2eBn6we66H/8ayc6OyuCgC5uFYn
         g9GEejD42Ff8nt+kkP9NNVJtBFiV4X1N87QcKBdbJkl7vpt5J2HvZhvKNv+RvnNaUGvq
         LD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CGLmUoMhnIkwjn6z38Dr+vvLoMaLR5nkn223ZxjdqY=;
        b=FOAP9JSdzX+7UATjpayZxzsPN9w6Xg/jAgkhCJVaNMkB8B2ri8SnoE6vzNq3S3/XvI
         wzhDffznxYXLzm2o5/Y/FP3el6i0PVspRPmgUdzU/Y1MZ+NFS/2nDe3xWixgnwVQSC6x
         29zPF5Fat5oEynA/Xf5vaSuKU3byZ05S1mkNp6ApdJWGDDQTXz4Dtl8StBfpMHDaxdlj
         t4aSlHTnPZBd09xMwttsPAiy4vE7hMUPAcEptQd9VlDQde2n9xsrKvv9yXAYJJjCki58
         ATmCDPjJyy75f0x7Xx9VIZNt7eCG63bgzIAFI5O0C9MUt4o26PT8FbO1ZldB422/z6HN
         jjqg==
X-Gm-Message-State: AA+aEWYDpOdLrBiVg6EPJ+ahLHYbUcSHiJyCU4Pu5VYsJAl1tFqIz6J5
        7xo0PyvWbp1m1RUInRQgTCM=
X-Google-Smtp-Source: AFSGD/UszNlBvOd7OcbQ3L80zZtKSc9MPXLBW5Xmslie3wy+MCJqNDkBEhj9WdGKNrTo7EmeDIrtWA==
X-Received: by 2002:a19:4287:: with SMTP id p129mr10615219lfa.135.1543868521264;
        Mon, 03 Dec 2018 12:22:01 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id j12-v6sm2705104ljh.66.2018.12.03.12.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:22:00 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 0/3] Re: [ANNOUNCE] Git v2.20.0-rc2
Date:   Mon,  3 Dec 2018 21:21:48 +0100
Message-Id: <cover.1543868120.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.1.gfcc5f94f1e
In-Reply-To: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com>
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> A release candidate Git v2.20.0-rc2 is now available for testing
> at the usual places.  It is comprised of 934 non-merge commits
> since v2.19.0, contributed by 76 people, 25 of which are new faces.

Here are a few suggested tweaks after reading the draft release notes.
Nothing critical.

Martin

Martin Ågren (3):
  RelNotes 2.20: move some items between sections
  RelNotes 2.20: clarify sentence
  RelNotes 2.20: drop spurious double quote

 Documentation/RelNotes/2.20.0.txt | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
2.20.0.rc2.1.gfcc5f94f1e

