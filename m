Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387B61F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeFZVlG (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:41:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:55667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeFZVlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:41:05 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPZuP-1fTmyj3sor-004i3Q; Tue, 26
 Jun 2018 23:41:01 +0200
Date:   Tue, 26 Jun 2018 23:41:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v4 1/2] sequencer: make two functions and an enum
 from sequencer.c public
In-Reply-To: <20180626161643.31152-2-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806262337360.21419@tvgsbejvaqbjf.bet>
References: <20180607103012.22981-1-alban.gruin@gmail.com> <20180626161643.31152-1-alban.gruin@gmail.com> <20180626161643.31152-2-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mMCm1IDrcflr5+jTpNp6v1xSo0I7D+VE/sBEJTBHHqz/UfggZop
 V3BkfgitCi4KRcJwHWNE7qW6AA8CS0VIViqQlVm2yVLnms3dgxPZUgY58fRDvvy4nFrJO5J
 LalgwwD0QI0xXkv7LwVfwYvgbFoWmPHnBf0JMER105DJ5/sScyVBveqvPTMfWD7uV5Ig2yF
 k6REt2+sQhCBej5u7f9yg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ytzxdwhjfss=:F+3aVahHGlaziIDWmwqg8K
 zBEzcGGBIEaT9ViWLtvXYlVUhPkZxi0dTYzPP2+MgbnZdyLZ5pI3xKhWfVTAKWdbf1jFY9QVB
 fE8NZ3fAA9w6Pmw2eTl+KMHWJkvlWa5mgR3qSyPiZOkIEOokOYxMP+UYqQujTJ0mI4PQoTNVt
 Z9ohOsOQ9xvXwbUQlio6E4V/d9Cwbmpl2n9RjNd01rsdUfxJyISXPpWyAxFgMlFnQ+m+ZNJkJ
 V6w75tP/d9+S76XX2zt9SVZFH5EhCJwthkVm6J5mYeabL2V3Qw4srVnuqgpp/pqWbPOAf4cBV
 Q3sq/Dpw9k0yEl+EAfhCGrycGlrK2bzNu9ZU7JsbclTQGIpT7t9k4QoeYW6GFZ9T4mY1W17fm
 us1x840fwe0VILYDrCDWovfAfSTN4xIURL8YpSbAVs2HjBiNxY8/mhU1aAAczxMc4OL72elyy
 77zAOjyhCi+oJBFANPeOvhMW0N2gI1ejKpjeoxy1evB8whqbH/cY4BYR+DqNoKu+LNnH777h1
 LeGEzxgePr0/jDuxGGrA23QIWqo1n503SGc0c1TjkHNj8sTPDc0aG+JJHCmIPE/msFgSVI3E6
 jcg34D2sXdklx4RvmrWU0QKxSPaIX0Ng+DSqr2WFDiPbREW2fd3F5kM072K2+Uxmkg0nnm0Uc
 X28WZLK/zxnPhilPLxPVxjUZh87po/xtLSUxI4M6fv5ntWM1mmaQ6TdnoYG9CH8i/h8+wDgSh
 3GtpQoazKvC39AtsMBkZljBhUq/KXO5OoO8LYfW4tAc/dNituRHBhXPnVi5i0e48C0W2d9D7S
 xcNhqCo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 26 Jun 2018, Alban Gruin wrote:

> diff --git a/sequencer.h b/sequencer.h
> index c5787c6b5..08397b0d1 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -3,6 +3,7 @@
>  
>  const char *git_path_commit_editmsg(void);
>  const char *git_path_seq_dir(void);
> +const char *rebase_path_todo(void);
>  
>  #define APPEND_SIGNOFF_DEDUP (1u << 0)
>  
> @@ -57,6 +58,10 @@ struct replay_opts {
>  };
>  #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
>  
> +enum check_level {
> +	CHECK_IGNORE = 0, CHECK_WARN, CHECK_ERROR
> +};
> +

While this is contained within scopes that include `sequencer.h`, it *is*
public now, so I am slightly uneasy about keeping this enum so generic.
Maybe we want to use

enum missing_commit_check_level {
	MISSING_COMMIT_CHECK_IGNORE = 0,
	MISSING_COMMIT_CHECK_WARN,
	MISSING_COMMIT_CHECK_ERROR
};

instead?

Ciao,
Dscho
