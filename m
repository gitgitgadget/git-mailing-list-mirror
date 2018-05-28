Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75A51F42D
	for <e@80x24.org>; Mon, 28 May 2018 03:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeE1DAq (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 23:00:46 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:40015 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeE1DAp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 23:00:45 -0400
Received: by mail-wr0-f172.google.com with SMTP id l41-v6so17844050wre.7
        for <git@vger.kernel.org>; Sun, 27 May 2018 20:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VK0/QSsONeSewa5P/A5Ymtdwdj/urs+4VSkre+iXgqY=;
        b=X/WC+fqets/bgfPfJ5bixY/1NWGr9v51I1+pvdhkz395Y45GndsMIVmvscrs9uRETk
         jpe3YT9wfyjo8uni3LGMNSqghdAavu+tXwTPUa1ak+9UR5XehVbirXX2+ESn1PZau9aA
         0E+Lc9eOJkuHD4bACxE2AJqxVACaQKHl++NPmbNbXV24ex6XcA7wjoZ7v2zN/w9Xi2/+
         GCh3Edisc+zH0u5ESGpz+XE6r5edzTWwueFVAjHSzjJRPBoJ7LG9O3SrnAWyG2FPi8uq
         x2zNAYEVqtBSdJkzcpyKEVSPXGBEf/4hr9EpliDD6v0liArlB1AP/SA2hLeqxTg9SG9i
         CyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VK0/QSsONeSewa5P/A5Ymtdwdj/urs+4VSkre+iXgqY=;
        b=oxldX/CwAahe8vcRWM4/B2d5qF/Fq0NO0SFekP7d3JwkqHFEHrUE2SKF8aoVjq61ts
         dJP2cG+P4OSWxGMaNFFJV1jzxARzNfv3q2m5f1zczUa35jP/9ahns/mDjvg+VHcAC3OK
         KyxjGfTdflaCjpFNd6b9zZF/7zAAfecPevNzg4Vm2XGfyX1INOAeYVDTenTU9xaNIxsr
         huJRtvN8YL+C9EbYyiCM1HVGTIXtNY9vjnxDn2Pu7S19SKt/SYghKUXI+Yd/f2gdwCWH
         zDOig1qKqOKt19rQS2U8NioPFK27AsO2as3szJREl6WBg2jTrXYyHngbm4DelZYPHKLH
         vfdg==
X-Gm-Message-State: ALKqPwf0dntvsuTYYbwcP4h3RW/MTJbaaWFa+ebM4w2eAI6a1L4FX7MO
        8Bu6L2JGCMKfTFrFtGapvO26Gcc6
X-Google-Smtp-Source: ADUXVKIxILW1OE4rIu5UFSM+GQ4BGvtiSJezNngvEN+xLw8D3VxA0gSdMXeZqYS40+PrKo9oQvy5KA==
X-Received: by 2002:adf:b053:: with SMTP id g19-v6mr4307412wra.128.1527476443614;
        Sun, 27 May 2018 20:00:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d3-v6sm2705650wri.24.2018.05.27.20.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 20:00:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/1] SubmittingPatches: not git-security@googlegroups.com
References: <20180527140433.32277-1-t.gummerer@gmail.com>
        <20180527153418.GG207547@aiede.svl.corp.google.com>
        <20180527210822.GB8868@hank.intra.tgummerer.com>
Date:   Mon, 28 May 2018 12:00:42 +0900
In-Reply-To: <20180527210822.GB8868@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Sun, 27 May 2018 22:08:22 +0100")
Message-ID: <xmqqbmd0lc11.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Yeah sorry, that's what I meant.
> https://public-inbox.org/git/20180308150820.22588-1-avarab@gmail.com/
> is the reference I meant to put there.
>
> How about something like the below?  This is tested with asciidoc
> 8.6.10 and asciidoctor 1.5.6.2.  I'm also happy to squash the two
> patches into one if that's preferred.
>

If the discussion in the proposed log message needs to be updated
anyway, it is a good opportunity to make them into a single patch,
as they share exactly the same objective.

This is a tangent, but the use of footnote below looks a but
curious.  How would {1} reference pick which :1: to use?  The
closest preceding one?  

As this appears on a page that already has other footnotes attached
to an adjacent paragraph, I am wondering if they should be made into
a part of the same numbering sequence.

> @@ -264,6 +264,11 @@ people who are involved in the area you are touching (the `git
>  contacts` command in `contrib/contacts/` can help to
>  identify them), to solicit comments and reviews.
>  
> +:1: footnote:[The Git Security mailing list: git-security@googlegroups.com]
> +
> +Patches which are security relevant should be submitted privately to
> +the Git Security mailing list{1}.
> +
>  :1: footnote:[The current maintainer: gitster@pobox.com]
>  :2: footnote:[The mailing list: git@vger.kernel.org]

Also, the placement of this new paragraph is rather odd.  

I am guessing that the reason why you put it _before_ the normal
list address is to make sure those with secrets that must be guarded
won't send it to the list first without thinking, but then this
place is too late for that, as the previous paragraph already told
the reader that the patch should be sent to the list and others but
not necessarily to the maintainer.  This should go one paragraph
before that, at least.  I briefly considered suggesting to move it
even earlier, e.g. the beginning of "Sending your patches" section,
but then by the time readers with potential security patches may
have forgotten it, or worse, get confused by us, when we say "Send
your patches with To: set to the list".  So I dunno.  The most
conservative would be to write it at the beginning of the section
and then repeat it just before "Send to the list, Cc releavant
people" paragraph as a reminder.
