Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6521F597
	for <e@80x24.org>; Tue, 24 Jul 2018 22:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbeGXXSE (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:18:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40124 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388679AbeGXXSE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:18:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id e13-v6so1171867pff.7
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1WvAIsxq396bOJXZ33dLGdi9flwpLE6hnM6Yc84fOg0=;
        b=F/xw7+wcUzsCPzx7mTfzN3wFEigR6yWMLpsR+XhjGp18QYRE/9n0PT1fkZ9PEXmAwB
         pKU6Y7QHPTFfykx2ADNSV+nJyYH4iZKQy5gNC8PtFXO7bUSP41lWHKNHf3LwoKEM/uCV
         mULq/yojuAjftVaBV0yfhsLL+/14N1UelP5YjHMGClnIm8FnA6X688V8/3/K711Skx3j
         /mZR5MlPUS7MhULXZNkH2L68dApwmSaLdC6yH8hQwcvokw5JQwfBtco2FL4qbMiJExGB
         Sf96LQSv/1skEfbG/5r66G0u1RzD5Q7LAnWOlc5t2t6OP/ODew87XjKqYB+X7/Oyiim+
         FDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1WvAIsxq396bOJXZ33dLGdi9flwpLE6hnM6Yc84fOg0=;
        b=LpYtsiU225wPxPxYCYvtk9kdgsdSlU/IYkQ8lfbMPImdtw+4tjTahwaEbpEtcaTOti
         bsgM/wW/X8MJBk6Xxziq99Lhl4HTmBAHoinQdfZ9p2+ku6CucwyJyXUlyG9CHE7MdaNX
         dy8JQQyPD6cFTeJI5QNyTq5wNans4tcsGvXR93fakgEm4Wmig/tw1UsPae98fhrx+plA
         4kynXPkpa0s4dU8WE1Auop1xHTq4erhlgJD9edX/CNfVOShz+HzxBhoR6XVqvRs130Wl
         4OlK3V4qlYzqDS+SX6STn+iDa7UmH93L5PNcOM5qnHJ9KVGTed/LE1a6BOTkxs5OJMhM
         7TNw==
X-Gm-Message-State: AOUpUlGA5KwbmFsqS3G4qdSrfYoFJZGIE31kCwJyGW9bZ+VdVGHQoqPp
        BD9efF8Co032VCMqKpbnrZWNM2ks
X-Google-Smtp-Source: AAOMgpcqCwx5ndZLjrg54Bl6L0RAijeaeppaa2ZnfLgQ3agtzVXsgxM9qQ+M1Jz9jJLSiHBvRAR7+A==
X-Received: by 2002:a62:fc5:: with SMTP id 66-v6mr19497872pfp.237.1532470170705;
        Tue, 24 Jul 2018 15:09:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d123-v6sm18462590pfa.22.2018.07.24.15.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:09:30 -0700 (PDT)
Date:   Tue, 24 Jul 2018 15:09:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] diff: --color-moved: rename "dimmed_zebra" to
 "dimmed-zebra"
Message-ID: <20180724220928.GE136514@aiede.svl.corp.google.com>
References: <20180724215845.7137-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724215845.7137-1-sunshine@sunshineco.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:

> Subject: diff: --color-moved: rename "dimmed_zebra" to "dimmed-zebra"

It would be clearer to say something like

	diff --color-moved: add "dimmed-zebra" synonym for "dimmed_zebra"

> The --color-moved "dimmed_zebra" mode (with an underscore) is an
> anachronism. Most options and modes are hyphenated. It is more difficult
> to type and somewhat more difficult to read than those which are
> hyphenated. Therefore, rename it to "dimmed-zebra", and nominally
> deprecate "dimmed_zebra".

Hm.  Looks like dimmed_zebra was introduced in v2.15.0-rc0~16^2~2
(2017-06-30), so it has been around for a while (about a year).  But I
would like to be able to simplify by getting rid of it.

https://codesearch.debian.net/search?q=dimmed_zebra doesn't find any
instances of it being used outside Git itself.

https://twitter.com/kornelski/status/982247477020508162 (found with a
web search) shows that some people may have it in configuration.

Is there anything we can do to make it possible to remove eventually?
For example, should we (eventually, after dimmed-zebra has existed
for some time) start warning when people use dimmed_zebra to encourage
them to use dimmed-zebra instead?

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/diff-options.txt | 3 ++-
>  diff.c                         | 4 +++-
>  t/t4015-diff-whitespace.sh     | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 41064909ee..9195bcd398 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -282,10 +282,11 @@ zebra::
>  	painted using either the 'color.diff.{old,new}Moved' color or
>  	'color.diff.{old,new}MovedAlternative'. The change between
>  	the two colors indicates that a new block was detected.
> -dimmed_zebra::
> +dimmed-zebra::
>  	Similar to 'zebra', but additional dimming of uninteresting parts
>  	of moved code is performed. The bordering lines of two adjacent
>  	blocks are considered interesting, the rest is uninteresting.
> +	`dimmed_zebra` is a deprecated synonym.

Thanks for including that note.  It means that when people see
dimmed_zebra in scripts or configuration they won't have to be
mystified about why it works.

I don't have any good ideas about deprecating more aggressively, and
the patch looks good, so

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
