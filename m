Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B632095E
	for <e@80x24.org>; Fri, 24 Mar 2017 00:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933964AbdCXA7h (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 20:59:37 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33286 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755507AbdCXA7g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 20:59:36 -0400
Received: by mail-pf0-f179.google.com with SMTP id o190so195636pfo.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 17:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=09rXU3uL30fn/gOqzthJ+wkhzBRNuBJ3ElxxMBZZk0I=;
        b=sH4z5yU9mz0Cmip3bd8Ouuw6dRv63LUy35fls7qBCa+tmzley60MyP66ij8i1NVJjr
         mvNAHbRQHVS8v2lcnfVnNy7XqVeaVRx/9L0f0ZbxB9wgqUhWQgl45VsvFbDRWHU2X2DC
         3xcL766Zcp20r5Heo7248nKPp5GFguj8ETSkTOUxOlL5pp44kChEKLJtuV+6RjnN0yim
         zb0wFXhVxZj+BI5Pon7xzjwq+7GLgD1dGYJtzgvXWyZ/VYXiee8M1lS3HQEER0v8zxEw
         AntvPrd8eWkoFlt5vUeCbADsftOPb4BcVILev+7SzyaACbAJla5t8bjxIk9QPLoJAG7Y
         VX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=09rXU3uL30fn/gOqzthJ+wkhzBRNuBJ3ElxxMBZZk0I=;
        b=ikK/B+qMZ+MSr4SEABWAE/LAGEOdWXQyxULzBgjTYcXegYFrQ62hQSvyO8AhMDA8u1
         4rM/Df8L9lM5jT/uEXpf/vOaYMRuVyM5bUK3qK75efuMwNQPub+LxGSvLEbP6UCiTYin
         hhQcfhnEnE3QwGQ4cEcdtKSAmgG79aYHs8RwHepRhw9GfkCqlkbgX3vIUqcQ2o/OZsQc
         IKzPLvt5jjTUDEDzjlcwNY/YgbvmfEse5yBCn1Ikuf4dKEw1HgImeOG9Mt7xI4DiQsc3
         ERXW4VKGjnA1vgnExOZB6EkDee1/1YOfahvIXzTJHCghDZKczRbZnuqWUtrpZvuafNJx
         N+tg==
X-Gm-Message-State: AFeK/H3d6wsyR8jlI6/yKqCB+ifKFv3fAhN5+8e4yWExhGz9CBWcOqYJSXuvvDrVoWfQcA==
X-Received: by 10.84.214.129 with SMTP id j1mr7045985pli.23.1490317175032;
        Thu, 23 Mar 2017 17:59:35 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c40:39b9:f9ab:ec6f])
        by smtp.gmail.com with ESMTPSA id t187sm555125pfb.116.2017.03.23.17.59.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 17:59:33 -0700 (PDT)
Date:   Thu, 23 Mar 2017 17:59:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t/README: clarify the test_have_prereq documentation
Message-ID: <20170324005932.GG20794@aiede.mtv.corp.google.com>
References: <20170322221854.10791-1-avarab@gmail.com>
 <20170322221854.10791-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170322221854.10791-3-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> --- a/t/README
> +++ b/t/README
> @@ -612,8 +612,10 @@ library for your script to use.
>   - test_have_prereq <prereq>
>  
>     Check if we have a prerequisite previously set with
> -   test_set_prereq. The most common use of this directly is to skip
> -   all the tests if we don't have some essential prerequisite:
> +   test_set_prereq. The most common use-case for using this directly,
> +   as opposed to as an argument to test_expect_*, is to skip all the
> +   tests at the start of the test script if we don't have some
> +   essential prerequisite:

Nit: the hyphenated word "use-case" feels jargon-ish.  I've seen it
more often as two separate words.  Better yet to clarify that we're
talking about idioms and not just goals:

                       The most common way to use this explicitly (as opposed
      to the implicit use when an argument is passed to test_expect_*) is to
      skip all the tests at the start of a test script if we don't have some
      essential prerequisite:

With or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
