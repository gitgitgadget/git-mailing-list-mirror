Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1125520899
	for <e@80x24.org>; Wed,  9 Aug 2017 00:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbdHIAHr (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 20:07:47 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34486 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdHIAHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 20:07:46 -0400
Received: by mail-pg0-f41.google.com with SMTP id u185so21006974pgb.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 17:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=07YaPc/DWB6S3/Ny0OxvVELMjSVfRMtFoz8eBR6hn4w=;
        b=c/wGHhtF+RXO7ztaI1JnhVg19bE8MumEGlzk2T+wEaskbRUWvQXf2CGiS53hPOA9YH
         AmQIPshF9VWPLFG02BTMvdJuM5XDt1zbltpz5Be3bbVDgkBL5bB0j7IVcvS/bUg8XyNC
         CyQT3JrqZZbChOcJJS+vggFKP49RwVaI/bFMd+GsnaWDa0qBCOakvwiGHwCDry9hpz2E
         0OtpM+MWklBRji/bTg0hh56uYUakWvW6mlfe5zFD3OKxSFxpoTQJSAC5oZkXb3NVjBsA
         xKDtTK2fsTKoEQR6AL71kyISy3lOMCVaIGh9Hy7/0s+wSrIAp+h3e+twDRSxsD5lJDbQ
         IDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=07YaPc/DWB6S3/Ny0OxvVELMjSVfRMtFoz8eBR6hn4w=;
        b=EMj1DvWD/sF7p9b0Ml5YeoMtgzJG4J6NfX5yfmNyKu285w6tFSld9Y9Fsu14tmHNOM
         hV3f09LAu5IQlwcM+rIjjXp8/eYjlo9x48pjsvkM2aHK4nGqN7F61voTyLqP0PIdsoxu
         T1fFBZvXaauXtsBD3fpI6CI2GwHr3Rqz936mKQMCWmgO/OP9XACKCrZFk+I+kNuFgK9R
         6qcmQXyBVr+rI/ns2rdn9NnOe7Dz+S5EDi4XfvV+HHgI8uj+Gr2pze0YobdYWMMRI+D1
         qfpz3S4mD8nrt7QrJHQkuFBHcoDNmy/We1JiCfL0FRF8v+pQ4jRhZqNzrtBkBCCdguCZ
         zsYA==
X-Gm-Message-State: AHYfb5jvpG8hONfF5RZ2AdUWI/i0cQcX+y88GnghAKpJeV1Rr6YrtEsC
        P8XmvYyVjfrm6vS1OWA=
X-Received: by 10.84.217.28 with SMTP id o28mr6574876pli.319.1502237265955;
        Tue, 08 Aug 2017 17:07:45 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:d173:771d:dd07:d344])
        by smtp.gmail.com with ESMTPSA id y22sm4592568pfi.159.2017.08.08.17.07.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 17:07:44 -0700 (PDT)
Date:   Tue, 8 Aug 2017 17:07:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org
Subject: Re: [PATCH] t1200: remove t1200-tutorial.sh
Message-ID: <20170809000742.GG169894@aiede.mtv.corp.google.com>
References: <20170808234308.25565-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808234308.25565-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Nowadays there are better tutorials out there such as "Git from bottom up"
> or others, easily found online. Additionally to that a tutorial in our
> test suite is not as easy to discover as e.g. online tutorials.
>
> This test/tutorial was discovered by the patch author in the effort to
> migrate our tests in preparation to switch the hashing function.
> Transforming this tutorial to be agnostic of the underlying hash function
> would hurt its readability, hence being even less useful as a tutorial.
>
> Instead delete this test as
> (a) the functionality is tested elsewhere as well and
> (b) reducing the test suite to its core improves performance, which
>     aids developers in keeping their development velocity.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t1200-tutorial.sh | 268 ----------------------------------------------------
>  1 file changed, 268 deletions(-)
>  delete mode 100755 t/t1200-tutorial.sh

Interesting.  When I first saw the diffstat I assumed you were talking
about a test that validates the examples in some manpage are correct.
But this is not that.

There indeed appear to be other good tests for these commands, even
"git whatchanged", so for what it's worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
