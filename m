Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C96F1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 00:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbfHIANS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 20:13:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45279 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHIANS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 20:13:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so70442633qkj.12
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 17:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B025ZQ3ZdC50po3x7er2i9Z38PjD62ukYELwiweWYPg=;
        b=BPd8MZMQOiA2o5/fexQNsnd4sOT7YVaAKZi3VLzB0/lG9BsI1Z3C+7kA3D4YS7OGVy
         BEVZNEA6PVK7G+tzYPN+K046yoH9pJ1giVYU4KISy94CGeHH7SHBS7OL0uXrAfXP6K6x
         nzcqEwl+AP4pOfJ20uHEP6GLn2q0YUNnROcag926mWcQu3oIU0kxEEyDbcojRWDNCLSq
         GZ8fqSGf2bkutEwtfY9kBaMYoqHbkv3W0vnUqrVGUGswDhYujFGY/tQX0Be2DvOsAU1Q
         QRXkjm6xMCCOJkoIl5tQIiItLmU+zLGhR4E23HnPavL6xplgZ/RTri9JKDEcEb79VK9p
         TOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B025ZQ3ZdC50po3x7er2i9Z38PjD62ukYELwiweWYPg=;
        b=jTKKv54iGVlP4mWib2Kw4igD5LdZjkBXVmuasb6bvl5EvyVB4Y/vQkvn2QBmyKq2gf
         oDCaSLMhKImAFeBAU7WDbeuhpMMUzc1TMKB8/TFEZjAvVDbCzAVunzGOS7laGCoK/CTH
         7T2/a3gnvrb2FQ7qNTs1dSYjR8KdQJVOK5gejeZOCfrE4bP+2zpowSzosiPc4ziw9AaQ
         iE9kCjjBlDJ/vXxPUmhhQmLjQ0521v8WUGmVRFo1oEW5AMvTFTGNSma0fEy5WPIoMuoQ
         IY5rtDdVTKqpNggOQxLlBhSA9yyR4yMBW/VsMEajl1M7GtV37KpfX7yyDIoXYpAHu/Ie
         v+2w==
X-Gm-Message-State: APjAAAWQMElm+eogpDsNd81PfuDWDo+uhQ3q8LT6SopO02+9rQLeY5kO
        MHJeLRrPcxfPmGajm2sDDqo0lAVA7H0qCQ==
X-Google-Smtp-Source: APXvYqzBMBtpQaa3+GNqb23XR8X0kLq67DUC33W0DuEccoWVJlmNJi0NshE6V1060Rim0eGKCHct6Q==
X-Received: by 2002:a05:620a:1506:: with SMTP id i6mr16009846qkk.346.1565309597170;
        Thu, 08 Aug 2019 17:13:17 -0700 (PDT)
Received: from localhost ([2605:9480:205:fffe:d944:a1aa:a878:ce5c])
        by smtp.gmail.com with ESMTPSA id t9sm3166654qtr.29.2019.08.08.17.13.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 17:13:16 -0700 (PDT)
Date:   Thu, 8 Aug 2019 20:13:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Ariadne Conill <ariadne@dereferenced.org>
Cc:     git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Message-ID: <20190809001315.GA87896@syl.lan>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Jul 25, 2019 at 05:19:23PM -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> The seventh batch is in; I've merged fix-up topics that has been in
> 'master' for some time (i.e. up to the third batch of this cycle)
> down to 'maint'.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> [Graduated to "master"]
>
> *snip*
>
> * ac/log-use-mailmap-by-default-transition (2019-07-15) 3 commits
>   (merged to 'next' on 2019-07-19 at e5669de950)
>  + tests: defang pager tests by explicitly disabling the log.mailmap warning
>  + documentation: mention --no-use-mailmap and log.mailmap false setting
>  + log: add warning for unspecified log.mailmap setting
>
>  The "git log" command learns to issue a warning when log.mailmap
>  configuration is not set and --[no-]mailmap option is not used, to
>  prepare users for future versions of Git that uses the mailmap by
>  default.

Sorry for jumping into this discussion quite late. I was discussing this
change with a colleague of mine who pointed out an issue with the
eventual new defaults. I'd like to re-raise the issues they shared with
me on the list for discussion, and if agreement is reached, I will send
a series that reverts these changes.

If a transgender person uses '.mailmap' to rewrite their deadname to
their legal name (as was the original motivation in [1]), there are two
potential issues:

  - The '.mailmap' provides a list of transgender individuals, along
    with their deadname, which can be used to harass them.

  - If they are not in control of the '.mailmap', and 'log.mailmap' is
    not specifiable (and instead defaults to 'true'), then a malicious
    maintainer or contributor can submit a change that rewrites their
    real name to their deadname, and harasses them further.

This issue was not raised in the original discussion, but it's clear
that this has the potential be used for bad, not good.

Given that the release is so close, I propose we revert this change
before v2.23.0 is tagged. After that, we ought to discuss ways for folks
to change how their name is displayed in porcelain commands, and
thoroughly consider whether or not a new plan is exploitable.

If you think this is a good course of action, I will send a series to
revert the changes that were queued here.

Thanks,
Taylor

[1]: https://public-inbox.org/git/CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com/
