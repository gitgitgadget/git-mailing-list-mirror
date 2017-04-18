Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E670C1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 00:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbdDRAQA (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 20:16:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35109 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbdDRAP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 20:15:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id a188so27621550pfa.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 17:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fCQ0FhFfpqJeTW3rG257OTv+ONcXbr/jNqh9yOy/XGo=;
        b=UeUYtU7F+b1N4tSr3mpHaH9RxjVQr7XulXmVce8KIyHBeDziclswGzTZEAt4Emep3l
         Vli6OCxt5UaBErXcbcBpHILkLP8iaP6HcCtt/yyG2znYAfRWbBHhEwfhWdt+IU+Sw1hI
         2EJvPEDEFyZfL+6MzjNcS7qcqHecYFRddxvRi9F23f7RUHJgmawljU/NFv6n+DHiVx3t
         UPHk5FbgCLP110Rp7EtJOUzDq5uRiQdvEl42L2eH/jNEMuWMvZDibLkeyp6mXXQnk064
         nUwaQ0IVu+Wfa+uw0lsQiAOhljRZJs4GILqoPOVP8PlEWau/oHwedXEiqsjXEnFscoDU
         LUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fCQ0FhFfpqJeTW3rG257OTv+ONcXbr/jNqh9yOy/XGo=;
        b=k+XFdamrmFh5Jryh7jLeKF4KZimg9Zvq1aE1TX89nnk+aO61e/Q7lUT7efmrJXu5Px
         Fgxs1SitBk1BgMd5rfAQjxKDqkXH46rekbzRgolnQo6qJ+1HQ/cCS9eZ+XvUdWqikzqT
         dlFhgegfTi8jn3kHM3nznzTDM11zNFNWNbp9YcchG4z5we4K5F/WX/pqRwVGqMLCzvrr
         +PnXcy5H0oFlZHsNp8aT25gNop81G05QCgGINBEdPMYcC0QQ9Lsm7D/no7XHM317EONh
         yuhTH/wnp9UWfTwCE0AiqLKmjxOeyk+81f8Fj+YDA89ZLXzhCpe6lBp7zoLpwQrWewJW
         bS+A==
X-Gm-Message-State: AN3rC/523WOpXeu7Y7szSm7IiYaGJMQwk3gqioqD5R5V1GG7VjwP2r5S
        +3nEc8ayXTecyw==
X-Received: by 10.99.163.67 with SMTP id v3mr14806605pgn.206.1492474558873;
        Mon, 17 Apr 2017 17:15:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d10d:449f:8b4e:a37c])
        by smtp.gmail.com with ESMTPSA id b8sm20181188pgn.51.2017.04.17.17.15.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 17:15:58 -0700 (PDT)
Date:   Mon, 17 Apr 2017 17:15:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] doc: trivial typo in git-format-patch.txt
Message-ID: <20170418001556.GC8486@aiede.mtv.corp.google.com>
References: <20170417223253.2934-1-giuseppe.bilotta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417223253.2934-1-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta wrote:

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  Documentation/git-format-patch.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It took me a while to see the typo.  It's s/of/or/.  Good eyes.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
