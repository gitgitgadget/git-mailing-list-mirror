Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5458F1FADF
	for <e@80x24.org>; Tue,  1 May 2018 22:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeEAWZF (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 18:25:05 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34154 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeEAWZE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 18:25:04 -0400
Received: by mail-pf0-f171.google.com with SMTP id a14so10068191pfi.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 15:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghqRsthVXYgdiqliU0agwSfSbuxIhiHdX2nSdL5A47U=;
        b=BpEJ+SuslcA0qvFEohIVCDGN2qpyM0FXSOa3aQhKt7FI5lsC93euFUBZ9tb0QkhrLg
         JFk6gx+Bx3kRDEAl2Y8z5Ts9Gz/aiAEpXPsREi/BBMIJZoDnv2orFEG5Vdm8HCYQYl0i
         021d0hu9WvhzWzQtd3MbIBxGPD+kDfVg2YnQlLADg6kryq9ox6T2m64H6yY1aRTNBof4
         LUeEK+bhAkEHpw1WCNbLFsKq/Ub8jcJNb/A2ImEr+XBg5zqD5XKRwIn01ra8D0sr8XcJ
         qn27AYcH0d9z4tCzV4TPCGSyQRswBOWQv+Jyiuvz6UrruhU1noEwj/jn1EChXrHNVE0t
         U0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghqRsthVXYgdiqliU0agwSfSbuxIhiHdX2nSdL5A47U=;
        b=mWwRf7/RnYuhD43jL6nfOOHE7TwKG6V2jNnlI+5ikI/LpDnuceZNlE6aOrTuuOrP/s
         sGw8vuiRJDvLSSwIpoD2KPAI9iUwCdr0WTXa/cFSfIoTd9Z7YY46bG8mHBXq2bzC2asX
         IZBDiIcCE3LfHdTB6ZYuCicxG2kzL0SGjv4pRfI8o7oTRsnf8Qm+69mrH3VIATZuaKFO
         nhhi3OuRy3071fQxE4GqgwpF7suGMFsApECIRbKIGi0vLl+ZhjOAmv+7f2Mp52hw8GP7
         u40YnJwnkjqrgAomIKziFRQFk3MFz4NoLi0ziwTvPyYDIDSla09UyyZqkpPJeOKZoCVM
         8N5Q==
X-Gm-Message-State: ALQs6tA+VjuDUYwtlJJ3P1XC96XP8luvCuP0h9/FVdidkJIx2f8XlA92
        IqLrcUuerv4ZwpIq934t+6HMYQ==
X-Google-Smtp-Source: AB8JxZpR2SM8zU1k+EZasYL0RKqkottPYbkv3ekyKdCbTwO9Ot0fseaseczS00ggERNDEXk2qHxKew==
X-Received: by 2002:a63:9741:: with SMTP id d1-v6mr14532596pgo.447.1525213503974;
        Tue, 01 May 2018 15:25:03 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id t14sm9773330pfa.31.2018.05.01.15.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 15:25:02 -0700 (PDT)
Date:   Tue, 1 May 2018 15:25:02 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] upload-pack: fix error message typo
Message-Id: <20180501152502.eecab4844934aef6d3f553b0@google.com>
In-Reply-To: <15e1fa5e6167932d878aa08e81d541c403935172.1525213052.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
        <15e1fa5e6167932d878aa08e81d541c403935172.1525213052.git.jonathantanmy@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  1 May 2018 15:22:20 -0700
Jonathan Tan <jonathantanmy@google.com> wrote:

> +test_expect_success 'unexpected lines are not allowed in fetch request' '
> +	git init server &&
> +
> +	# Custom request that tries to filter even though it is not advertised.

Oops...I saw this copy-and-paste error right after I sent the e-mails.
I'll remove this in the next reroll (if there is one).

> +	test-pkt-line pack >in <<-EOF &&
> +	command=fetch
> +	0001
> +	this-is-not-a-command
> +	0000
> +	EOF
> +
> +	test_must_fail git -C server serve --stateless-rpc <in >/dev/null 2>err &&
> +	grep "unexpected line: .this-is-not-a-command." err
> +'
