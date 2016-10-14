Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDEE1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 20:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755685AbcJNUHl (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 16:07:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34470 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbcJNUHe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 16:07:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id z189so75020wmb.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xKUjqiUtNId4G7sdPcdAV/Vh5AL9vBDg0QpAVZyijnc=;
        b=Ib6fMa4IYvFbkxFL2no7gjjpOJpEONZRK4aBp74Glrxlg7raJ2rjsY0oOrqNRo2zoV
         79U/WIpXG7UZ4LfflZkT1TXkNFLdIs1uT+A6aJALgwtMGINTuS/qhdype52ROeg1D88W
         ch8oZgdZuAHnQFzrQs6UUIA+XboqeDTNSFrfBvWWHVQU/bv5/dWPPFPGerdgfeLWWzIA
         uDp4WBGs65uvtA71IWFOwcdy8rTo5uLMZfpcSBLBDo8/4YcFn69siLEBCUFyTbUKX8uH
         U7qKOYsXj9Lp3Z6xqpp2SKIGDmoa8YlJp8tnLQDdngHOXrRt5BG9KklJK7RzGyu+wng8
         UN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xKUjqiUtNId4G7sdPcdAV/Vh5AL9vBDg0QpAVZyijnc=;
        b=hqaskq5Rfs6OTjFPURqag/1MDQbvW4zigyycVUnmwl07SlFt03PdS8zZlyp6EGshQD
         sOECxtMGxdbWbub2Bx+ENxBuGejaBflw8w9r4uVbNFq9hMKzeV0gQrfBWUP/XMOsone8
         SPqDzxL9p6OI/uSiWdYYoU2GJjdHDTc5r1nzWq5pMThYsZaXwNtrI3wHnbDfJnTHXNUf
         8kSoDKH1LHhzT4emGB8HfLnOGEJ63HuAdlZ5EdDxnMaPXlrwx1x2IZ3mtncfnUZ+Cl4x
         qlaia6HFazEy4LihZlBvQfN5BTGs+vR/8De3zuKW/oBWFeqT44q8Y7SIPMYqJZwB9NCH
         UZQQ==
X-Gm-Message-State: AA6/9Rk1T5wUywMSySPtGr9Mx03bV7X0pXGdKwX0vOMsjQBmgJJ2Kr/cjI/1kiW2SyRfDA==
X-Received: by 10.194.223.97 with SMTP id qt1mr3205189wjc.33.1476475598575;
        Fri, 14 Oct 2016 13:06:38 -0700 (PDT)
Received: from [192.168.1.26] (agd104.neoplus.adsl.tpnet.pl. [83.25.159.104])
        by smtp.googlemail.com with ESMTPSA id g17sm33598154wjs.38.2016.10.14.13.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Oct 2016 13:06:37 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] gitweb: Link to "git describe"'d commits in log
 messages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20161006091135.29590-1-avarab@gmail.com>
 <20161006091135.29590-4-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d070f375-6d95-4050-b823-796fb38b19c0@gmail.com>
Date:   Fri, 14 Oct 2016 22:06:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161006091135.29590-4-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.10.2016 o 11:11, Ævar Arnfjörð Bjarmason pisze:
> Change the log formatting function to know about "git describe" output
> such as "v2.8.0-4-g867ad08", in addition to just plain "867ad08".
> 
> There are still many valid refnames that we don't link to
> e.g. v2.10.0-rc1~2^2~1 is also a valid way to refer to
> v2.8.0-4-g867ad08, but I'm not supporting that with this commit,
> similarly it's trivially possible to create some refnames like
> "æ/var-gf6727b0" or which won't be picked up by this regex.

It's important to cover most common cases occurring naturally in
people's repositories, while trying to avoid false positives (the latter
is important more now, where gitweb doesn't check for rev name validity).

I guess that most common is to use non-hierarchical tags with ASCII-only
names for describe output, so while "æ/var-gf6727b0" won't be picked,
it is IMVHO also much less likely to occur.

> 
> There's surely room for improvement here, but I just wanted to address
> the very common case of sticking "git describe" output into commit
> messages without trying to link to all possible refnames, that's going
> to be a rather futile exercise given that this is free text, and it
> would be prohibitively expensive to look up whether the references in
> question exist in our repository.
> 
> There was on-list discussion about how we could do better than this
> patch. Junio suggested to update parse_commits() to call a new
> "gitweb--helper" command which would pass each of the revision
> candidates through "rev-parse --verify --quiet". That would cut down
> on our false positives (e.g. we'll link to "deadbeef"), and also allow
> us to be more aggressive in selecting candidate revisions.
> 
> That may be too expensive to work in practice, or it may
> not. Investigating that would be a good follow-up to this patch.

All right.  That's good and enough for one patch.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Acked-by: Jakub Narębski <jnareb@gmail.com>

BTW. to add to whole "git describe" output or not discussion: having link
span whole revision marker makes for easier to use UI: larger are to hit.

> ---
>  gitweb/gitweb.perl | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 92b5e91..7cf68f0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2036,10 +2036,24 @@ sub format_log_line_html {
>  	my $line = shift;
>  
>  	$line = esc_html($line, -nbsp=>1);
> -	$line =~ s{\b([0-9a-fA-F]{7,40})\b}{
> +	$line =~ s{
> +        \b
> +        (
> +            # The output of "git describe", e.g. v2.10.0-297-gf6727b0
> +            # or hadoop-20160921-113441-20-g094fb7d
> +            (?<!-) # see strbuf_check_tag_ref(). Tags can't start with -
> +            [A-Za-z0-9.-]+
> +            (?!\.) # refs can't end with ".", see check_refname_format()
> +            -g[0-9a-fA-F]{7,40}
> +            |
> +            # Just a normal looking Git SHA1
> +            [0-9a-fA-F]{7,40}
> +        )
> +        \b

Nice using of eXplained regexp.  It is much easier to understand with
comments.

> +    }{
>  		$cgi->a({-href => href(action=>"object", hash=>$1),
>  					-class => "text"}, $1);
> -	}eg;
> +	}egx;
>  
>  	return $line;
>  }
> 

