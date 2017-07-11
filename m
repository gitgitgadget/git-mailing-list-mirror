Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2472035A
	for <e@80x24.org>; Tue, 11 Jul 2017 18:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756011AbdGKSGj (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 14:06:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35919 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755800AbdGKSGi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 14:06:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id z6so811396pfk.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=fnEI7ODiR2WPkQhexvn1oIX+BXIvT8JIkafHzjes8f4=;
        b=oMMJ0x5gdAy8HDoEquAwqmHZlXfXTWzjNc/NpeH0vSFzu2GX2io1ozsPrvNnfIHLyA
         t8iTzBO9F7tzBuOksZ+3myqFbOR3IRi0p70OswRcr7cTUOQVn9tCfX+Ho1fIpaxvsngO
         96FFa2w090t1zYot3ox7Fg60ByTK5BPaik909xPiLuRNRR7q0Cbrv181g45WRqqeu/pj
         sYOGOOO4NP2Wuw769NtR2PFsX+R/7fAIjqQ5M/xBpG/0gpoOvg4tA2ykbALIFW97DvGF
         WMywaCdP1F+yyIlj+iAVyEJKoEE3oEiUNH/kB57RI6M5AnRVy8FdUjYNRPQcgOWLOoje
         QjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=fnEI7ODiR2WPkQhexvn1oIX+BXIvT8JIkafHzjes8f4=;
        b=sFwX6LG/HOlyQyvJNUxyMu+puAKMyGRG70YviDb8FWvdpyWX5xU8EiiiulX8Dn9A31
         RlzRIAV58dV84I7psYIOM8nOVlGoNd17Rn0imFCmRm6s63nVaWTdAWm1Owltta7AhyxJ
         5xVs7lZ0oEe6Zztk7RDr55gLpsDBnBKEcMP8J2di62RmJ4wbWTOXRu2kmTzV+kKPX0UC
         +/IbLeAKM8vJRAg/pADSZf701aShBG0QHyVu19MA47I/4BRt/Voowj6928vXSyE6RVgv
         0hSuyl/8B9Tp47GAzflLmqnn5M1EE5fQSaT5K88AgrdPDnrZcJa7vAQJSJvEaGkQZc5I
         8bbw==
X-Gm-Message-State: AIVw113atKftBozXsYoSNzM9OdFtA45dxuPcSAGTV0tlzwRfIdxpuK0a
        6VAbjFbVrtoQABrrR/Y=
X-Received: by 10.99.175.18 with SMTP id w18mr1142278pge.67.1499796397695;
        Tue, 11 Jul 2017 11:06:37 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id 63sm927732pgd.57.2017.07.11.11.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 11:06:37 -0700 (PDT)
Message-ID: <1499796408.3180.4.camel@gmail.com>
Subject: Re: [PATCH 4/4] hook: add a simple first example
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Tue, 11 Jul 2017 23:36:48 +0530
In-Reply-To: <xmqqtw2j2c6r.fsf@gitster.mtv.corp.google.com>
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
         <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
         <20170710141744.8541-4-kaarticsivaraam91196@gmail.com>
         <xmqqbmos5add.fsf@gitster.mtv.corp.google.com>
         <1499779787.1740.5.camel@gmail.com>
         <xmqqtw2j2c6r.fsf@gitster.mtv.corp.google.com>
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

On Tue, 2017-07-11 at 09:03 -0700, Junio C Hamano wrote:
> But does it even be useful to enable it?
Just for the note, I thought it was considered useful (at least to
someone) due to it's presence in the sample script.
