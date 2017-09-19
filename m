Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7D320281
	for <e@80x24.org>; Tue, 19 Sep 2017 02:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbdISCuW (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 22:50:22 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34839 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdISCuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 22:50:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id j16so1264001pga.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 19:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IwWSMDB8SJbNIh3vdhtcHHVcm7+//vF460ZVjN5C/wM=;
        b=VtT6WtS10z3714rdf36o4jm1wWMkJT2YEzNFvREYoeR+CdSZPwaf226gkc1iBKa2su
         7iZ6X2zAIB6iq9hxLIqnNrs60pRY6w5MTynYWasI0Q9ngDvs1QZS9hIfyKbVjCs36d0t
         EUgQY829J9+eUTYzyB/sa88UluODyg389edw8mrefOx18NYClkSJPgYBMYOIpdRuWWk8
         QgXJnd3RL7QN4FEImnKIXGTHan8WIaKQDO4dUxA1Nzydr8Wgw3CZ40Zlgf4tswvVEL8U
         NBOgxnebIM4h6kwEPcMf7FaL1gW6CgWW0+zrdgoctDrMY2iK5j06IyCJAFf9BxOkGh2J
         ybwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IwWSMDB8SJbNIh3vdhtcHHVcm7+//vF460ZVjN5C/wM=;
        b=mndm0APMRSueSqm/VEBuJ/3+a0uljM4j4HfjkD6OhcEPmFRqFbcAlCrsMreAZsvInC
         vEWm6sdrUu+gCv250j2TUD9kanwM5sfeOsvzPsDcFTHFsWqu3z7UvKRL3WbuMHBkqLET
         CRpWOEg6MdVQ1QLHFMJdH/20ieF+1vk6fiLuEzCH/38h8xH3IepSxaN3z0KeHfq0q/qb
         7jlYC+g7CGimM6MdAJOopnLY2zXwVzcZxlldLssWWgq+degdnngErr6Z9I3TXbgAijjq
         H9dPbU7QnI4JDkbEakTxcyTb00KjyG2pW5edBdIPTtLP/6kxhJo4k7Wiq55zqVK+s169
         b/pQ==
X-Gm-Message-State: AHPjjUgV9VBN/6K4UaYPYFqbkwDwdFVd9Rqgld9QdlosNlu4km/QnZGZ
        /aLO3roTywqzCA==
X-Google-Smtp-Source: AOwi7QAmW715Jc0z6V20kTPpa9aCMA4HccDTX4gnElbj5sJP7nHuLkIkd7cjBqiZpOb6UXg+K2mzrQ==
X-Received: by 10.84.240.137 with SMTP id z9mr614901plk.114.1505789420594;
        Mon, 18 Sep 2017 19:50:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id x9sm896496pfk.40.2017.09.18.19.50.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 19:50:19 -0700 (PDT)
Date:   Mon, 18 Sep 2017 19:50:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] test-lib: use more compact expression in PIPE
 prerequisite
Message-ID: <20170919025017.GE175206@aiede.mtv.corp.google.com>
References: <308f3128-a96e-e7f0-e430-5eb10b08ec08@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308f3128-a96e-e7f0-e430-5eb10b08ec08@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones wrote:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  t/test-lib.sh | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
