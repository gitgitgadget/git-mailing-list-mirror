Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65EB1F406
	for <e@80x24.org>; Mon, 14 May 2018 18:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeENSW2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 14:22:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41683 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeENSW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 14:22:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id v63-v6so6409705pfk.8
        for <git@vger.kernel.org>; Mon, 14 May 2018 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y24nolF5iWX0sLqfaA82E766ODnEXj1/OFxkYj2BWKM=;
        b=Czz2dyVUHeXvXa+6D+fv900KvXilMq+q5gNXpe4jPxsP2nPXr3hZMki9W/lBAED5IL
         potfQtks8LxH6/eb3FXEt8R8lF8hLwl1/pWsFKdgeugX4iOCWejyJEVLgnVxD235PZCv
         bioJtOXe0WEinJceOvezDhgBJJcxzREzn14AaAqDq9auVCDTfv2V3Bx8kcyNI3onr8gE
         UDsxUkRKoUY3Zzf3Pnt4MNu+4MTPJY9g5q5bToXM1VELh6tVuylfvmPF4K1j1qAt/1cE
         Uk2vwFHZGripJC4fR/boArkdVa1vwUzRRbMwfrdXLReSEL7g3GUc5ZBKke0/j9wBGo/Z
         cKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y24nolF5iWX0sLqfaA82E766ODnEXj1/OFxkYj2BWKM=;
        b=ACqMnL73Et7oFFiPvORgfVJU4yzkCBABiipTTMXur6ZSP+9Ker79Y0Y6eDmUHfyEoQ
         CxnII9hbSCFXQuBfz1UAJwij8OAf3yCi339FxFm6fqP9ndWfLJTBOsG5KtxjdfKRUmaC
         HfjQZr8/PhnwI7Rfrgo75pZSt84F9FPvPThet5mDpI3RGKQb8dkxITYoLfoL3nU8uzMb
         qtOeZUJtmXe9zthewVyvWdOpzqcEUUsvCep1RxpDXI7FCMEcqu2Wk4h+pCVGwVB/4k32
         jN8q/2AQDcnOoEnRImZu0WDKcgZqwHXDwf6exSrbypMa9vfnBzHk3wEy6RRXSJ+D3Yfo
         24Vw==
X-Gm-Message-State: ALKqPwcfHTsE3TNEvQe4ms89Z0HZNvxubuS+78WUYfqLffsAEtw+KZzR
        lWzPGbbWxfn92LDSdZ9Q/epqeA==
X-Google-Smtp-Source: AB8JxZpbuRcWGP6QVpqA+PlcxWD/VoYEeTjGKCpdjZoBgECjeX0bQRbrS4SW7qBplPu/XCo7pUPqCA==
X-Received: by 2002:a63:6bc7:: with SMTP id g190-v6mr9321148pgc.230.1526322147265;
        Mon, 14 May 2018 11:22:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 4-v6sm20692337pfn.38.2018.05.14.11.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 11:22:26 -0700 (PDT)
Date:   Mon, 14 May 2018 11:22:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fix config API documentation about
 config_with_options
Message-ID: <20180514182225.GB235601@google.com>
References: <20180509131628.20099-1-ao2@ao2.it>
 <20180509171950.GB63423@google.com>
 <20180512001705.1ce66754ce72d2b57c7e6d96@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180512001705.1ce66754ce72d2b57c7e6d96@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12, Antonio Ospite wrote:
> On Wed, 9 May 2018 10:19:50 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> > On 05/09, Antonio Ospite wrote:
> > > In commit dc8441fdb ("config: don't implicitly use gitdir or commondir",
> > > 2017-06-14) the function git_config_with_options was renamed to
> > > config_with_options to better reflect the fact that it does not access
> > > the git global config or the repo config by default.
> > > 
> > > However Documentation/technical/api-config.txt still refers to the
> > > previous name, fix that.
> > > 
> > > While at it also update the documentation about the extra parameters,
> > > because they too changed since the initial definition.
> > > 
> > > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > > ---
> > > 
> > > Patch based on the maint branch.
> > 
> > Thanks for updating the docs.  Maybe one day we can migrate these docs
> > to the source files themselves, making it easier to keep up to date.
> > For now this is good :)
> > 
> 
> Should I resend the patch to gitster@pobox.com with your Acked-by?

This has my Reviewed-by: Brandon Williams <bmwill@google.com>
though you don't need to resend the patch to Junio, he has normally
taken care of that :)

> 
> Thanks,
>    Antonio
> 
> -- 
> Antonio Ospite
> https://ao2.it
> https://twitter.com/ao2it
> 
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?

-- 
Brandon Williams
