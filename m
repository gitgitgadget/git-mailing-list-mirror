Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43758201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 09:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdBTJKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 04:10:16 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36086 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdBTJKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 04:10:14 -0500
Received: by mail-pg0-f68.google.com with SMTP id a123so9358866pgc.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 01:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9fzbGoYf30i2ztFq6cR4wmNloFZv+9Y+OE96yHgJLCY=;
        b=nnXGCq0zbqyJZZeSjtJPUf5jrs5USbVtQcGibnj1otRg0rUX4DqdNeCtGRLLBGRzSg
         2UUL4ps21BTgYmwiTey/dEFEQ9Gyt8mzbIXjyjtnmNiZoeqvKZtUlwpVKoeUybzzmkou
         X2jo4kwmcqmoD9BLGcFNvRf9DAxEF0G2ICOkD67COVWeK4Xpw3dNuXNgGku0ssnSxVEj
         ABLv1UnPWybfMZ1fkzIGnuGWR/xllhQSd5dT6du1Q5hcXOxA7YFWZBcF/4JYDnfpSBb5
         MZ/ahHBAcwWlNkDVM+pJN+QJYNXVA5nj2TubbHkRL/J9JfVsXlt7/jj44r7/QVEZH12w
         YQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9fzbGoYf30i2ztFq6cR4wmNloFZv+9Y+OE96yHgJLCY=;
        b=lj8buihAHahRMOAB9A2fb1zfGKLYtc5NKZ33sG+zDUlKOxZ5Y2q0SGwHoOaZSvvk8S
         e98gL7pI5N7sX1dyEHFmY1UrD9RvQ2Z9CMks/iaLkOycCVql9pQJMD6vVxUdsba2kKyn
         58ZN2BJliS6cprVHsNQBBf8bkOe60G8o0nRAqumybZy6kcpL1MSMdB2csUzPq+DUrTWg
         LbmvKYUzZylXCstWaJvWWq5y7oyRhRZOX/P+h6RKP4Kx3psFyJzJUnqfd21RDQDfwhfx
         Z4oN/BQEdWZAzk0vZezFRWkvOWl6N8bqfzemXl4hIawEc6jqtVhm3yVPwAqb/7u2uSZP
         MyPg==
X-Gm-Message-State: AMke39lCotgqDeve2bfRSfCR4o5mtP5z78cUmpVJUxoD3hJlO75gvHZa9PNHyyvIIMVMsg==
X-Received: by 10.98.64.132 with SMTP id f4mr16973446pfd.152.1487581813554;
        Mon, 20 Feb 2017 01:10:13 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:110e:6fae:3b03:324a])
        by smtp.gmail.com with ESMTPSA id o125sm33588014pfb.109.2017.02.20.01.10.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 01:10:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Damien Regad <dregad@mantisbt.org>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] git-check-ref-format: clarify man for --normalize
References: <44113ef6-5669-5e02-f848-27c17fac55e5@gmail.com>
        <20170220004717.7nqwk62vnuqv2rbb@sigill.intra.peff.net>
Date:   Mon, 20 Feb 2017 01:10:12 -0800
In-Reply-To: <20170220004717.7nqwk62vnuqv2rbb@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 19 Feb 2017 19:47:17 -0500")
Message-ID: <xmqqtw7pjki3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Feb 19, 2017 at 11:32:32PM +0100, Damien Regad wrote:
>
>> Use of 'iff' may be confusing to people not familiar with this term.
>> 
>> Improving the --normalize option's documentation to remove the use of
>> 'iff', and clearly describe what happens when the condition is not met.
>
> Looks good to me. Thanks for following up.

Looks good except that there does not seem to be sign-off.

Damien, no need to resend the patch but I need to hear you say that
you have read Documentation/SubmittingPatches and you want your
sign-off added.

Thanks.
