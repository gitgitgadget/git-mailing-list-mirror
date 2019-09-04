Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8CC21F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfIDUvT (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:51:19 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35810 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfIDUvT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:51:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id d26so7607qkk.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gqy2x16saohWjxDjmTieoifFxaukm5NKefavNo+oXvg=;
        b=Pe1B1UvU6aYXT8M9f6/xeB7Q4zJh6crRmehFH5+h1Z7zBgFpuMlAf0WJdn+JgmqMUS
         B+wUoKDJHXsCKaU8ZHoF+seGN1Fj4R2s/2r5PDIMJEqemthdcA100vyHdPwZZWtoVaHD
         xbGpmDXPl+7DBD03GgFv6MIMInggDXY1aGuVeA7lcvmswwI84LnE6PSBAuKyVdw5ro4A
         bEzPc3CIRXOZPz+wjDH2pAuNF/J4Y8n5IPUB2foJrXt+psHfSJwIvfSE3Q0PzL0komav
         vfwyCRS+Jb6wGNlRkEm9k0/Nv0eGtOIFPaYsEQdH3zD+WZOlHXWKgjB2Yx+W5ZZU9Ayd
         vEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gqy2x16saohWjxDjmTieoifFxaukm5NKefavNo+oXvg=;
        b=s5pAwcnzgTRq0LYef88MKCYvvqwWGKl6GDGM5HoNllZ9rPl6RmqXghnn8pEMQtq+ar
         trJ8eHohBsRGSHJRtLnQzD+16b9zGBYF1jCJY7ujK6TVj+gbme5F0Bs/A8WN64RkbHCZ
         ZiAXZLGiw68d7SUrAoIZxfqZW8WCZuWqNj9zW00NwOXnI+6tp1NdAfZA2+x6JM1EpwWr
         VJxkdcA/H2TE4ihkiKK1vGsJ8GwkXJ642lcDKTdmqab3nfO3cxwEJHPOuQ6Ti0zMPUXb
         wGgpb9Ebs1/zL7UhonPdSQUgcsS59lsPsHZnxi1PmUVaxhoTrw0XNG7diOI3DRMlSd2J
         Q3Fw==
X-Gm-Message-State: APjAAAUm3VDHtYlTiWH3Uzg4GlpQQ+8xO5s3bQNgQCw5pGFhaY3ck3WF
        YLeODvXhtyik1RR1zpfo7tMThg==
X-Google-Smtp-Source: APXvYqzOErjnR5LRjkibpL4mjSCtoRHLKlRX48drQPiADamtcs+Ks+reK5XXGtqljSrMTidXoOvbsg==
X-Received: by 2002:a37:ad04:: with SMTP id f4mr1935006qkm.238.1567630278421;
        Wed, 04 Sep 2019 13:51:18 -0700 (PDT)
Received: from localhost ([50.49.245.163])
        by smtp.gmail.com with ESMTPSA id 131sm98578qkg.1.2019.09.04.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 13:51:17 -0700 (PDT)
Date:   Wed, 4 Sep 2019 16:51:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/1] contrib/git-jump/git-jump: support alias expansion
Message-ID: <20190904205116.GA20056@syl.local>
References: <cover.1567619579.git.me@ttaylorr.com>
 <473a7c7b241ad2d449d3bcb6daeb77a179c7e45f.1567619579.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <473a7c7b241ad2d449d3bcb6daeb77a179c7e45f.1567619579.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 04, 2019 at 01:55:03PM -0400, Taylor Blau wrote:
> @@ -68,7 +70,7 @@ if test $# -lt 1; then
>  	usage >&2
>  	exit 1
>  fi
> -mode=$1; shift
> +mode="$(git config --default "$1" --get -- "alias.$1")"; shift
>
>  trap 'rm -f "$tmp"' 0 1 2 3 15
>  tmp=`mktemp -t git-jump.XXXXXX` || exit 1

I guess it's worth noting that this does _not_ respect extra options
given to the various modes. For example, if I alias 'diff' to 'diff
--minimal', we will try and invoke the function "mode_diff --minimal",
which doesn't make sense.

Perhaps we could take the output of this through "| awk '{ print $1 }'"
to discard any extra options, but it feels like a bit of a hack.

Personally, I'm not bothered by this, but I also don't use aliases to
add "default" options to any git sub-commands. But, I don't know if
other people do, in which case they may want to chime in here.

Thanks in advance for your thoughts.

> --
> 2.22.0

Thanks,
Taylor
