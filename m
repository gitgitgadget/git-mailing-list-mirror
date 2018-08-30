Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149D21F404
	for <e@80x24.org>; Thu, 30 Aug 2018 22:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeHaCP0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 22:15:26 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:55891 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaCP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 22:15:26 -0400
Received: by mail-wm0-f46.google.com with SMTP id f21-v6so3383944wmc.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xVDsLNj+ertlsJOjlFSdXrgBFi5nVkBQSKUDTgIRx3I=;
        b=PduKbOV2Ja9sw39zhTyIPpLBEz2R0XbjMi2hidqKU/hl0rl2oY2Y+/NsmldwBxySDQ
         9gbWtIfaBjHHEV3A01+OTZu0gBLubkCrR0HCvLozjIVBu5Q9lAsXQgfAfXrIDYdAe7mM
         KnBIpnhqXhmmbh52xT2Uiok8+EKrYaJb8EQFzYTBQWDEOOyKnhWqHMC/CmMN74Ywb7yM
         vLLy5jw5WFvU0nStpA4f6Z7z/jXRIVYYCO7OngaqQb4qtjwZfcdjOWWYOQrJZycLowCl
         y0zWBFVSIsYonaV+ozswTpVNcKRSYa5fkDnp3yO+807KpLZabxzSuKtig/5+mrlhMmlO
         s01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xVDsLNj+ertlsJOjlFSdXrgBFi5nVkBQSKUDTgIRx3I=;
        b=Uk11njDLUGlaoN/HBIf2CCm03escZAfBvmrlitrXpHQZ/7mP6aJgYmArAiLzO/p2xi
         cRU1xUSHVm9bgCWO7/VHxoFSxMrH7wP+/WSTq/JKmRLxK5piO9DBHozIKas/8XFgrJhE
         LPuReoBSDMKtX8Tm0/ICUGTWiXmCqI3hWanPt0jBcItBAzaZsItCvmyPFkCCAy/enYzN
         EriYRhIaY2x++0ujAWwseZ3FyWDXGCCq1fAUrj9hs+O88nruXsjRzSzfsOxT5UAcpM5B
         wjeS7KeCCaTeB7ZPSWJVr11H60xYG6KqgSLLAIa1Ox+gwY7HM8fqYCKsM/ETPBuEqYj5
         94LA==
X-Gm-Message-State: APzg51B91cUwIi9X6EfkaUZsdiZQ0oLRXP+4opPGdR6K+irhY0Fd55FO
        WWiuIccKYUDAWOMHIpqshHk=
X-Google-Smtp-Source: ANB0VdZRGFsNerb4snridOJBhYzzqAyYHgOaCF7Z4YsAeJgkSxM/zAz4zKTZIC5aO6Cy41HyCBf63w==
X-Received: by 2002:a1c:8952:: with SMTP id l79-v6mr2881848wmd.7.1535667065636;
        Thu, 30 Aug 2018 15:11:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m3-v6sm614683wma.25.2018.08.30.15.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 15:11:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 03/20] stash: update test cases conform to coding guidelines
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
        <2e7eef95b626721bac48d072aa0869452fe4297a.1535665109.git.ungureanupaulsebastian@gmail.com>
Date:   Thu, 30 Aug 2018 15:11:04 -0700
In-Reply-To: <2e7eef95b626721bac48d072aa0869452fe4297a.1535665109.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Fri, 31 Aug 2018 00:40:33
        +0300")
Message-ID: <xmqqlg8n33pj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> Removed whitespaces after redirection operators.

A clean-up that is long overdue.  Thanks.

The result still has some rooms to improve (e.g. the preparation of
'expect' file probably should be done in a test_expect_success block
of the setup step; some are called 'expect' while others are called
'expected'; some test_cmp invocations do not have expected output as
their first argument), but that can be done later.

