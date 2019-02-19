Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C3771F462
	for <e@80x24.org>; Tue, 19 Feb 2019 19:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfBSTcd (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 14:32:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38109 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBSTcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 14:32:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id v26so3989620wmh.3
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 11:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oYEUN2z9EUPNnbT2p/YJAjKzRVjftpv9OLjQ6vGbb9s=;
        b=bMhxK56v7G7F3rdnR4cTcpjSoZuknTVAyuQm07pj56uUK7zKyS6suzOYloNdsNOT2H
         jbEI7ng4WAblW+bldylOwr69fY2Ct31H+7H/Cxtr2iG3lJdfLDVIrK6B2uESQ3uxiyT5
         hkUGFXFoX/eZjnyXQH6xWsqtJFWYIOs3mPBxFttdJgTp0y8vzfabDJFSVfBQiXUSEGNi
         RO1i90lYM4GlmFebnDb6gPbF8ytZWV5tJEPq8Kh5odhp6dKIWXBvF68Xz7iPfiIst1Si
         IoXB2ksRwPQC0sMdTipdpW8eCr+t7I/t8QoOlw1AyHvHzBXR6ulrAOuRB422yqfrr3kI
         li0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oYEUN2z9EUPNnbT2p/YJAjKzRVjftpv9OLjQ6vGbb9s=;
        b=L0js0RyE/ztvUyu2ZTab5+ZnkcqgEDKNgecl/lqVKXlZjHhKXHh/5W1YJikQxrYh+i
         cwxhcWT8iUQ6bMrOwjFcL1Rr8zvGTvqli782hGoUPUhcvEsWAE+4MiPcpeqXpwL0DDkO
         wJSpdFZOOZcMAxhRwJLoV5PCwdm2EBiBtFnTA27uyQX3b3ZxcdbrV9hxAFv3Wou3ic81
         ZSIoKFxL5Scqhrh60R5AmcjK2YN3LE1JJUBulOf8O6nbADRXRJjq0o6W/JMNdZfXKwlQ
         1rIyhO6VY/heCFBk219eP+I34fmGWtm+i0GUAgOGhsAfhe2m+P7rb0rPGNLdzl4JsHd8
         X0Ww==
X-Gm-Message-State: AHQUAubiLBxXsrAg3zVWG87HGscUY5o6WBu3c3RqZGxVyyQCC3tQzl+h
        B4GVDAEHi//ZNBcOStNi8rU=
X-Google-Smtp-Source: AHgI3Ibp1Mc36IufyBgHfwJve89yLlWgvL78p1J0HWtERvZETzKXtJTs1AC7bcXWtr7hCir4p/bCJA==
X-Received: by 2002:a1c:7e58:: with SMTP id z85mr4028145wmc.52.1550604749977;
        Tue, 19 Feb 2019 11:32:29 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j124sm3439636wmb.48.2019.02.19.11.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:32:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Re: [PATCH v2] merge-options.txt: correct wording of --no-commit option
References: <5C6BAA4E020000A10002FBFF@gwsmtp1.uni-regensburg.de>
        <20190219170709.25463-1-newren@gmail.com>
Date:   Tue, 19 Feb 2019 11:32:27 -0800
In-Reply-To: <20190219170709.25463-1-newren@gmail.com> (Elijah Newren's
        message of "Tue, 19 Feb 2019 09:07:09 -0800")
Message-ID: <xmqqk1hv1sms.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +With --no-commit perform the merge and stop just before creating
> +a merge commit, to give the user a chance to inspect and further
> +tweak the merge result before committing.
> ++
> +Note that fast-forward updates do not need to create a merge
> +commit and therefore there is no way to stop those merges with
> +--no-commit.  Thus, if you want to ensure your branch is not
> +changed or updated by the merge command, use --no-ff with
> +--no-commit.

While the above is an improvement (so I'll queue it on 'pu' not to
lose sight of it), I find the use of "do not need to" above somewhat
misleading.  It solicits a reaction "ok, we know it does not need
to, but it could prepare to create one to allow us to further muck
with it, no?".

IOW, a fast-forward by definition does not create a merge by itself,
so there is nowhere to stop during a creation of a merge.  So at
least:

	s/do not need to/do not/

It also may be a good idea to consider detecting this case and be a
bit more helpful, perhaps with end-user experience looking like...

  $ git checkout master^0
  $ git merge --no-commit next
  Updating 0d0ac3826a..ee538a81fe
  Fast-forward
    ...diffstat follows here...
  hint: merge completed without creating a commit.
  hint: if you wanted to prepare for a manually tweaked merge,
  hint: do "git reset --keep ORIG_HEAD" followed by
  hint: "git merge --no-ff --no-commit next".

or even

  $ git checkout master^0
  $ git merge --no-commit next
  warning: defaulting to --no-ff, given a --no-commit request
  Automatic merge went well; stopped before committing as requested
  hint: if you'd rather have a fast-forward without creating a commit,
  hint: do "git reset --keep next" now.

I do not have a strong preference among three (the third option
being not doing anything), but if pressed, I'd say that the last one
might be the most user-friendly, even though it feels a bit too
magical and trying to be smarter than its own good.

In any case, the hint for the "recovery" procedure needs to be
carefully written.
