Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385A52047F
	for <e@80x24.org>; Tue, 19 Sep 2017 20:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbdISUWF (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 16:22:05 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35814 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdISUWF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 16:22:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id j16so393750pga.2
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GWRsQCUpWJwHqbKimJ9aLS+j4Y6VgxUeMePFkX6Iels=;
        b=uesCmNGaxlqeeYSAOk4o8qHe1vb6uL9acZwqdaGIM1AGLNpyKDcz2CjXNJ43VFtzqI
         jHe5Kg0/NN2xqQx+d/NELFNtQuSZ0obhto1+cOz7cN4bu6StitbTmXLSLMSUi4QoZ2oi
         E3tciGuDAyzvoZpofa2JEtQ+2DJ9mUYGgbXjIy5tMP7HKlMLDwYTpqx/FEUyzJ7HeNIV
         /vvo9mhLzrQsmENoFvtuADbd/0HiHOlavEBrdaYMToB2fpwoHCYMHgNndWNhzQXmC/iA
         xPQKW8ArqHbaeYA/HZThhE0RxDNWAp5Y6T+lZIEg84wPDM6LDB7n5vOrVn23Owxke2Po
         GJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GWRsQCUpWJwHqbKimJ9aLS+j4Y6VgxUeMePFkX6Iels=;
        b=JpmsJRi6AFhwycvoRTsGneh3aTVYO3hWcxgFFlGmgJHHd92Jq80gvuNTqadpllam4x
         p/mS6Mk25NUKSfydPmu5aAWH+j68aMUcsOUVxgQ31FLpq7v4slQvfVhcRjfEIilXX4k4
         e1ArHM5juEe/uZY8efZa8NWYXxvpooZOIhNHnkt+2M3veEE5yVQphoSvZnUvDUdYz44R
         hhYpGoo2KEcTSJ6tjbGGO5ODR1yWyToGfJhKfpan+iaQ0i8rqL0U2Ov86fEjcS/JfcLj
         LS8eld1m9USzZdH80kX6wo38tesb8GIiA7TpQyuHLlzK+o2gl7ETSLYDMwcQtdM9t2Pf
         Ufxg==
X-Gm-Message-State: AHPjjUjqP9WwayqhOS8GRw1NSQxt+WUvAS6JKsYbL6ZEqM6Zcqp54O7p
        ROKuCl4pmdm2+mb5srplqr1dJCF7
X-Google-Smtp-Source: AOwi7QCTZK+sriPTRDwAhSnT05cw7gpC6aOhXUsHUhtgGx+bUXcWRPBh1KB/pkCQuI2EwBHXHhVAkA==
X-Received: by 10.84.197.69 with SMTP id m63mr2316142pld.226.1505852524469;
        Tue, 19 Sep 2017 13:22:04 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ed67:93b4:3411:bf26])
        by smtp.gmail.com with ESMTPSA id e4sm4184634pfa.112.2017.09.19.13.22.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 13:22:03 -0700 (PDT)
Date:   Tue, 19 Sep 2017 13:22:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: camelCase the config variables to improve
 readability
Message-ID: <20170919202201.GD75068@aiede.mtv.corp.google.com>
References: <0102015e9a2d3eb6-bee76ba8-4298-47d2-8822-d513bc33bd71-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102015e9a2d3eb6-bee76ba8-4298-47d2-8822-d513bc33bd71-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Kaartic Sivaraam wrote:

> The config variable used weren't readable as they were in the
> crude form of how git stores/uses it's config variables.

nit: Git's commit messages describe the current behavior of Git in the
present tense.  Something like:

	These manpages' references to config variables are hard to read because
	they use all-lowercase names, without indicating where each word ends
	and begins in the configuration variable names.

	Improve readability by using camelCase instead.  Git treats these names
	case-insensitively so this does not affect functionality.

> Improve it's readability by replacing them with camelCased versions
> of config variables as it doesn't have any impact on it's usage.

nit: s/it's/its/ (in both places)

> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Documentation/git-branch.txt | 4 ++--
>  Documentation/git-tag.txt    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

This also is just more consistent with the rest of the docs.

FWIW, with or without the commit message tweaks mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your attention to detail.
