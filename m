Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354921F403
	for <e@80x24.org>; Tue, 19 Jun 2018 22:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeFSW16 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 18:27:58 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:33544 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeFSW1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 18:27:55 -0400
Received: by mail-yw0-f202.google.com with SMTP id u207-v6so825815ywg.0
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=wEZaYyobY2Jg/Tf8hKyQTsuqZdqPwKMTsSqsETlqKr8=;
        b=Zk7xAeIYsRylrWpB/HHDWcDIS6ButB4PKc6eSlbTIC85AZboOxhLOfatnZ0ERo+kS0
         UFd9rDKBKyRpwHUYnXy17QSvYj8TYNe0uUUFMCGf3WDkLyTFctrMfyJjekZ/F6J2Qgec
         qes6UKB6DV/w362P4xwDnwvgQyRD17JB8jvrNDaRp6YWDr/w0nCUHrJzYI5z58tu5Tw5
         c+MWSyEoSXgghBM3MmsjEEZCW1SH1foqk53DqUljCFfadRCX4aJl4X3no6OMhn8FrDM8
         aNMoRg7Xt5yGEhacP+tp4J/yJvXeiOO9ZGcrdL/Kp1Ko32XvuiMp6tYlvG6XbAAT9TcM
         ZqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=wEZaYyobY2Jg/Tf8hKyQTsuqZdqPwKMTsSqsETlqKr8=;
        b=cu9rPyShV3gLSr733ujhJhFQq6+XA+gT70pNbGCA1BR5HDwOXB7RcJpsgJXr7oendu
         na9Ny2uNoL8gGJxsDCKWF+ObSP/tFe/B1xlhOROFvM+yQK56mPV2v3Ip3Arc1IVuTQaZ
         NvhggCQVE6Hx5o+PTsFp/kL2CAxwXfROjmjcWMtIysvtFZKcA5hgnMcZWhSHWxnmS8gb
         clMmy6bQ0zl7ryCf7Vjs5J8fP1cijCuHoEQ1KizGcJwKj8kDo1ch4mAxq/j0/+P6y865
         hxt7azEbg49NMfqQEuBpk9jb9LY33ZNJu2LpijRGlxxbkYP0xFCDDdcurKoknr4giJ/M
         X0yA==
X-Gm-Message-State: APt69E1jtsS+t1FzgKmwaoneST2/QBMA+z6aY63E8K3+CN3mNWchJV20
        haqDb10ungUTI9DL/wVTQFuYUAx5em6U+mTQm3ZC
X-Google-Smtp-Source: ADUXVKKvEW0Fw8+6dJWMLMkBC0sli8zfO5OeHEP65sqOo0OKgHDcxgE2XBUskaUKVrHcGF7OURz+3LHhRU9pvveBTkwQ
MIME-Version: 1.0
X-Received: by 2002:a5b:401:: with SMTP id m1-v6mr5055193ybp.39.1529447275067;
 Tue, 19 Jun 2018 15:27:55 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:27:49 -0700
In-Reply-To: <xmqqsh5jwzp3.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180619222749.124671-1-jonathantanmy@google.com>
References: <xmqqsh5jwzp3.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: What's cooking in git.git (Jun 2018, #05; Mon, 18)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

Would it be possible to have my patches that make bitmap_git not global
[1] in this list? Peff seems OK with it. Let me know if you'd like to
see anything else.

The original patch should contain an extra paragraph that I've provided
here [2] in the commit message - let me know if you want a reroll with
that extra paragraph included.

[1] https://public-inbox.org/git/cover.1528397984.git.jonathantanmy@google.com/

[2] https://public-inbox.org/git/20180611115046.d03f8093347dc6c0e9b116fc@google.com/
