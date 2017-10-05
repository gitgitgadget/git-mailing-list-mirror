Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFDD01FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 22:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdJEWRJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 18:17:09 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:43738 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdJEWRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 18:17:09 -0400
Received: by mail-qk0-f177.google.com with SMTP id w134so16277427qkb.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KInGPbMjd+kGlwuVEeBety/vU6QT0cFqpnsvGDMbP10=;
        b=Xy5P40bFoVocucwBLLFMVdj3hOpqEHPVwAFE0WMzycGZPhEWtNiH+OByA2RMxpS1ru
         avl6IQVV4iZtSmyqrk/xYwxdbzUcdLQU0J2x6dv7c7PtsynaD+nX5si2asj5t7vEddHc
         zxaLW5csC3Ukr0dA+5rLW/7k8SeqebYUiu72G9kN04Kw2ZOXLim3YFY/WeqIoeqiL42Y
         w/YaYVi3EkZXRaThIK5hfsD+UlXvEB5fGFPQ1b6BN0SsmpFC3FtiQ77hTurAhWeVW+Vp
         oTzTA96hhwFuQG7kRFTtyjM4C9rKDjT5tS9ia04MEA1va64+GTdxmpvxZTzjHYLek28L
         1+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KInGPbMjd+kGlwuVEeBety/vU6QT0cFqpnsvGDMbP10=;
        b=rM2PbCWRssIC9PDWmEnCeEXnZS+DjYe5g3Ee8V8esiJPNGDYp9apzeisze/CeIeehh
         xvigLE6Il2OWyzDUis0rONXe/g1PHUVwQq5tZWXr+lt1iVer3vMt9cPkxeNwox3edEHS
         TNq0c+kNx2BQlDu44SIOf72iaHnovW5mpoKdjsAH/WD/N7kjR4gDNn3ynr5jgiYEa+HL
         toxhJlYX5OOUe1duXP0B0YjrF7VH/KxHyDas2FlHB7hWGG8+2xxkqXwnb2hI44cm+6O+
         hORwSSv6VqMNVNcQnOQePqjnN6oM2GkIElMvmrHumRQacfdVfhWxbHZHfgqDWuUu16yA
         b0Kw==
X-Gm-Message-State: AMCzsaXdkYdqNyLLy3ZFivo9wxY2A1cFr8UJg1AYkydyRidFnGVpF826
        cZIOxGC8XrS5lbzuGcIrSfMeS3xqK7k23U7qzBYyguWBKfo=
X-Google-Smtp-Source: AOwi7QDVy2IdGH9h9zS9/zRZlooeR6oBCJU8w5l+oCZa67IMSQnT5tAMCuauYLDfolCQapQER9HtmPuRsJzg5qIZoWQ=
X-Received: by 10.233.239.140 with SMTP id d134mr9512645qkg.308.1507241828169;
 Thu, 05 Oct 2017 15:17:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 5 Oct 2017 15:17:07 -0700 (PDT)
In-Reply-To: <20171005212344.22887-1-thomas.braun@virtuell-zuhause.de>
References: <20171005212344.22887-1-thomas.braun@virtuell-zuhause.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Oct 2017 15:17:07 -0700
Message-ID: <CAGZ79kbp=ewvdR8gXptwDjDdtM3TdC8qp1qR8XhETa7_CKgqRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] completion: Add forgotten describe options
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 2:23 PM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:

> completion: Add forgotten describe options

When/Why was it forgotten? git-blame thinks it was me in b0176ce6b5
(builtin/describe: introduce --broken flag, 2017-03-21)
Which do you add? (dirty and broken)

I had these questions when reading the subject (which is the
equivalent of reading the output of `git log --oneline` in the future)
I think a better wording might be

    completion: add --broken and --dirty to describe

    When the flags for broken and dirty were implemented in
    b0176ce6b5 (builtin/describe: introduce --broken flag, 2017-03-21)
    and 9f67d2e827 (Teach "git describe" --dirty option, 2009-10-21)
    the completion was not updated, although these flags are useful
    completions. Add them.

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---

The patch looks correct.

Thanks,
Stefan

>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d934417475..0e16f017a4 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1385,7 +1385,7 @@ _git_describe ()
>                 __gitcomp "
>                         --all --tags --contains --abbrev= --candidates=
>                         --exact-match --debug --long --match --always --first-parent
> -                       --exclude
> +                       --exclude --dirty --broken
>                         "
>                 return
>         esac
> --
> 2.14.2.746.g8fb8a945bc.dirty
>
