Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F351B1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 01:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeCFBg7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 20:36:59 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35058 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeCFBg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 20:36:58 -0500
Received: by mail-wm0-f41.google.com with SMTP id x7so19130045wmc.0
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 17:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hVASIvgDlU8RdlS9RJfLDdPpEPfUZrYOuX2KSa9idC8=;
        b=uo1cVMZ/h9uUkssqBpVDMOT7kTl/tdm/z7GEYYq0JgZloDAnmo3y5689FbAjeruQLk
         QAYTRHJU/LgyoY7T6iU19wdMb9OKpAbIMw/4pEinogX1Oqb3dz8U7EtsOU8KMQM70Q0n
         enNhPfgwwjQ6HQUYG5GPJqH7Q69Fu8znxM2cBbuWnQHE2ubpbTys0DHITF2w2WPJgLNZ
         2Xyi9QEg9bKSjZ6bkgX9pYRyVBBI3tkubXWZOBpEalTzUKrgFO0+6HVnaoLEWYGTQJeU
         Ur02IQpL0zaxEpnhMqDmVkCRzgQY64Cvs2Wh+uHRbswH5eItN5nQLVH6IzLb26ODE0wx
         spjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hVASIvgDlU8RdlS9RJfLDdPpEPfUZrYOuX2KSa9idC8=;
        b=shoAiHOJPNfHlT9/OnwGgmAKAaxTJems4FC14EcrWVz7HtHj/5Nbc62G7sgWCtWHOv
         9jqezmJqD6aLCuF5JVMi5ohslSTB3Xez7jYnoVCGv/azbwywBpLwiacWKV1Md60EvZ0z
         GqOh+RjLG515P87ZCMIZ2nz3xfGI8tvgNhXqHiAT0EjnrYHNz4SFfK3FIUNI/ZFP2Y8f
         EKgIFO7qR9XPgo/dHHq1+L6bNLEEcaA6rjT9KPF4aU+s5u/plo3ztgRrx6xv3mlhvv5I
         GVUHT/dUuv+uvnLRa7Z09uUn1klfpBiZGEl4KVBH6O02XbfwWjzFl8teXB7WAfU6tts5
         u2PQ==
X-Gm-Message-State: AElRT7H37Q3BgUnhNXu/9V/7Q5VhLmHAynPjJoDsyOySmx/yWcfGEZs2
        +8siJL7F+XayErDK6MU3WPI=
X-Google-Smtp-Source: AG47ELusHq+Qsq3q9KHL3yL1vkMlqRvCrvFuajEeTBsEWYbJjmG5rxcG006/lPK1RUmfKzhw9llsOA==
X-Received: by 10.28.136.18 with SMTP id k18mr10505455wmd.111.1520300217244;
        Mon, 05 Mar 2018 17:36:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v63sm40625884wrc.69.2018.03.05.17.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 17:36:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     kalle <kalle@projektwerkstatt.de>
Cc:     git@vger.kernel.org
Subject: Re: git help clone: questions
References: <6ea2b41f-37c3-8540-4763-7688f56fe202@projektwerkstatt.de>
Date:   Mon, 05 Mar 2018 17:36:56 -0800
In-Reply-To: <6ea2b41f-37c3-8540-4763-7688f56fe202@projektwerkstatt.de>
        (kalle@projektwerkstatt.de's message of "Tue, 6 Mar 2018 00:10:01
        +0100")
Message-ID: <xmqqinaa6l3b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

kalle <kalle@projektwerkstatt.de> writes:

> -In the explanation of the option --reference: shouldn't there be
> written '<repository>' instead of  'reference repository'?

"Shouldn't X be Y?" is not an effective way to communicate; it
solicits a "no, the current one is fine." without any explanation.

If you think X should be Y for some reason, please say "I think X
should be Y BECAUSE Z" instead.  Without stating why you think
differently from what those who wrote the current text, it is hard
for people to respond either with "Yeah, you're right---I agree
with Z" or with "No, Z does not hold because..."

