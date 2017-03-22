Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB3D2095B
	for <e@80x24.org>; Wed, 22 Mar 2017 01:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933855AbdCVBBd (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 21:01:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35607 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933758AbdCVBBc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 21:01:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id n11so12968308pfg.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 18:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6JVtIQHuOUkuCcOpdmy9K6SmFASgR1PVkmNn4VCBaVo=;
        b=O3x5bVC82upQeQnIRJfDUV56iKjJ6XlpTn9zb8weSZGSjWTLGY3Y2dvAf1YLvFblGg
         oGMRt0J8MEjUHZmkgZquxYYFCsFkrfvhglCwhwt5ycOen1M5wnxrHck39OjHawTPPs0z
         6iCm4/vlwxw6ByPhEFiupYBzLhPdIuytwV7myVdYaE4a7oH3ppFyhca4zpoRFUqNaUmH
         ctc8oJL2JlPQ2MCVoGYsvJ7QMzUAnl8t33vdJW1Z5YhN2vtn9ysWZxQ64kNaP/9mN2mv
         kQgZFMcbl5+HU3R771jZJsxfSXZu/THxC8jn84GfywG4P4ShE8FAuqT04VntsWrFpqEz
         LlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6JVtIQHuOUkuCcOpdmy9K6SmFASgR1PVkmNn4VCBaVo=;
        b=jyEgYiZYlDmHlJiRnNRPCHpPXtMGwTZUDrTnVEtyYjGge3YnARC1Eqq5ArMrHmhP/F
         tAClKW6e6gI1JM6a7KO8LxSSd+rjrkpciQmdXjwz/SriarqRbEWo6ABFy2ZSqsabwTyA
         Dj2snXif9TDWGRZoEPmXxxD+PxVilycdJOcXIvBJjwsJCPjF5tFlAn8QcgCxXb/4P5Mj
         7THpXRCAGTCegyZ6U5rKruFd4RMBELcNBFpngN7+wYWejG+UwHObvQAsY6jkY/PLN5Ko
         bh/t4jtK6Z2iFCwxaLRKoy3cOES6/bxqvS8ZeqbgXtY17/zBiW6vfV/p2JGs3svrgBtX
         godg==
X-Gm-Message-State: AFeK/H0pYTfQ4H0LbGqG/h4iascMmV8WUI36Uro2ZFs0wjrD5G1gbCktzBKYyYqawjpRFA==
X-Received: by 10.99.241.21 with SMTP id f21mr40100032pgi.16.1490144489775;
        Tue, 21 Mar 2017 18:01:29 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8163:b2a7:fac8:a1d1])
        by smtp.gmail.com with ESMTPSA id k184sm42110204pgc.23.2017.03.21.18.01.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 18:01:28 -0700 (PDT)
Date:   Tue, 21 Mar 2017 18:00:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] t3600: rename test to describe its functionality
Message-ID: <20170322010058.GA31294@aiede.mtv.corp.google.com>
References: <20170321210802.9675-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321210802.9675-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> This was an oversight in 55856a35b2 (rm: absorb a submodules git dir
> before deletion, 2016-12-27), as the body of the test changed without
> adapting the test subject.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t3600-rm.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 5aa6db584c..1f87781e94 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -658,7 +658,7 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'rm of a populated nested submodule with a nested .git directory fails even when forced' '
> +test_expect_success 'rm of a populated nested submodule with a nested .git directory absorbs the nested git dir' '

This title is getting long. How about something like the following for
squashing in?

With or without that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/t/t3600-rm.sh w/t/t3600-rm.sh
index 1f87781e94..3c63455729 100755
--- i/t/t3600-rm.sh
+++ w/t/t3600-rm.sh
@@ -658,7 +658,7 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	test_cmp expect actual
 '
 
-test_expect_success 'rm of a populated nested submodule with a nested .git directory absorbs the nested git dir' '
+test_expect_success "rm absorbs submodule's nested .git directory" '
 	git reset --hard &&
 	git submodule update --recursive &&
 	(cd submod/subsubmod &&
