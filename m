Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A86D20248
	for <e@80x24.org>; Tue,  5 Mar 2019 22:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfCEWao (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 17:30:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35252 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCEWao (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 17:30:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id y15so4099692wma.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 14:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hRQeeTfooRMlxP9y8C4fVqlfBw0x207/EXsReV/mLJM=;
        b=o9EIngso1Zaahh2l/sqHxB7mYhV9ZK/Vu5TekuionoEhvqBcx1i4fY/WeB6Phcxw4E
         vDnnbcxske422cenw5oOJrX0oX9763WYwBghS5yr23sD3fP1aWx/as9VNB+700Iw7lpG
         DRXZwH6a2/1rDvxz9hBRKPDsiPtIwZ/1irJpKPVnomRhRjDXbGonjKVOyrZSNjCtbHL2
         P+e/b8roAwFOPrrSLkQh2FSB5/64fqr+AyWBD/OgqEzm8sKq+118UitWXJAENuFogN9D
         4+Wy0CoCGfQCKmppjlUW1gn6vjbKKUkMNPV2YJPQWxZazg6n3IH69/A9kjYpi4kywP0l
         Ju2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hRQeeTfooRMlxP9y8C4fVqlfBw0x207/EXsReV/mLJM=;
        b=rTSgt9WrWkgV2TYJho+oUOKV7uzOppZ2eurM3ZXE01GiNJ54lhVuT97trGOrS8UBHl
         08bPE7UXWFJKKCClZCq2nQ/1aTPhH8cD/JfzoSflYOE1xe2zPs5pus9GBF3tIWosy7Em
         C4wNZSaXBAeKg10NkRGZkEtg9qKfuzEPTSGVFWJeTRqhVcsu16L7SNRYNFlqbOIrFNsp
         idsDNOAFhDwbiBU3s/rx3YibhtIPE/r8MnH/cj6uR9dRAwQI7ondGKIfMiXjwu612qTU
         Kgj4/hlvtf+5vHs8QkPX/WOGh9IXh4ydtUa3AJu5mZqFslbdfMwOc4JeGw28f2RKu/tr
         wwkQ==
X-Gm-Message-State: APjAAAVXdyW0JIKlDRVqSb80TpPMkD+DS1XLj7m3paQxYIOqZzOu4gJH
        sf7l7humUJwdCCjs1KpWxc4=
X-Google-Smtp-Source: APXvYqzX3r/DatL2k0fM54HJkAisxNlKe0IfX4B0rIdb+bQ2GUyhajFp1iQUKKf8u9K0sDbFTfEPow==
X-Received: by 2002:a1c:eb17:: with SMTP id j23mr421658wmh.86.1551825042143;
        Tue, 05 Mar 2019 14:30:42 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p5sm31518wme.14.2019.03.05.14.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 14:30:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-reset.txt: clarify documentation
References: <20190305185423.GA22260@dev-l>
Date:   Wed, 06 Mar 2019 07:30:40 +0900
In-Reply-To: <20190305185423.GA22260@dev-l> (Denton Liu's message of "Tue, 5
        Mar 2019 10:54:23 -0800")
Message-ID: <xmqqh8cht0mn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> git-reset.txt contained a missing "a" and "wrt". Fix the missing "a" for
> correctness and replace "wrt" with "with respect to" so that the
> documentation is not so cryptic.

Could you try again without unrelated reflowing of the text?

Thanks.

>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-reset.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 132f8e55f6..dbf4e567a2 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -428,11 +428,11 @@ working index HEAD target         working index HEAD
>  
>  `reset --merge` is meant to be used when resetting out of a conflicted
>  merge. Any mergy operation guarantees that the working tree file that is
> -involved in the merge does not have local change wrt the index before
> -it starts, and that it writes the result out to the working tree. So if
> -we see some difference between the index and the target and also
> -between the index and the working tree, then it means that we are not
> -resetting out from a state that a mergy operation left after failing
> +involved in the merge does not have a local change with respect to the
> +index before it starts, and that it writes the result out to the working
> +tree. So if we see some difference between the index and the target and
> +also between the index and the working tree, then it means that we are
> +not resetting out from a state that a mergy operation left after failing
>  with a conflict. That is why we disallow `--merge` option in this case.
>  
>  `reset --keep` is meant to be used when removing some of the last
