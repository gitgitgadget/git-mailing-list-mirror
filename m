Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD5E1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 16:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935166AbeCSQvb (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 12:51:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39857 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966781AbeCSQvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 12:51:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id f125so8662976wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NJqxUx9fU5c5wJJbxzrmoV8onj7vdWin+5DirjqlcKk=;
        b=Ak7VL/ilz5pXok5zfaZuWmYIVxCatxgEadFwLVUeEEO63/JTEa/weHxQy7SPaSvM/4
         hYjKPTVUDyteO/1q+9EHx9oF+1DFAJd9vfx8+uYIVCaL96F0UzI1IFl3FkEQCT67Rxnw
         hia1evuKFrIX0f5SZFOfGruZFFpK2aKBfK2dyAAoc489UjdcdAfnHLJ9m9iXUXZKCa6q
         g5OyH0nmxXMc0B5cO8cf230UGwy+acbKqpTLKtbvg8hozRuOUTgx5eoGfZqVVr4K8ANG
         nTcws1JFNFWgI5srcT1rcUm+TmrY8LEoCU5ZJavutKt7U5BDuKKXRU1GG7I/cZp3S/u/
         ZG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NJqxUx9fU5c5wJJbxzrmoV8onj7vdWin+5DirjqlcKk=;
        b=kBgSmhErbR3t693Le6jGcXk9HR+NtveKqMztOYVlOQsORZ2BnEKLCkqnZgXAFH+3Zl
         D33ahyZcrkcDdjJoPKOhGk9AGFSlrmf64TIAXbpvCIAKZ2vkF5V/gxBlpt6f4Sol+r4v
         ytIHa58vGJn7kaYcweK2DxqXkM/iF886TvNBSmUI1RDKge1EjRnoB1SDClM+qWfhYoOR
         6vgYDkpY6EKf9Lf17HtlHramfTzgWcqNYp/Y10I1lq0dyETflBcvepms4iAz8fwkRv9V
         hJ1+a+d3tAZDcEaf49hwEAHxI/KrcQjq7XWL7V1tFhh5p0X4oWcYkDeKPdHYSutlhqNV
         ep0g==
X-Gm-Message-State: AElRT7Eme5EFDwHQTGS7tCNTRa2omOmBEG5mqeINJvbcEecDF1xSyGeJ
        HCaG3UabrNBcz4+zD8knI4c=
X-Google-Smtp-Source: AG47ELt1tKHFTOgBhr+BBxpQURHSGWg3b1T3phDzgAZXB9zTVK7SrrLNW6ChTY5/KT4Tiiq0dwNPRg==
X-Received: by 10.28.231.24 with SMTP id e24mr2268825wmh.123.1521478274934;
        Mon, 19 Mar 2018 09:51:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n29sm1081739wmi.32.2018.03.19.09.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 09:51:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Pursehouse <david.pursehouse@gmail.com>
Cc:     git@vger.kernel.org, David Pursehouse <dpursehouse@collab.net>
Subject: Re: [PATCH 1/1] Fix typo in merge-strategies documentation
References: <20180317033142.20119-1-david.pursehouse@gmail.com>
        <20180317033142.20119-2-david.pursehouse@gmail.com>
Date:   Mon, 19 Mar 2018 09:51:14 -0700
In-Reply-To: <20180317033142.20119-2-david.pursehouse@gmail.com> (David
        Pursehouse's message of "Sat, 17 Mar 2018 12:31:42 +0900")
Message-ID: <xmqqo9jkvwjh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Pursehouse <david.pursehouse@gmail.com> writes:

> From: David Pursehouse <dpursehouse@collab.net>
>
> Signed-off-by: David Pursehouse <dpursehouse@collab.net>
> ---

I somehow had to stare at the patch for a few minutes, view it in
two Emacs buffers and run M-x compare-windows before I finally spot
the single-byte typofix.

Will queue with a retitle.

    Documentation/merge-strategies: typofix
    
    It's strategy, not stragegy.
    
    Signed-off-by: David Pursehouse <dpursehouse@collab.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.


>  Documentation/merge-strategies.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> index fd5d748d1..4a58aad4b 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -40,7 +40,7 @@ the other tree did, declaring 'our' history contains all that happened in it.
>  
>  theirs;;
>  	This is the opposite of 'ours'; note that, unlike 'ours', there is
> -	no 'theirs' merge stragegy to confuse this merge option with.
> +	no 'theirs' merge strategy to confuse this merge option with.
>  
>  patience;;
>  	With this option, 'merge-recursive' spends a little extra time
