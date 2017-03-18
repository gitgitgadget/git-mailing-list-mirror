Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27ABF2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdCRSmP (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:42:15 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35943 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdCRSmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:42:15 -0400
Received: by mail-wr0-f174.google.com with SMTP id u108so69717815wrb.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqcHXw8Pyw2LPxTleEdOulOCkAcpV4iZMcW8tgEnEUU=;
        b=fLoOoiOqsJL8+Ya10eBLKIGhGMgiscZiIFHc5cPeM+nf4w0GETW3+tX8Kud/yhqmiI
         B6fhqM0ZHGUZnmnc2uKUEGomqT/mSr3abSwSBL1Ni+gOU3cXdAnKEQ9U4tWO5emXTwaS
         RrXmlSY7dr3cY2Vjmzz+uW8Mz0J+CcDiVU0vvNkik0IM7E7XqwsIOrP4dNbFM9D8rHFi
         7MbIdEXcK+pNwTBR2WPVQjW56SdK3v07Ow042E7oJ4sJHY9lzyKS3RXY6rQB0CTLvmWT
         0faY3dlHpkD/3SAfNt5rBybJH95yLPRFGLwJDi8KqY+kA3pcCjbkcgbWVu+X4aGiJMme
         mpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqcHXw8Pyw2LPxTleEdOulOCkAcpV4iZMcW8tgEnEUU=;
        b=AL46jdhUjnC/cCE3W2C7a0gKnP+nfGcSBvR3DZwgYiWudgrJV1I/EX38QjFY22mEmk
         HHs374pVPHo4d0/K8TNTHv9kTByxP615wQSieFqq439iuSF9Yj9zbC4b8WW1KrH7SSqb
         lSNvoRcp72J6/cpNEKGxH4pnLkrKNkDdTCcdYgZUVmDnnGWrX4keN09JqHBM0mAte/KI
         2CLq56M+CVLis30xYN+fe+wpiXcoeilRrjes/ZFbpjCBII8/BgjTTSmyAcFUhvU+N63F
         faUG+mt8rJmfZ384YW3nOqaU5/mbez6Y32ZygoiHnqkGFJijIIDnjOcUXZvgbTwutXt2
         5hgw==
X-Gm-Message-State: AFeK/H1jxX4OaoctH3X4Uin+g22j86d4XIxBpoRE2Ob4+bbPZKzdBdyV2Dcq6ohbNaDmGg==
X-Received: by 10.223.168.80 with SMTP id l74mr18878889wrc.184.1489862532759;
        Sat, 18 Mar 2017 11:42:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e16sm8026263wra.62.2017.03.18.11.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 11:42:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] doc/SubmittingPatches: A couple of minor improvements
Date:   Sat, 18 Mar 2017 18:42:01 +0000
Message-Id: <20170318184203.16890-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqvar6310x.fsf@gitster.mtv.corp.google.com>
References: <xmqqvar6310x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 7:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I'll retitle s/Remove/remove/ so that "git shortlog --no-merges"
> would look more consistent, though.

I already found a few grammar / phrasing issues with the commit
messages, so I'll just change this on my side for a resend.

But I noticed that this casing rule wasn't documented in
SubmittingPatches, so here's a patch for that, and while I'm at it
another small improvement that I've been meaning to make to it based
on a local alias I have.

Ævar Arnfjörð Bjarmason (2):
  doc/SubmittingPatches: clarify the casing convention for "area:
    change..."
  doc/SubmittingPatches: show how to get a CLI commit summary

 Documentation/SubmittingPatches | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
2.11.0

