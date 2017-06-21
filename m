Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7F620401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbdFUSSq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:18:46 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33298 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFUSSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:18:45 -0400
Received: by mail-pg0-f66.google.com with SMTP id u62so23774546pgb.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=0qfQTGoyJ79jD7F748tlweWVeda1saLckeZ40GDZTto=;
        b=E6Fhvqb2Dfn0e58Lkeedgaa4KlCSFHiloMh8ZSve4qO8kR1/VR/drs8N1qf5mfe55F
         YHDHGIG9a+bN8VDM0M57H++cCL2EQ2WYxItMM1vfKB+1vVZQ0nbYu039qusDmtAlimTI
         SmVKC+RaXkaTT2CZbQyOYFmduNN0K04OMCVBHALIPJ39CLrhKblb4HESUkkcbXrP5sZC
         USiQjhxNpAvl+rE0NzvkcxyEeTusq0L3Qgh+zo797QrqrkC+FZ/UAvaB0PDQOs5wbm8k
         M+NoboQ0bL9FUidmwV042Cab5o69AkKAIBXEi+j+zryw7WxJ5kaYbQOC6p3SqTSKDWRd
         rvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=0qfQTGoyJ79jD7F748tlweWVeda1saLckeZ40GDZTto=;
        b=JITYHoAAaQY4uVVd8lmln0Ihfa+S8AjJMLz0uvxVQhFYJONgNAOtpDyFYg5+6+3PJl
         A6GeGiRuDTRsmX2x3AJRxIMVOoRx2FzX92QqbPrPxXz2Q5TPPBhzQ3PfGhyUP6tn5u9S
         sl91jtZbKVAGOk0QiwcnQ5ZSlGfylYkUeGg9FjwgdEyplT6tfvmiW7oDv22K8rG2H2y5
         UikXlNtA2Sqs87JQCvsQw85nxGLB/2GR8zk6VlM8vP1SlscK9iJmIdNuRg8bQKMpSs8c
         fz9HuIrarBU2v27e7AJD++3s3fMO4DXTZkypWlTPKo0tq3F9EzMad9gD3S9Kq8I6D+FG
         U1QA==
X-Gm-Message-State: AKS2vOzr+yqNS/TEcCJIgFOPRgmVjR10ZxKVq6V0txSgOR2T6sVbxBkr
        6AOrRJEUeUiCoM6KzJNe+A==
X-Received: by 10.99.160.109 with SMTP id u45mr35876676pgn.138.1498069124935;
        Wed, 21 Jun 2017 11:18:44 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id s131sm37412901pgs.6.2017.06.21.11.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:18:44 -0700 (PDT)
Message-ID: <1498069113.32360.12.camel@gmail.com>
Subject: Re: [PATCH] status tests: fix a minor indenting issue
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Date:   Wed, 21 Jun 2017 23:48:33 +0530
In-Reply-To: <xmqqwp85qozf.fsf@gitster.mtv.corp.google.com>
References: <1498048305.1746.6.camel@gmail.com>
         <xmqqwp85qozf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-06-21 at 09:34 -0700, Junio C Hamano wrote:
> Your patch is heavily whitespace damaged, line-wrapped and
> full of <A0> (nbsp??) bytes as can be seen by downloading from
> 
> http://public-inbox.org/git/%3C1498048305.1746.6.camel@gmail.com%3E/r
> aw
> 
> I'll hand-tweak to make it apply, so no need to resend but please
> make sure you can send your patches cleanly before sending a more
> substantial patch.
> 
> Thanks.
> 
Sorry about that. As specified in another thread, will be careful about
sending patches through email-clients in future.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
