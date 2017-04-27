Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2705207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423435AbdD0W1O (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:27:14 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36265 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbdD0W1N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:27:13 -0400
Received: by mail-pf0-f181.google.com with SMTP id 194so39394890pfv.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Hcx1gyt/Kyva+HbljDExXhZUhddzl6pmtp6BEzVt9UE=;
        b=SK1R57vNsJUjBbQiz69/KKLR4MLnvROtUEAcNtXesmFhGJDF2MxYOXb3URHlY068Tg
         xfXngaEOuqIAf7VrDo330EZw4jkQgkbZH4uD2iL4yHtDOIj1YfjCPBU4NCW5NbctVJtp
         ax2gbbH6gdcl/7mPIBC7zSrnBgZUY09GzOSLVRqjVTLtmIpFOzRa+H28XXOe0aF/GDPW
         yqLW7qLgiVVMqkaB7gOqxcrmwbHoj9GTfkc4esPNzL/7+nQAXTMusuhgcKfbARp6Q15c
         ywtkHVdnFmK9xtCrL2RALlsZ+npO2G3g+846TOe/0l7U7InHPOJWz+NNOAsvfWchf4YM
         y6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Hcx1gyt/Kyva+HbljDExXhZUhddzl6pmtp6BEzVt9UE=;
        b=hExpmYHGQkWRIhPpn9XkhZgGBtp667Ei06MCkV3wGq9IaesJahzI/0nETGL/vy9IVn
         vH0276HPGQcbXPRswEjKp0KxdzDewNU5wK2H1QG2agk/l7UBa4jELSA1t4ysy5R1aqRY
         +kA3KjYl3kJXWK+vgsJP6kAm6G5+lSsVFySAblyYpHd9lhxeFivamodfOIAxIRZqgtLs
         7FlfTgYNaEd8K8xOiaTmY8glEALX48OVr+MblvuevhBO8pRlceT5A+RhzdhFcp417sGx
         XLXYX3PenYbfIY0z5hfuaCrRWwSlJkNBxoKIijfXnNRcpYnkixeTiMGJaAzonCuJmPfc
         H/Kg==
X-Gm-Message-State: AN3rC/5gnVqL5aFDcnrOC0WmdIp21ouVmqc5puHTkmmX0liknlXd61MY
        DgmIu8S6Ylq3qPsh
X-Received: by 10.99.7.139 with SMTP id 133mr8531034pgh.86.1493332022808;
        Thu, 27 Apr 2017 15:27:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6199:b109:ce03:97f2])
        by smtp.gmail.com with ESMTPSA id l7sm8522366pgn.10.2017.04.27.15.27.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 15:27:01 -0700 (PDT)
Date:   Thu, 27 Apr 2017 15:27:00 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 0/5] clone: --no-tags option
Message-ID: <20170427222700.GD146047@google.com>
References: <20170426231236.27219-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170426231236.27219-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/26, Ævar Arnfjörð Bjarmason wrote:
> This is an expansion of the previously solo 02/05 "clone: add a
> --no-tags option to clone without tags" patch (see
> <20170418191553.15464-1-avarab@gmail.com>).
> 
> This addresses the comments by Junio & Jonathan Nieder on v2 (thanks a
> lot), and in addition implements a --no-tags-submodules option. That
> code was implemented by Brandon & sent to me privately after I'd
> failed to come up with it, but I added tests, a commit message & bash
> completion to it.

Na you would have come up with it, I've just lived in submodule land a
little too long (though not as long as Stephan has!) :D

> The WIP 5/5 patch implements a submodule.NAME.tags config facility for
> the option, but is broken currently & floats along in this submission
> as an RFC patch. AFAICT it *should* work and it goes through all the
> motions the similar existing *.shallow config does, but for some
> reason the tags=false option isn't picked up & propagated in a freshly
> cloned submodule.
> 
> I'm probably missing something trivial, but I can't see what it is,
> I'm hoping thath either Stefan or Brandon will see what that is.

Overall the series looks good.  I've mentioned in the other threads that
it probably makes more sense to have --recurse-submodules simply pass
through known good commands to its children (e.g. --no-tags) simply
because it makes the UX a little bit easier to work with (I don't have
to remember all the fancy --OPT-submodules stuff, only
--recurse-submodules).  That is unless you have some good rational that
I'm not considering (completely possible :D).

> 
> Brandon Williams (1):
>   clone: add a --no-tags-submodules to pass --no-tags to submodules
> 
> Ævar Arnfjörð Bjarmason (4):
>   tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
>   clone: add a --no-tags option to clone without tags
>   tests: rename a test having to do with shallow submodules
>   WIP clone: add a --[no-]recommend-tags & submodule.NAME.tags config
> 
>  Documentation/git-clone.txt                        |  21 ++++
>  Documentation/git-submodule.txt                    |   8 +-
>  builtin/clone.c                                    |  19 +++-
>  builtin/submodule--helper.c                        |  21 +++-
>  contrib/completion/git-completion.bash             |   3 +
>  git-submodule.sh                                   |  13 ++-
>  submodule-config.c                                 |   8 ++
>  submodule-config.h                                 |   1 +
>  t/t5612-clone-refspec.sh                           | 103 +++++++++++++++++---
>  ...odules.sh => t5614-clone-submodules-shallow.sh} |   0
>  t/t5616-clone-submodules-tags.sh                   | 106 +++++++++++++++++++++
>  11 files changed, 284 insertions(+), 19 deletions(-)
>  rename t/{t5614-clone-submodules.sh => t5614-clone-submodules-shallow.sh} (100%)
>  create mode 100755 t/t5616-clone-submodules-tags.sh
> 
> -- 
> 2.11.0
> 

-- 
Brandon Williams
