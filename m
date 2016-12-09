Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FE11FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbcLIOAr (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 09:00:47 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36401 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbcLIOAr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 09:00:47 -0500
Received: by mail-lf0-f53.google.com with SMTP id t196so583355lff.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 06:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KvhOrnKyZ84BYLxo4wdIfjZFKXwZKCn6hpUnfzEBNu8=;
        b=rHqeSUTtXSW1wBrE+jAKt+tzdPOFpsDo1ooa+427fla91rpJquh7/28o2cktjQIXZw
         HiJCooj2cutj7pac5SgBIRwDk1xrbgIat+p+Ra1U77Y9vqvYvAlh1UfmU8K7oUf19yg0
         iz7tWzQfGoEHcFa/eSkmqOeU9W5jScgvyWHbfmOz3CozdwUTwJXLJw+SUS8d33Miw8GS
         wsTz/8JV1i6eTHwviadWWI7jpo60n43ZDAeKQNigCPTd6kGXywxrApmLhuNoCY8lsupz
         JLBPZM+ElRy1l/BOvGCtG6cfE8FaxXb7T0+OHFtIZ36j1Qgde0oYze0Zjwzry0Mk8giG
         Kd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KvhOrnKyZ84BYLxo4wdIfjZFKXwZKCn6hpUnfzEBNu8=;
        b=jPEkGHmQ3B/7JLw/cwsONZ0aQr+VJ7xLFtTvoWTHn3QQXh7d5HyLu+b8kVP9qqQ5xY
         Vqq2IfR37aZ4o1T8XQv+FyrYj+5pB+0WgAFwt/TvAClAA2RozA069CTWNNXMv7RdXiZW
         /HSh+WpsmgZESaI0HBff+phv2xJJv5lmLBL6mvhVm4EwHW1Ni0sXwUECBVAXUhIzuDGg
         /7aOuGJ4c/sVjhUktGgPWKB5Z3JGjIrpDoroFpN+t92cVPafqFYU+5uULtz2W/XLOKQ5
         InknC0ZXxbZbJM0RqnBHpBWkomfkwfm+V7aJ1RMySR2Pzt4fV3DRE3xN5XYlFR1GE0Dx
         7xbw==
X-Gm-Message-State: AKaTC02rydDyG0NfR0hXlyAFh5j7/YA7EipJVtgxQ+fga1z8dnSM/aReWYES4l+EjOVp/5b5u/am6u2Zmk7vhg==
X-Received: by 10.25.195.195 with SMTP id t186mr22109703lff.96.1481292045333;
 Fri, 09 Dec 2016 06:00:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.170.213 with HTTP; Fri, 9 Dec 2016 06:00:44 -0800 (PST)
In-Reply-To: <20161209134544.z2xbly5xjyito62w@sigill.intra.peff.net>
References: <CABZ0BffSi6h8Zhg8vjo1dZhxXg3fUt_U6TAtqMvpDShOX6HyyA@mail.gmail.com>
 <20161209134544.z2xbly5xjyito62w@sigill.intra.peff.net>
From:   Paul Boyle <paulcboyle@gmail.com>
Date:   Fri, 9 Dec 2016 14:00:44 +0000
Message-ID: <CABZ0BffXMOn8eLFwg_o7WsXeRJjB_xd0kNeV1qGiVFPSYbxg+A@mail.gmail.com>
Subject: Re: Bug: git-sh-setup giving no such file or directory
To:     Jeff King <peff@peff.net>
Cc:     Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hmm. Did you run "make install"? Or are you trying to run git directly
> out of the build directory?
>
> If the latter, that has been unsupported for a while, though it mostly
> works. The "right" way is to either set up GIT_EXEC_PATH as appropriate,
> or to just .../git/bin-wrappers into your $PATH.

This was the source of it. Root cause, a stupid user ;) I'd a PATH
setup to the build directory. Changing the path to bin-wrappers fixed
it up.

Thanks!

On Fri, Dec 9, 2016 at 1:45 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 09, 2016 at 12:00:36PM +0000, Paul Boyle wrote:
>
>> There appears to be an issue with the latest master.
>>
>> "git submodule init" is producing the following error:
>>
>> /home/paul.boyle/bin/git/git-sh-setup: line 46:
>> /home/paul.boyle/libexec/git-core/git-sh-i18n: No such file or
>> directory
>
> Hmm. Did you run "make install"? Or are you trying to run git directly
> out of the build directory?
>
> If the latter, that has been unsupported for a while, though it mostly
> works. The "right" way is to either set up GIT_EXEC_PATH as appropriate,
> or to just .../git/bin-wrappers into your $PATH.
>
>> Broken sha: 8d7a455ed52e2a96debc080dfc011b6bb00db5d2
>>
>> Checking out an older version works fine.
>>
>> git checkout 'master@{2016-11-01 18:30:00}'
>>
>> Sha: 3cdd5d19178a54d2e51b5098d43b57571241d0ab
>>
>> This can be reproduced simply by:
>>
>> make clean ; make ; git submodule init
>>
>>
>> I didn't track it down further than to a commit sometime in the last month.
>
> You could probably find the exact commit with git-bisect. However, I'd
> be surprised if it is anything but 1073094f3 (git-sh-setup: be explicit
> where to dot-source git-sh-i18n from., 2016-10-29). Before that commit,
> we found git-sh-i18n in the $PATH, which would work if you were adding
> git's build directory to your $PATH (but not work for people who
> actually did an install).
>
> -Peff
