Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903EF20286
	for <e@80x24.org>; Tue, 12 Sep 2017 11:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbdILLaw (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 07:30:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:58903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbdILLav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 07:30:51 -0400
Received: from virtualbox ([37.201.203.107]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlDx4-1dGkDr3ZCg-00b64Y; Tue, 12
 Sep 2017 13:30:46 +0200
Date:   Tue, 12 Sep 2017 13:30:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2017, #02; Mon, 11)
In-Reply-To: <xmqqpoay3tgz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709121326410.4132@virtualbox>
References: <xmqqpoay3tgz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UMhOVF+l6aK3wK8fo/3gEzVl0of6IKtZGVSlPefk1friSNHYBtR
 aVTWPXou267xACU20A1yT/sa1sqL7yGJDjcxlmZJWSrU3V2G9/bhObe4oXjHBZHqLg+Eln/
 N+kkR5VwbCvXckrN63jm9ZSQVUZMNL4N+dfF4TfEF51w2iMw5wu7Y9uRlHgH6EwKjfjysH8
 CanLgwnQ01gmsOSi4tDDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8gFcd6/4yMQ=:LJssM3QoqL7IhVAJ58vDBr
 BZZP9X4v9PraaQwaGy99mU9TqsqqG0IVwiZawZJmwRyUqY4cn1IKO4Qlf1u0Kn7eE4mhIgtnb
 OwjTW1ill4YIIj4fNEd+IOFj0IFdDViKDAkuYQv7aUFAFAb22LgMjnaWRXzRi3ef0Swpi2Tnf
 zG0F/OLmQYrD94EmBwMqcDAS/roY0/AeuKUycZhDa+HHWGPidu40hIrldVcNFOAgsWs+//0RX
 DOeffwCtGnrVXhd5dW46J9J5E3X7PGFHuGG5TyI1ND78Fdkt660dqkk64pDpZPU18ZwK3H/t5
 fDnLQ4Mk4Qk8gPQj5Ziq8iJm5OJKhN/LeMDZECobPnEjQUVoAqZEErym6hl/wOiDHWWHbuKr+
 5zVlzmHV453EjOmzxLLVg4MH5d8gBLY+vitZin1jUeMJc6ZLiANrs/D8llueDnq/95JQeIpM5
 fJacsSdWbZMm5LqYosEn4u6HMUg4sz7S0t2HbgFTnwdZd7XywZ0fPd6AU8yNOFnqwrFSUBlTW
 NJTi/7hwQKMqaqBmaWFOKSAa8yPkUpU+iI4kPwxb+HPGPNtPqc/0t2Tg4jmMLbWpHBEt/66rQ
 qp8WD7qvY21rwFvvHV8hBJ74PB4NoOll8q1gxrEmDkBQ8+TTWKp1yYbLGYHHlfX2IRuURxJab
 XmmZh3Lgum0LQeajp7asXIryN5qYZ/TCKu92wS8He4MgFYblEX6nuT6+b4N+JltMYBfetr71m
 u3A3jsTIdvBZgx67qWWa/qsC7U/i+gqsdXuCZlpdzdlFqFJq65dZLLFm1vT2juXsvuO94eTqW
 dygw7J+fVR8EoYAd6VvsLhjgEzEAzatWPVprfFZ1MJaV4A3b5E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 11 Sep 2017, Junio C Hamano wrote:

> * js/rebase-i-final (2017-07-27) 10 commits
>  - rebase -i: rearrange fixup/squash lines using the rebase--helper
>  - t3415: test fixup with wrapped oneline
>  - rebase -i: skip unnecessary picks using the rebase--helper
>  - rebase -i: check for missing commits in the rebase--helper
>  - t3404: relax rebase.missingCommitsCheck tests
>  - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
>  - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
>  - rebase -i: remove useless indentation
>  - rebase -i: generate the script via rebase--helper
>  - t3415: verify that an empty instructionFormat is handled as before
> 
>  The final batch to "git rebase -i" updates to move more code from
>  the shell script to C.
> 
>  Expecting a reroll.

No you don't: xmqqfudqkcux.fsf@gitster.mtv.corp.google.com

> [...]
> 
> --------------------------------------------------
> [Cooking]
> 
> [...]
> 
> * mk/diff-delta-uint-may-be-shorter-than-ulong (2017-08-10) 1 commit
>  . diff-delta: fix encoding size that would not fit in "unsigned int"
> 
>  The machinery to create xdelta used in pack files received the
>  sizes of the data in size_t, but lost the higher bits of them by
>  storing them in "unsigned int" during the computation, which is
>  fixed.
> 
>  Dropped, as it was rerolled for review as part of a larger series.
>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
> 
> [...]
> 
> * mk/use-size-t-in-zlib (2017-08-10) 1 commit
>  . zlib.c: use size_t for size
> 
>  The wrapper to call into zlib followed our long tradition to use
>  "unsigned long" for sizes of regions in memory, which have been
>  updated to use "size_t".
> 
>  Dropped, as it was rerolled for review as part of a larger series.
>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
> 
> 
> * mk/diff-delta-avoid-large-offset (2017-08-11) 1 commit
>  . diff-delta: do not allow delta offset truncation
> 
>  The delta format used in the packfile cannot reference data at
>  offset larger than what can be expressed in 4-byte, but the
>  generator for the data failed to make sure the offset does not
>  overflow.  This has been corrected.
> 
>  Dropped, as it was rerolled for review as part of a larger series.
>  cf. <1502914591-26215-1-git-send-email-martin@mail.zuhause>
> 
> [...]
> 
> --------------------------------------------------
> [Discarded]
> 
> [...]

This section would be more appropriate for the three "Dropped" patch
series than the "Cooking" section.

Ciao,
Dscho
