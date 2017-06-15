Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E37120401
	for <e@80x24.org>; Thu, 15 Jun 2017 19:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbdFOT7n (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 15:59:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36265 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbdFOT72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 15:59:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so2798893pfd.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uPXn+5YluFzoXyHrowne6uyYSf04igGoKzWshAOFS0A=;
        b=d3gKEyqum1it2joES0CeebS5+3cJRqeeHPpWp1dc4oHjqKXJ96upf/mG6ifazcdyss
         JiyGzNSWRPDy+meblm0R7cygxOYFXzrG+en0Tkx1v8o/wd2ZN2e+UcJqvik3vqX+EFV9
         Ir28mRZp81sIijA4wkfil2T7H1rZ3DAB22q/k4U/sQW9Ow8qzWzCNUyXocFTbC3skMBV
         epzT/cIgc3B38UXYgLNIOspeuz2QAClQPvvmbKWqSjtkbGo32Bcw1kvJcwNEdQ341fIJ
         DSfxxzMBbuZsSATsQrx4+vOh9dfwxsllMfnBTGia00d1Se8PSvyW1MpkarGsIyKYNYwS
         uyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uPXn+5YluFzoXyHrowne6uyYSf04igGoKzWshAOFS0A=;
        b=lKBMa7KeHx+fCGRlZ4d1rckFKgjuDDSh4nMfG9i20EcMwnFGQGngc1gRcU9AVj7+vn
         JhzT83rm94Q18AyjCF8Toc42tAAGOwU/5ilxCHNr9ZlyMcHssVmzn239ZqdetZtE2LUm
         HJnoSinFS5gFRhHacVWJ0XetuS1kJIhj3CcJQUhCJjg+4Sl0yhJuvERXyyj80Go/a+em
         duCJt91bWpy8YG64Ly68NsCapIkOaXZJrMzk5JZkUvSohL55eMk5wzncp/1l7gRBZNE3
         JMt5CffSety9RmOi1htYyy1DWVz9MgEKgYg9KJIbmpPTxC93oYY2kH7mwwqujVIv4s45
         WpYg==
X-Gm-Message-State: AKS2vOw93RYC8ngoZZKUiYY9q4i8dHrxS/yn5t2vfeA7wC8akiObdf7l
        rFDNQ29K6IXfkQ==
X-Received: by 10.98.149.142 with SMTP id c14mr7037376pfk.29.1497556767945;
        Thu, 15 Jun 2017 12:59:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id n71sm205195pfg.46.2017.06.15.12.59.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 12:59:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 0/6] config.h
References: <20170613210321.152978-1-bmwill@google.com>
        <20170614180739.72193-1-bmwill@google.com>
Date:   Thu, 15 Jun 2017 12:59:26 -0700
In-Reply-To: <20170614180739.72193-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 14 Jun 2017 11:07:33 -0700")
Message-ID: <xmqq8tkt10pt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Changes in v3:
>
> * tweaked the discover_git_directory function's API based on Peff's feedback
> * reordered the last three patches so that they flowed a bit better
> * renamed 'git_config_with_options'
> * rebased ontop of v4 of Dscho's alias series
>   https://public-inbox.org/git/cover.1497440104.git.johannes.schindelin@gmx.de/

Applying this series was messier than necessary, I'd have to say, as
this series would not apply cleanly on top of the result of applying
Dscho's v4 on top of the same base as Dscho's v3 was applied (which
is v2.13.0).  It applied cleanly only when Dscho's v4 and then this
series were applied on top of 02a2850a ("Sync with maint",
2017-06-13), which is a much newer commit than v2.13.0.

Which in turn means these two fixes cannot be merged to 'maint' as
you two collaboratively prepared.

I've applied Dscho's v4 on top of v2.13.0 (just like his v3 was
queued in my tree on the same base), and then tweaked this series to
apply on top of that, so that they can go to 'maint' if we chose to.

But it is possible that during this unnecessary patch shuffling, I
may have made some mistake, so please eyeball the resulting 12
patches carefully when they are pushed out.

Thanks.
>
