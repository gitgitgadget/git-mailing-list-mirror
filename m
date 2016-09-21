Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E661F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbcIUQ0i (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:26:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35620 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933227AbcIUQ0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:26:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id 133so9530987wmq.2
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=71wEINj45xQneFnVOcfJoCGg98LB+aTqNJIp79ctGwg=;
        b=FCHpinlqo3LqsRQPYkBoCJ8qAhoaaSoLBbwHQB/6JKwsBc7UibwvvGcI/pbBzTg7Ds
         i4l4z7Y5hDxnqS7TD3K+dF28VZMvfSt/iis6mFg0EX1leoJuXsSUw7PHA7Akw+k/uBQD
         vwFByHThLPY9XLyRUjaazf+ICDMj48mPchLcKZtL7c9o98pXW/JcEY2wOylR/2vpfU2W
         9fqEbECLOaOirhOD6cFKPY+w43HymOP15r10y9UlS/uPREsoKPI5lEgQeUm9HESj9xLM
         1NagOZrXj81W4z+RuJtmPQYebvd84scs2bKSx7WekBFm/MlvC1ttshLd1b1+oiHEjNzp
         p5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=71wEINj45xQneFnVOcfJoCGg98LB+aTqNJIp79ctGwg=;
        b=mwK2n+0jm4IcKMLCJqtsWi3S05mEyHtvvL8tI8i73q4S8pJpYqdBMNHiD3lH2elwwU
         g++yHyZ0qAiSqx7yxxV8oa5ebSwmzLSy1ndK6SCIY69ABBW6RoxVCTEr63soHuYghTKV
         wGvlfX7xBn9X5Tz890nP5PvH2BoAsYNwPAUECJyQVkzUjbUFfc39cRhaWnK+WnjbGp6M
         r54uV8Mll6ol9aGTRm5PHxcKeecuWUSKWrRFhH6OHXgZVvn64jxXORnHFoHFNo2bj2/L
         1uOwpRtbf0I8LFEKWsf8LqmMrWc8seghzMRSv9UWaAAJedSOy0LApOLjmVuC5zjlMtRL
         SQ2w==
X-Gm-Message-State: AE9vXwNR3qEfCNNDgbGZfpVZMBjDLarfD0tQncgduPpi/zY4D4nZqwhExw8DK4rhhWYBdg==
X-Received: by 10.194.140.201 with SMTP id ri9mr32797249wjb.195.1474475194276;
        Wed, 21 Sep 2016 09:26:34 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id 17sm34256476wju.44.2016.09.21.09.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 09:26:33 -0700 (PDT)
Subject: Re: [PATCH 2/3] gitweb: Link to 7-character SHA1SUMS in commit
 messages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20160921114428.28664-1-avarab@gmail.com>
 <20160921114428.28664-2-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <64389bcb-c6e4-1d19-54a1-650868b9acb5@gmail.com>
Date:   Wed, 21 Sep 2016 18:26:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160921114428.28664-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.09.2016 o 13:44, Ævar Arnfjörð Bjarmason napisał:

> Subject: [PATCH 2/3] gitweb: Link to 7-character SHA1SUMS in commit messages

This is modification of a feature, not a new feature it sounds like.
I think the following title / subject would be better:

  Subject: [PATCH 2/3] gitweb: Link to 7-char+ SHA1s, not only 8-char+

>
> Change the minimum length of a commit we'll link to from 8 to 7.

I think it would read better as:

  Change the minimum length of an abbreviated object identifier in the
  commit message gitweb tries to turn into link from 8 hexchars to 7.

> 
> This arbitrary minimum length of 8 was introduced in
> v1.4.4.2-151-gbfe2191, but as seen in e.g. v1.7.4-1-gdce9648 the
> default abbreviation length is 7.

Right. I wonder why it was 8 in gitweb...

> 
> It's still possible to reference SHA1s down to 4 characters in length,
> see v1.7.4-1-gdce9648's MINIMUM_ABBREV, but I can't see how to make
> git actually produce that, so I doubt anyone is putting that into log
> messages in practice, but people definitely do put 7 character SHA1s
> into log messages.

There is an additional problem: the shorter SHA1 abbrev we try to
match, the more possibility of false positives, words that only look
like (shortened SHA-1).

For 7 characters there is at last one word that can be mistaken
for SHA1 abbrev, namely 'deedeed' (hopefully rare in commit messages).
For 6 characters we have 'accede', 'beaded', 'decade' (!), 'deface',
'facade' (!!), and possibly more (and of course all 7 character
hexdigit words).

Also, the number of digits provided as an optional parameter to
--abbrev or --abbrev-commit options is only a minimal number of 
hexdigits: Git would use as many as needed for the abbreviated SHA-1
to be unambiguous, at current time.


I think allowing 7-character shortened SHA-1, which is what Git
produces for smaller repositories by default is (might be?) a good
idea.  Thanks for the patch.

> 
> I think it's fairly dubious to link to things matching [0-9a-fA-F]
> here as opposed to just [0-9a-f], that dates back to the initial
> version of gitweb from 161332a. Git will accept all-caps SHA1s, but
> didn't ever produce them as far as I can tell.

All right, thanks for reminder.

Signoff?

> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9473daf..101dbc0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2036,7 +2036,7 @@ sub format_log_line_html {
>  	my $line = shift;
>  
>  	$line = esc_html($line, -nbsp=>1);
> -	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
> +	$line =~ s{\b([0-9a-fA-F]{7,40})\b}{
>  		$cgi->a({-href => href(action=>"object", hash=>$1),
>  					-class => "text"}, $1);
>  	}eg;
> 

Nice and simple.

P.S. I have reworking of commit message parsing and enhancement in my
long, long and dated gitweb TODO list :-(

P.P.S. Kay Sievers no longer works on gitweb, and I think no longer
works at SuSE but at RedHat.

Best,
-- 
Jakub Narębski
