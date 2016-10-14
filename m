Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D815E1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 17:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbcJNRp1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 13:45:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34843 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbcJNRpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 13:45:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id b80so744094wme.2
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gHMG5TW6DkBS1m7St3nZr1mGL8WW1Qfq3XTy34yAWmg=;
        b=yzfMWz/tmGbYsYoeLZ3ZWXqgmagwfRQ0lA6mVXeVNCepMxWAAZXsJUWRnr87JkUpSg
         33Y8V0Q69PUheUM7o9k96JUQOVLZm4z3Ey0Z1REhilU0Rg+exDx/ZKWZM9/1nc23N/8G
         XXzsomuLXqeKYvOR0MRAVl+umRUpsvIaLUBtHR/T7mtTgm0C5HhdboA39rb5M8YAzU4J
         NSWfX284UsSKbji04LMg+rB8Nu7Qxw1a1ShKa1h9XBMknpRyGX5Z1u3CYwwmUIOpJ/Oo
         2/Fev3qkfBFBUsCLN4aZsLBY3wYyauM1tOxwqMVCRXovesGswHVRDQPs9Uh/HGu6RG47
         le1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gHMG5TW6DkBS1m7St3nZr1mGL8WW1Qfq3XTy34yAWmg=;
        b=KpriGiEOVWIcyq0tdx2atjqNXCx4tSHR2q/np0Do+rA+2EtMsWW+giCT9jxMtW23yn
         ls6Ide1J/Nu3p2R91LxghzkmoPWAYluaso3hekxCDGiW4qQqghSQGrc/pGH7qsZpnVPe
         PUYcLNUhXVqWNCIwxWu3f4KWhkzISNl8A1S+Mi7RxL1nrMUdME5pcZgH9TWwN8ViyzP3
         akLBVmVQrwy87c7YoFGR7vtngVT6aFaRNqFYf13TBcLXDJlVuxqSkITeuFneL12BRXS3
         XtU4RQBZKgFIlLKN2mV84Q2aZQcT9bAGAU7zjQCiqzz/xoqqWEig+lUEKuxoRsFzRMcb
         VfkA==
X-Gm-Message-State: AA6/9RlA5hEfgWM90SGyqW+7Z4T4aY0a+K5oEiAEN3zVTsSm0pTOI8xY5XD3pStpGAMEHA==
X-Received: by 10.28.141.148 with SMTP id p142mr6533275wmd.107.1476467124258;
        Fri, 14 Oct 2016 10:45:24 -0700 (PDT)
Received: from [192.168.1.26] (agd104.neoplus.adsl.tpnet.pl. [83.25.159.104])
        by smtp.googlemail.com with ESMTPSA id l10sm888223wmf.4.2016.10.14.10.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Oct 2016 10:45:22 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] gitweb: Link to 7-char+ SHA1s, not only 8-char+
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20161006091135.29590-1-avarab@gmail.com>
 <20161006091135.29590-3-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <3fa9902f-3b01-5ec6-8129-34cff4c7cac9@gmail.com>
Date:   Fri, 14 Oct 2016 19:45:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161006091135.29590-3-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.10.2016 o 11:11, Ævar Arnfjörð Bjarmason pisze:

> Change the minimum length of an abbreviated object identifier in the
> commit message gitweb tries to turn into link from 8 hexchars to 7.
> 
> This arbitrary minimum length of 8 was introduced in bfe2191 ("gitweb:
> SHA-1 in commit log message links to "object" view", 2006-12-10), but
> the default abbreviation length is 7, and has been for a long time.
> 
> It's still possible to reference SHA1s down to 4 characters in length,
> see v1.7.4-1-gdce9648's MINIMUM_ABBREV, but I can't see how to make
> git actually produce that, so I doubt anyone is putting that into log
> messages in practice, but people definitely do put 7 character SHA1s
> into log messages.

That's nice explanation why we want to support 7 character SHA-1
(it is the default, and was seen in the wild), but don't need to
support shorter lengths.

Another reason (just for completeness; you don't need to put it in
the commit message) to not go below 7 characters is that with 
decreasing length there is more and more chance for false positives
(like 'beef' or 'caffee' for 4-char or 5-char hexstring), as I wrote
previously.

s/SHA1/SHA-1/g in above paragraph (for correctness and consistency).

> 
> I think it's fairly dubious to link to things matching [0-9a-fA-F]
> here as opposed to just [0-9a-f], that dates back to the initial
> version of gitweb from 161332a ("first working version",
> 2005-08-07). Git will accept all-caps SHA1s, but didn't ever produce
> them as far as I can tell.

All right.  If we decide to be more strict in what we accept, we can
do it in a separate commit.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Acked-by: Jakub Narębski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index cba7405..92b5e91 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2036,7 +2036,7 @@ sub format_log_line_html {
>  	my $line = shift;
>  
>  	$line = esc_html($line, -nbsp=>1);
> -	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
> +	$line =~ s{\b([0-9a-fA-F]{7,40})\b}{

By the way, it is quite long commit message for one character change.
Not that it is a bad thing...

>  		$cgi->a({-href => href(action=>"object", hash=>$1),
>  					-class => "text"}, $1);
>  	}eg;
> 

