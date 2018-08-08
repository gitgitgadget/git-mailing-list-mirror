Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32312208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeHHS1E (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:27:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35393 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHS1E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:27:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so3363870wmc.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QtzPSSkTJI32rvux29LZRmmPXEdt135yJ1UhCuK/lPQ=;
        b=bzJsxj/O8Wu/T4BfhmDgX1ObRuLdSHFc5VaQWGalj66ATC5bSdo3k0GDKbbDgjet6Z
         o39ieELkMLzUFQPG1IPXIxrfjvg0gJgnSEo+mYuwUuwIblQDT/UcNumBeGPDv13uoEc1
         KcMQ+uxuGvnCDRenpRNBAtJNjkv1oAvz5uYOK6bhEX4WY+RnIaBMBb5ZtfbrUXiVFGMo
         /L2+XXtLhf6pP761bOu5nZAC6UScFtGL+uZQpXlFW1TqD5QXRxFqN9sBTe2g2hSEHBvG
         rfmRC5oolGmRg1fX6GRXnwPdr9ssj2DACdonbHKwOuqWWtokvkKz6VLgn+B4q0McaUeN
         lDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QtzPSSkTJI32rvux29LZRmmPXEdt135yJ1UhCuK/lPQ=;
        b=F8pa0sJunO5vmeduHjrOGT4qfB3uKuAAbDVfKdECXI4Y0qMcQmnMi+TDHlI4o53LmC
         Qp6Lq+XNnoJ/5byQzpaPk5ygF7dEE6GlcKCacrGozzTNV7XpCntPhfEu4OdDpIpullYL
         sukD7LPBEefxHubVPCmPpKvQ6Luso7vVApgT6OOTRUSghk4GaGK4+gjBjiz9OtJbT4lx
         N5xSEYONYeDz5ZihFhvcJGe3q4sROGUEh6KGvxmRFqS1N5BHBqQ1LzSmBygrdAKJCtCa
         R1Lcl0NWL5VBMXfx3FvhYNArhx5ZpRoyIzZdxX67ovG11hCibNlBi701AD/FM+aStep/
         5qZg==
X-Gm-Message-State: AOUpUlHInCqPYbT+A84ZPu8njTlUUj6krbYoX25lXB1AhYVEaHlEYniT
        EtXyZ+YlWDBgPxxFMN8xkfo=
X-Google-Smtp-Source: AA+uWPy9xmVsFrCwMzDXQBPIrtHVSyT2N7j1H4ohUjfo2Ol4IDXjy8Jfg3/VoI4oy120eZGjXF+zMg==
X-Received: by 2002:a1c:ec86:: with SMTP id h6-v6mr2324205wmi.53.1533744402616;
        Wed, 08 Aug 2018 09:06:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x7-v6sm3760173wrr.95.2018.08.08.09.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 09:06:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix two grammar errors related to the word "save"
References: <pull.16.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Aug 2018 09:06:41 -0700
In-Reply-To: <pull.16.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Wed, 08 Aug 2018 04:49:57 -0700 (PDT)")
Message-ID: <xmqqmutwj10u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I stumbled over the one in git-compat-util.h while working on an unrelated
> bug fix, and then got curious whether there are other places where we use 
> save instead of safe, too. Turns out we do not, but there was another
> grammar error where a spurious . interrupted a sentence.
>
> Johannes Schindelin (2):
>   git-compat-util.h: fix typo
>   remote-curl: remove spurious period
>
>  git-compat-util.h | 2 +-
>  remote-curl.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Fix for typos made in 2009 and 2012, better late than never ;-)

Will queue.
