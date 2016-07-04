Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B03D20179
	for <e@80x24.org>; Mon,  4 Jul 2016 15:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbcGDPsz (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 11:48:55 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34967 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcGDPsy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 11:48:54 -0400
Received: by mail-lf0-f41.google.com with SMTP id l188so119499266lfe.2
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 08:48:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpjjeH8c89fDD+oaktNcg3oZrl1ExzlM+ZYZGVCE2ic=;
        b=UZ40deMMGWn+MpUV0HCcaSTia4SdErLQV1kYIhXwaR83NwHQ0+dtvqTAZqIJoKJahR
         POGJ2IW/+LWKSgq2jNheUXjfidhppreuMaU0qVgWRAaJs/5u3Zh8hZIU5w2NLlaOChD9
         PgqRj9hA/chkEA8Bx22A8diGvJa9eLncsCArACh/9vCCeq04qYjiCqvUsh95FZD5YVHD
         83ApXgqaDNofX49B/Hzg+lsx6ltqxBdSdxND9WM/9o2BTZFr3xAw/CH59ihjwhRX99cV
         ObJugdmYHT3vxm1bxV4SS44GF/ZH7Lsym2GUdXI5SdkbiCiPTbUquf3q66sn3cxobEXQ
         jZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpjjeH8c89fDD+oaktNcg3oZrl1ExzlM+ZYZGVCE2ic=;
        b=gOzXGPKp+M+JmkdaBlHb6qY1i/9KKiX7irwikI1PS/8kJuv8JOT7ZOFiuUWfZL3oST
         CKpgdgZoxT9aaixVeqVAryluunUtjoageLomzEmj5eZuywe9YvFBsqIn6oseFagCtL/c
         SjUZLsJ9OPysmyAxcaaK87mxcWWvAvmkyI+3vtHPafkQozG/4jvVAgnYTKD/TROWOwlr
         35iYNxRTZj50MgViuYf9cLnlsk+7RrY9aI4oap95GnI89F46Cp6bd5ZiF/rR4phuNjl+
         hAx7L6OOVT/ZNRqw8CpfQqMkFE5NVsAeIn85F0gWKXuIisw8Eyex14bM19aL3KXz62qI
         lWjg==
X-Gm-Message-State: ALyK8tIjSypd/rAZU/q2oSXb6UTnXAzJSBKEO79hAsNJid3qN5JPPSBq2B+nG4TK0leTVA==
X-Received: by 10.25.210.20 with SMTP id j20mr2963560lfg.139.1467647332278;
        Mon, 04 Jul 2016 08:48:52 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g28sm2516500ljg.24.2016.07.04.08.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2016 08:48:50 -0700 (PDT)
Date:	Mon, 4 Jul 2016 17:48:49 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Git doesn't always add files to a commit (amend)
Message-ID: <20160704154848.GA6857@duynguyen>
References: <CAMhVC3Y9iT9X=JbB5tguXm8MRX4v2fDEqMwrMuDR6TD2+2+HLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhVC3Y9iT9X=JbB5tguXm8MRX4v2fDEqMwrMuDR6TD2+2+HLQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 04, 2016 at 04:50:38PM +0300, Yuri Kanivetsky wrote:
> Hi,
> 
> When intent to add a directory is made (`git add -N`), and then
> contents of any but the first file is staged, `git commit -v --amend`
> doesn't add it to the commit

Oops, a bug since 2012. Thanks for the report. I know what's wrong and
will prepare a proper patch in a couple of hours.

> , see for yourself:
> 
>     #!/usr/bin/env bash
>     set -eu
>     rm -rf 1
>     mkdir 1
>     cd 1
>     git init
>     echo 1 > 1 && git add 1 && git commit -m 1
>     mkdir 2
>     echo 2/1 > 2/1
>     echo 2/2 > 2/2
>     git add -N 2
>     # git add 2/1   # this file is added
>     git add 2/2   # as opposed to this one
>     git commit --amend -m 1
>     git --no-pager log -p
>     git reset
>     git --no-pager status
> 
> I'm running git-2.9.0.
> 
> Regards,
> Yuri
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
