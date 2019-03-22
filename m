Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D4720248
	for <e@80x24.org>; Fri, 22 Mar 2019 19:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfCVTED (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 15:04:03 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:46755 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCVTED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 15:04:03 -0400
Received: by mail-qk1-f171.google.com with SMTP id s81so1834343qke.13
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Q82n0QZT85OlycjjewKwHtE/j0sEiAzbYMYjrDvNeg=;
        b=m8+CjIVJY+oUMTubN4uqpnv45eT0GdlHYI0+Uj3kJo4DOhJXo6xY0Et61xmbotvXIn
         rRi+kDjDymxO/KxHXgb+w7v4y9e4v3qSQk/GxIGiUCpKP0O2FDqdEFknnzDymct8CiyQ
         Hd9rzTrSM6GYmixrnILjFdinESdBuZOm7ZoH3Kw0ak38H8V2iKNJjnPpjzcidU0MBg+T
         zp6Y5udzgsk0VK5aIGEHN96P1NyxPtj5rwqju64YmGVWM9AFi9LWnE5tgHKDee2UHJpp
         /YeP3i9fKLuIIoIPDfDBg7eNDBSjZDmzRcizV86H5Oj7JqR2MVWDfWv29yNKeBrhSuGL
         4B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Q82n0QZT85OlycjjewKwHtE/j0sEiAzbYMYjrDvNeg=;
        b=g+/a+nfm2R78SoYdIagr4amv4CL6KKGA7ATEfa9ciJz1BlMwBu5q+s5Llx3l5pVdP2
         UcI6gP9++rCutgZnCmwZISs1q1lFoEPWcHcriEUkE3heGWxJKi7nw9vmbBdeHnlwbAKz
         YejUT+MfKOAyNiaOss+BYlQB6kYnZqmrbWax7JEyIoNhfCoCCvfyhns1yZPHNIeNe0M2
         NZ0TLxLC0A0KJXSdpMlzkZhDZpvqmIYvpgRVMu742I2snNagZo/Y0PTjiSbMqhlBtanL
         2uSV+LfejoTDQkzYG6g6i4u+2RwLit/aBAgOyjzMf3kjyBnz51GZ2h2hsubbTzKXsWaU
         JeNw==
X-Gm-Message-State: APjAAAX8bHemrn5uGnc3bC+AT1dR7+UxAa0ES4xTyWIr8fwMDYflAKba
        aPsz1pAZJaUut0lw5sWVNvC+0g==
X-Google-Smtp-Source: APXvYqy01UM0chPpDJCZALEeAFtfRAZB5ZRDzk5ZVXtqIUrBkcNZ2J4kE52k0p6UBrMZbZ1RKY/PEA==
X-Received: by 2002:a05:620a:153b:: with SMTP id n27mr8291386qkk.343.1553281441762;
        Fri, 22 Mar 2019 12:04:01 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id r15sm4726972qte.65.2019.03.22.12.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 12:04:00 -0700 (PDT)
Date:   Fri, 22 Mar 2019 15:04:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jason Karns <jason.karns@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Suspected with double asterisk in conditional include
 pattern
Message-ID: <20190322190400.GD12155@Taylors-MacBook-Pro.local>
References: <CAKNmmv26G05GO7hG9bNvMsjpuUMHZRA+2f94TuG2wDNUwNhHkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKNmmv26G05GO7hG9bNvMsjpuUMHZRA+2f94TuG2wDNUwNhHkw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jason,

On Thu, Mar 14, 2019 at 01:30:43PM -0400, Jason Karns wrote:
> Hello,
>
> I believe I've encountered a bug regarding the use of double asterisk
> ( /**/ ) within includeIf patterns.
>
> git-config man pages state that
>
>     **/ and /**, that can match multiple path components
>
> They then refer to the gitignore man pages which further define
> supported wildcard patterns:
>
>     A slash followed by two consecutive asterisks then a slash matches
> zero or more directories.
>     For example, "a/**/b" matches "a/b", "a/x/b", "a/x/y/b" and so on.
>
> My understanding of these docs are that the pattern
> `/usr/local/**/Homebrew/` ought to match
> both`/usr/local/cache/Homebrew/foo` and `/usr/local/Homebrew/foo`.
>
> However, given the following conditional include rule:
>
>     [includeIf "gitdir:/usr/local/**/Homebrew/"]

For what it's worth, Git LFS's implementation of the wildmatch
algorithm [1] exhibits the same behavior (i.e., that it does _not_ match
those double stars in the middle of the pathspec).

Here are the tests I added to double check:

	{
		Pattern: `/usr/local/**/Homebrew/`,
		Subject: `/usr/local/cache/Homebrew/foo`,
		Match:   false,
	},
	{
		Pattern: `/usr/local/**/Homebrew/`,
		Subject: `/usr/local/Homebrew/foo`,
		Match:   false,
	},

And they passed, indicating that neither of the above subjects are a
match for the pattern '/usr/local/**/Homebrew'. I was suspicious that
changing the pattern to '/usr/local/**/Homebrew/*' might have caused it
to match, but it did not.

But this isn't really telling us anything that we don't know. What's
interesting is that '/usr/local/**/Homebrew' _does_ match
'/usr/local/Homebrew' and '/usr/local/cache/Homebrew'. I think that this
is consistent with [2]:

  A slash followed by two consecutive asterisks then a slash matches
  zero or more directories. For example, "a/**/b" matches "a/b",
  "a/x/b", "a/x/y/b" and so on.

So I think that there _is_ a bug here, but not the one you suggested.
Rather, I think that the bug is that with the _trailing_ wildcard, the
pathspec doesn't accept '/usr/local/cache/Homebrew/a'.

Thanks,
Taylor

[1]: https://github.com/git-lfs/wildmatch
[2]: https://git-scm.com/docs/gitignore
