Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E66D201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbdBVUuy (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 15:50:54 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35511 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933406AbdBVUux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 15:50:53 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so1833578pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j6r3kZsR/Zxesq+MSlFTxfFf71zcVmzFwp/tTbWnQjM=;
        b=i69mqlPcW7HgWvAfwsHmmO1tyIFau5HxP6bibDQpKraJSAkN5ijeSNuvzFB9phhevl
         0KFOH3N8UV4MUZ2hPVfIFc2f00th6QyEREXqDWdluXVHe5IiWTluIjibTIWcFaU4WxjZ
         FwewRxuCtnhv0JDLiuNv9CkZbCeEn1lFEgJhXIFi4b+ah8rlhetMuj6cJzKpT0LPeghx
         W28Tud1ueKSwC/czxFHsfg/KXFyzrzmVNgyeChMh1h+nss31OkTIp1C38zjULPxYto8z
         VkeHFmxj4P/weLDV4/FVuzFl1GBdL0DD95K8Fk6yJIp8/VKK9bygZVFZo8OcRY5Wc+U7
         gzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j6r3kZsR/Zxesq+MSlFTxfFf71zcVmzFwp/tTbWnQjM=;
        b=ic3X9hPTdP5ViQ9ZFxH8FFc9zrx7838SwSP8cw5DSxbtDZDNq8iruZaqKkAE1+eiJE
         f5psPu8tl4R96ZD1rMc5CAG3bbFzqAt/aySI+Iu3LOk15AaPZ8TDdVfUEEpYiP+oK51I
         prI/Gqy22IaloYC8wekwv1uYOrplQPOKtuY4wrE4XsIoDT30NiPoKunv2JMjipTf4ISW
         HFiWbAqDH+5SzHPcFZhlaCj1zKKERm0R0QIL4GcDhcXt6HQ9vzTHnGMqkqsyjd+LX3tP
         Mgj6x1ubo1btj3usxjWnGPofA3jgqQxsnTDNB2dHa6SsTNgnWm9NBNRkDx3ZXGnryVHJ
         yygg==
X-Gm-Message-State: AMke39k68aQKxhUK3Lz7INlhmmhMtHkFT+SfsHYaWKnxg1e9HgWUWhAmLMoni3UOvq/9sQ==
X-Received: by 10.84.129.132 with SMTP id b4mr49695229plb.54.1487796639964;
        Wed, 22 Feb 2017 12:50:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id 17sm5317424pgd.45.2017.02.22.12.50.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 12:50:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] git add -i: replace \t with blanks in the help message
References: <20170222184627.3811-1-ralf.thielow@gmail.com>
Date:   Wed, 22 Feb 2017 12:50:38 -0800
In-Reply-To: <20170222184627.3811-1-ralf.thielow@gmail.com> (Ralf Thielow's
        message of "Wed, 22 Feb 2017 19:46:27 +0100")
Message-ID: <xmqqlgsyar1d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Within the help message of 'git add -i', the 'diff' command uses one
> tab character and blanks to create the space between the name and the
> description while the others use blanks only.  So if the tab size is
> not at 4 characters, this description will not be in range.
> Replace the tab character with blanks.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  git-add--interactive.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, this was me being sloppy in the very first version.

Will queue.

>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index cf6fc926a..982593c89 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1678,7 +1678,7 @@ status        - show paths with changes
>  update        - add working tree state to the staged set of changes
>  revert        - revert staged set of changes back to the HEAD version
>  patch         - pick hunks and update selectively
> -diff	      - view diff between HEAD and index
> +diff          - view diff between HEAD and index
>  add untracked - add contents of untracked files to the staged set of changes
>  EOF
>  }
