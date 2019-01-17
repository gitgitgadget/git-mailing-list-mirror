Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4ED1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 18:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfAQShc (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 13:37:32 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49469 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQShc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 13:37:32 -0500
Received: by mail-qt1-f201.google.com with SMTP id n95so9877893qte.16
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 10:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/XaBbci04tMe0OtUcb3kEIksiNTeVvOIdiT1gnLNIrY=;
        b=aKW6rTypmEZHbnLYFdM8PoSdmp4M2lARvF4JMxhZCO/haAxQsQ3DU1TVnS0ZTrczCa
         BZ+/dqcyIWIbuijnD8QHv3xD+5OOaoran5jimSdc15atvi+mz+LxaegmWiTf+p98fKdi
         54LziqX7fNjHKqEKuhK/4njUqdfXEN1nB/9SLlBRcFEfpx9fLNKOWLE1rB4kUasMp7Bq
         nOvDfrFTMwGL9SvQUEc3wNYbSddDK7K1ObozYJQcFFYUrR5bC4k+6gFHNiH2AbVYDnTS
         h3NNPKVgDcHcjXX90yf+pUWwtZ2PoKegViPDzbGCHQn1es7aALpkkaSPQVIT8oyAbeQx
         BF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/XaBbci04tMe0OtUcb3kEIksiNTeVvOIdiT1gnLNIrY=;
        b=TIuf+dbAeAivmdvgVOQzkrW41yZ+UYH2rmaLKZGIsVl3I9XzogwhlJnCaWoPt/seIg
         t+LFKAea2MxorkQXt4AFxBzRUCG6U43xrYy34AcqY67mKz7LBCzt5urtitMQBxpmo2KK
         B9VzaxNJVILdKroRLLSjC2FRef6rW9gAA6iBgTUHuRLSRHZk11zqFt5blFpgTr2PhuYU
         LUE+zo/8FnkTwd3pPyfnE2pq0HhRyQqu0yL2v9f6bJ6uTW7qFVUPrgXIdKtFHrc/tkhJ
         tAPLeKmAZJeoBzXRTmok/aCCKPNeTlq9oZEovgVkvwv+EbIKTgdknYp3YqWJKBLT5cUO
         KlDw==
X-Gm-Message-State: AJcUukf99oA2ni4EqlTT+qTDi6ePpSp+0VutAsBOaJF9MTGMBl6atx+J
        DKYIEMPUC+ynWnGM0fdeux5FzZ19GglNcbbarXMF
X-Google-Smtp-Source: ALg8bN5e0zht31NxvjEB6UqPtsKVxbrb3axSRI/nvq2RynTUFQ3htMHI3AUEI0RaGtAWfkrj83xSytFDwTzdJ6xdckW2
X-Received: by 2002:a0c:a8cd:: with SMTP id h13mr8761837qvc.54.1547750251663;
 Thu, 17 Jan 2019 10:37:31 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:37:27 -0800
In-Reply-To: <87o98f4ol6.fsf@evledraar.gmail.com>
Message-Id: <20190117183727.260298-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87o98f4ol6.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [WIP 0/8] Trying to revive GIT_TEST_PROTOCOL_VERSION
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm happy to have you pick that up as you've done here, especially since
> you're actually working on v2 and I'm not, so you can more easily know
> what it conflicts with etc. I just wanted to have it in one way or
> another, i.e. be able to deploy v2 and assert that "next + custom
> patches" doesn't break something for v2.
> 
> I think [CC: Junio] that we shouldn't be concerned about an addition of
> GIT_TEST_PROTOCOL_VERSION patches in any form breaking the test suite
> under GIT_TEST_PROTOCOL_VERSION=2, and just be concerned about the
> default GIT_TEST_PROTOCOL_VERSION= case. I.e. if we have v2 patches
> in-flight that break things no big deal, we can always circle back and
> fix those things or annotate the tests.

That sounds good to me. My main concern is that this will end up being
dead code (if we have too many tests that fail with
GIT_TEST_PROTOCOL_VERSION=2 and no one bothers with it anymore), but I
don't think that will happen - in this patch set, I have eliminated a
lot of false failures and strove to give reasons for the
GIT_TEST_PROTOCOL_VERSION= annotations, and I think there's interest
(well, at least from me) in investigating the remaining apparent bugs.
