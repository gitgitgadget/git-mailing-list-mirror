Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9FEF2036C
	for <e@80x24.org>; Fri,  6 Oct 2017 17:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdJFRZe (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 13:25:34 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:52645 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbdJFRZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 13:25:33 -0400
Received: by mail-pg0-f48.google.com with SMTP id i8so504881pgd.9
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bHUtTdY+94B5MCfzzI7AtR+yivZMJNzo2ePS3GG/NhI=;
        b=qXLQvKJ7ygql8aFz3v42l/y3r1vr1/Vt1HrNjg4342mZNlsje+VdGlMlZsKMrj0vxw
         YM+tj+ghpVz6pFIHns/DyPnHZ0jMlhAokW3ztFb9UylgslB+32NEM3i+KIQ5/hZqwSyI
         RPd7HPMchdg3eMYcspUJmnjx5R7XRWgFEiFP8g536JkPLc76wT94e/GgXz8KhawmgJtE
         0ZyGKjgOgdaTuU8jylJvgrF1CIAH7tbCuk6oJhrVCT/cpsr+84uCsW8iNRx2zeAgc9pX
         UqdvHzp3tweG9M2LNC6xG01gv1lZtQq5cfvfnVzDkNW8T6vSSOit1ANq8vTDTe6ZlWaI
         ihDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHUtTdY+94B5MCfzzI7AtR+yivZMJNzo2ePS3GG/NhI=;
        b=VF14aKQuhnb/ybZ9Fr30f4b9Vuy5xrI1LpWZSRLhVMD2vLugblcBBNj3xODMVVL58N
         YtwWPLqLpGduw+Mf7mJXrFrsYCGPspA7nNTiML0rGxJOHlSCu8jTnCSAx2l3jZwV8JD+
         uiDjOniAeT7o++Qg4LM3O0HqjvhMe03hNxYl8wrjlkVmGAKlUjoLXi47VSBINWl4F0kl
         /SNIpl+eEFHOKKuPM6C5Ynbscd6LfMSfn2WrAto2qvO0JIowKVjoqWxyGGUMK8oWx3nk
         WoI0CskFnhcZkhXwpAxPd9CbJRIu3kXKt0SiEINPv4/PeEfOW2xYC2v3JwhIFDZK+7tf
         sB+Q==
X-Gm-Message-State: AMCzsaUWjNk/2OEorkXeg/WEBEnbOGFwgV9m7PJaVlfFEtG7sO1/UreQ
        dFF4mBMVvkQXSWjL2eWaQx4=
X-Google-Smtp-Source: AOwi7QDp/sPGGDG3NE8zTvoVnEMReNLs1rMIFC8UlIpCC5ImhArfF3ktmbDAR3mlAT0ylbYeAIf4Mg==
X-Received: by 10.98.238.24 with SMTP id e24mr2866073pfi.188.1507310732968;
        Fri, 06 Oct 2017 10:25:32 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:78c3:3d0d:a9b5:4320])
        by smtp.gmail.com with ESMTPSA id r81sm4706781pfj.106.2017.10.06.10.25.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 10:25:32 -0700 (PDT)
Date:   Fri, 6 Oct 2017 10:25:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "aleksander.baranowski" <aleksander.baranowski@yahoo.pl>,
        git@vger.kernel.org
Subject: Re: Git config multiple values
Message-ID: <20171006172530.GV19555@aiede.mtv.corp.google.com>
References: <4b848032-e8b6-be67-58d9-e3fcc2c11853@yahoo.pl>
 <20171006143219.4bn63aoenluc77fd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006143219.4bn63aoenluc77fd@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Fri, Oct 06, 2017 at 01:10:17PM +0200, aleksander.baranowski wrote:

>> It's just an opinion, but this behaviour is no consistent for me.
>>
>> If it's not the bug it's a feature just let me know.
>
> It's a feature, though I agree that git-config is rather baroque. We're
> mostly stuck with it for reasons of backwards compatibility, though.

This feels like a dodge.  Can we make a list of what is baroque here,
with an eye to fixing it?  E.g. if we introduce a new --set option,
then what should its semantics be, to be more intuitive?

Thanks,
Jonathan
