Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341CC1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 21:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbeDKVVa (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 17:21:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38304 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754609AbeDKVV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 17:21:28 -0400
Received: by mail-wr0-f194.google.com with SMTP id l13so2059074wrb.5
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sgKpZyXe1RA2aKFIXpkMig08CCiL4HHEz1mEC5W3Zd0=;
        b=ESY3a/sEYVZU2FKmnm5VQytCQS2w9QWk18a8bbEJlXfIdrS/Rlp4raXqpis4x2d5vk
         2w3N8aS0Cxk6bbFHxU/makJWDRySJo4G+1j7/dmiXOsrxsKT6zYVBRxi6r6SLtpU/B9Z
         YZmGFhLVFkakba9d+o9ROxqvoifNUOOr+SizFO+JJpvkU5ZnkZEUqtjGdmwlxTacR2/q
         EoipY/GPGceJaCL4CP/qWDXeyHy93kpyRvpHtbkS8grvPfUBMLsTtkQ6dC6Y2G24DTt2
         MHQ4MO/CcpCGw/mPr93QrMEQwb+dcsFczw7GQJx+jppJ+y6l7EluEPlRhkV94RmEFvJZ
         f2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sgKpZyXe1RA2aKFIXpkMig08CCiL4HHEz1mEC5W3Zd0=;
        b=kuEZkZPH7TnBZXMC85sTSrLokyxMJryJfNcfJp/FKBiaz9ldG7IxnLJark2KdN8eN+
         7QIncyroQ5URuQnwC1Zc+LQJdwGY7Uh7oPs2kW11tXAuK6oG/xfmbA3TYla9thCK+roI
         DcZ2XyYhr23w4vz4RjhTCXaAutBgbDAtP6V0jZFXd/z/a4ym/ad7J9IFkcR/OMkHJtqa
         FjMp2CIE0iRGmWNoFlukhZTlAKSPwfP58bqzrrU+rFyQuoos0YsCfuZ8CGiTh66xXPmW
         T+uFrjWHf02TuoAjnbTGN67GOFjcr1T7etZXhUvMpfKzNPnKBQ4VqjNclU2v3NMue9cP
         LuWw==
X-Gm-Message-State: ALQs6tCem/YkxJTEXJU/blXR1ZePFHmMNr0iA58vyXrjW9n+OJMcTBq3
        o7ST1a0qUWHnFdJWApOgXUGZmiGV
X-Google-Smtp-Source: AIpwx4+SHyb4EHK6JETr3NzZ1EdG2hF3dqios3ENqdpmlveFFO3cUuqMvep8CeFvh+y0FIV9lE2DHg==
X-Received: by 10.223.188.12 with SMTP id s12mr4501318wrg.266.1523481686875;
        Wed, 11 Apr 2018 14:21:26 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:2863:8879:6ffd:c5f2])
        by smtp.gmail.com with ESMTPSA id m62sm3726489wmc.25.2018.04.11.14.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Apr 2018 14:21:26 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: fixup! [PATCH 2/6] doc: align 'diff --no-index' in text with synopsis
Date:   Wed, 11 Apr 2018 23:21:09 +0200
Message-Id: <20180411212109.24051-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <xmqq7epe3gfe.fsf@gitster-ct.c.googlers.com>
References: <xmqq7epe3gfe.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-diff.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index ee1c509bd3..6593b58299 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git diff' [options] --cached [<commit>] [--] [<path>...]
 'git diff' [options] <commit> <commit> [--] [<path>...]
 'git diff' [options] <blob> <blob>
-'git diff' [options] [--no-index] [--] <path> <path>
+'git diff' [options] --no-index [--] <path> <path>
 
 DESCRIPTION
 -----------
@@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-'git diff' [--options] [--no-index] [--] <path> <path>::
+'git diff' [--options] --no-index [--] <path> <path>::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
-- 
2.16.2

