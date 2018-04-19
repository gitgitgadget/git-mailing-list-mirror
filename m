Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56F691F404
	for <e@80x24.org>; Thu, 19 Apr 2018 05:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeDSFdP (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 01:33:15 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33749 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbeDSFdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 01:33:06 -0400
Received: by mail-wr0-f177.google.com with SMTP id z73-v6so10445912wrb.0
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 22:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SxVg381Gwta/fvYMuWhEZVb3QVPGTm61L/SDz+uKshk=;
        b=hhzSg9Bk1BMKqeI1NtmBzaxKokrbyPKKpi/iuYtbAjk+5bal85HhGVz2bOc4fLZtvl
         P8pU4wB1oirVlnt7DP6CiWr9iwNHaq4E2/wkzAR8lKYgd1fMWGVNsFpav02rxsFGfE6Z
         9pRPsX2GZ5hGLQEKW/2sgL6Ki4PZuy9yELW8BuNUd5a/3BSsyP2z77eEkMveE8otmMxS
         45kMH7/kufC2HiwePt2gdYXcXpDx9x6w/vsumdbT4mzHf2Kuj7Wdxwdsde15yCnH3AKR
         wO69MwURJO60kwIZSguSv6ZkzTHXibm2BDJB5L8KDAhBv8l7B6MTBmJk88n0pwaXJdqe
         z9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SxVg381Gwta/fvYMuWhEZVb3QVPGTm61L/SDz+uKshk=;
        b=Er5C3o8uXVvnBJh+jLrPeRvpgWF1feD/bVqLT4Pa+B1seLXuWqbSoWDrciRc2S/H60
         3cUyoy0s7yPsdPbATpTFzKJUtVRpzQXII7g0+68pXZUFUH+i41gTm8cns/VTmwPsdTdP
         t0V6wZlni2ciGsjARGlzbu8zPhhsAYUFrnGMmN+eDXRCcj5lhBn9IzRv2huqU1iybU/R
         y4p8nFlZg6qL7L79MFgAEWWyh/Btgte6IxZgzPxxHO/bN/nGIlEsT0g44yQStr4FCL3d
         edjLGoOe+QDUABieAi5yqTGVSQFVFmZnwIZpW7KuULgbQ+n+tJ9ECfnurnvr5FAQsdma
         h1Gw==
X-Gm-Message-State: ALQs6tBMc0utm8tPWqfi05xy72o9RU4p4N+VP00jYs4Flw6qQjomR61b
        zUM3e86rDbGW24f+VqsHzL4=
X-Google-Smtp-Source: AIpwx4+LvSW5nyUynKUjk7f/hVRaTLWBk79VRf0nZdaWV5MQp9R6COwJZQ69BOfDDQUksc0zCMS2HQ==
X-Received: by 2002:adf:be89:: with SMTP id i9-v6mr3588918wrh.166.1524115982740;
        Wed, 18 Apr 2018 22:33:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 71sm3183914wmg.11.2018.04.18.22.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 22:33:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "xfswindy\@163.com" <xfswindy@163.com>
Cc:     git@vger.kernel.org
Subject: Re: Git issue report
References: <-tc3xop-8i635uwx53zom190jcbwyrl587bgic1u7ogu-h5ta7c-vg7tsu-9tjre9eq72we-wflfrt-v7y1d7-7ekgia-gbrcn9of96to-6fxlag-u56rt19q40x9-ved85k-25erwyma9au4-fjthm4-fwargr.1524108608363@email.android.com>
Date:   Thu, 19 Apr 2018 14:33:00 +0900
In-Reply-To: <-tc3xop-8i635uwx53zom190jcbwyrl587bgic1u7ogu-h5ta7c-vg7tsu-9tjre9eq72we-wflfrt-v7y1d7-7ekgia-gbrcn9of96to-6fxlag-u56rt19q40x9-ved85k-25erwyma9au4-fjthm4-fwargr.1524108608363@email.android.com>
        (xfswindy@163.com's message of "Thu, 19 Apr 2018 11:30:08 +0800")
Message-ID: <xmqqbmefep6b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"xfswindy@163.com" <xfswindy@163.com> writes:

> Hi,
>   I met a issue when using git.
> I cannot delete the file by the commond 'git rm'.
> The file name is a little diff from common file.
> I accidentally named the file "filename\r", display such as filename^M. Then I commit the file by 'git add .'.
> After I find this mistake, I remove the file, then try to use commond "git rm" to delete the file, but failed.
>
> My git version is 1.7.9.5.

The following works fine with v1.7.9.5 (I have separate installs of
various versions of Git and use "rungit $version" to choose from
them, so just read "rungit v1.7.9.5" below as if it is "git").

	$ rungit v1.7.9.5 init
        $ N=$(printf "filename\015")
        $ echo >"$N"
        $ /bin/ls fil* | od -cx
        0000000   f   i   l   e   n   a   m   e  \r  \n
                   6966    656c    616e    656d    0a0d
        0000012
        $ rungit v1.7.9.5 add .
        $ rungit v1.7.9.5 ls-files
        "filename\r"
        $ rm filename*
        $ rungit v1.7.9.5 rm filename*
        $ rungit v1.7.9.5 ls-files 
	$ /bin/ls
        $ exit

and I do not think of any reason why we would have broken it since.

FYI, you do not have to do a separate "rm filename*" in the above
sequence; "git rm filename*" would remove it from both the working
tree and from the index.  I did it in the above illustration in two
separate steps only because you said you removed and then did "git
rm" and I wanted to emulate it.

> Is this issue reported?

I do not recall hearing about it, but you must have looked for one
hard already and I haven't, so...

> If this issue is solved, could you tell me which version I should get.

It appears to me that such an issue did not exist in the first
place.

