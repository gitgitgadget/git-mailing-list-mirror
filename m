Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FD01FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 23:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbdFMXYM (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 19:24:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36331 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMXYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 19:24:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id v18so20997588pgb.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AAczDbbeEeE/uE5uH6WUMYqLYphvkOJiNRXyskEHsLg=;
        b=puZhnXX5sCd9mMe8cTNWZwOwUq1aKe+z/z65psjyjcbaRzF6JkxKXQNSqmgbgc8h2e
         xA20MECquh4Q9xJ4oMmoTjIIJmMGG6NjtDfTdkNFndkATw5pDdkoFgp4qv30wnuOKLVT
         e1IhODXEsVYiSllpL+Hx5pgipfiCFO1K5c9zJ2oKyZgTJGVGRGbISpyBZ/FV8t+hNyo6
         z2xiRCdlspDbGfe2eIsB0RHX73WRlj9oZw8iLDW3oahixlAIug8QKR/GcuW6JBJxVSNe
         7MwO8I/f5Wif8Jf0X9w6An0X5kJVzpA4lEJsJPctQZlY126lOPjGBZFVL9lB1o7MHFA4
         gxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AAczDbbeEeE/uE5uH6WUMYqLYphvkOJiNRXyskEHsLg=;
        b=aeEW7NuyfzyTXM0y5iJJ4I7sTkQ4TA594nfHQgISaMPmpqT5pxez3ir1zZKZnXRrlz
         p3uKqDqDIHJq996si8/sPrpKIcySUni6A7gL7nCVrqtgg4OPXq9SmBMZMoe9rkaA3VDf
         oaWntva2yMTrb9NB8XmLIWYoEu2vCNlHD64kktU0ZsKaABi12bXhcbhwPU2v/wF8ajtv
         z4JsbF8bgJcjB66grGiHUJFEIF7jmtXY1RIFKRP0cykFN/pCq0Dqw05tUmMIMFBapYC1
         TPDtH8qwsjYaq/N+fkWDY3CE/46Cj4HErFYNPwIXH585VXX2PQqjO6aLe7+Z3AwsvTEh
         s3DA==
X-Gm-Message-State: AKS2vOxpZ7sbgIzaeFcdAhMGok0wkYGtqHgQW8qI0YGvH3ManGVkLOB+
        GCG6/YwPcIU9Ug==
X-Received: by 10.98.43.206 with SMTP id r197mr1452400pfr.202.1497396250378;
        Tue, 13 Jun 2017 16:24:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id 69sm26759027pfy.119.2017.06.13.16.24.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 16:24:09 -0700 (PDT)
Date:   Tue, 13 Jun 2017 16:24:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCHv4 2/2] Documentation/clone: document ignored
 configuration variables
Message-ID: <20170613232407.GQ133952@aiede.mtv.corp.google.com>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com>
 <20170530071244.32257-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170530071244.32257-2-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

SZEDER Gábor wrote:

> Due to limitations/bugs in the current implementation, some
> configuration variables specified via 'git clone -c var=val' (or 'git
> -c var=val clone') are ignored during the initial fetch and checkout.
>
> Let the users know which configuration variables are known to be
> ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
> documentation of 'git clone -c'.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  Documentation/git-clone.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Makes sense.

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index ec41d3d69..4f1e7d4ba 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -186,6 +186,10 @@ objects from the source repository into a pack in the cloned repository.
>  	values are given for the same key, each value will be written to
>  	the config file. This makes it safe, for example, to add
>  	additional fetch refspecs to the origin remote.
> +	Note that due to limitations of the current implementation some
> +	configuration variables don't take effect during the initial
> +	fetch and checkout.  Configuration variables known to not take
> +	effect are: `remote.<name>.mirror` and `remote.<name>.tagOpt`.
>  

Tiny nit: the paragraph of --config description is already a bit
overwhelming, and I think this additional note takes it over the edge
where I give up and stop reading.  Could it go in a separate
paragraph?

		the config file. This makes it safe, for example, to add
		additional fetch refspecs to the origin remote.
	+
	Due to limitations in the current implementation, some
	configuration variables do not take effect until after the
	initial fetch and checkout. Configuration variables known
	not to take effect are `remote.<name>.mirror` and
	`remote.<name>.tagOpt`.

Thanks,
Jonathan
