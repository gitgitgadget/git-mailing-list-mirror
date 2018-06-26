Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D38C1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeFZV7u (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:59:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:41461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeFZV7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:59:49 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9fLX-1fS7ua2dJ9-00CxqJ; Tue, 26
 Jun 2018 23:59:43 +0200
Date:   Tue, 26 Jun 2018 23:59:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org, joel@teichroeb.net, gitster@pobox.com
Subject: Re: [PATCH v6 0/4] stash: add new tests and introduce a new helper
 function
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806262357400.21419@tvgsbejvaqbjf.bet>
References: <20180405022810.15796-1-joel@teichroeb.net> <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sFPm85abSDkUTmfDgxTCXoAXXJOeMQTrPHBJm0If56Pv69gQDGq
 n2JdeM4GVHeliBUoFArRHdItucoJ4K5iEUt4bKHX3x5Eun7hKixCljSGFLF0Pf1eneWATZ6
 oX6iLJcjaq3F3syk/DD6fK4M7HivzCxCgtcT7BNb4DRpEpgcywlyaW5GFHM5R5CKeAbtAzS
 HbwOkWmgw4Rpcqv7j3lUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sOPjKs9qN44=:gep50NaOXIUuVAizgVxJh+
 CGkwOaRVo6A9cvzVEGH8eT/isSnDmRAb7HWHmK2lsOYrTfygaLFYjFOuH7EDpCjFfEHlHGeEW
 1WYGiWScx3C7+QIrv/omMJP5wxjp3edZPL12RxkwyOfnUKy8CBsDevXzbHH6lVCkm6//8ELKr
 69PbrSL3/aFumxGUVlKeixgMi5q3MBa42JkKGGk/zt3vH4lY56ULmCm9c6VEz0JlCPPKKQQ8w
 k9jamr0lT2AIoLcYZc1HpqzXwzLmgh+ujwVDAuMO3jXAUxtjjNARnVisL5j1bocnJFf7zvyfg
 9pVLm4vecyVjIxrmz8iP2FCq8VBPDfrexGnksL24xZP+UJHy7KByGoBgqafgLxnEb94tLUwwY
 PPHK15IjAnaOiCXRp/RkFerAuAnPR2LsudfCs4wC9biZV62Q/vKYT6zjVmvpsMyTnNaFsa6WC
 TNWRArl+r1FKnw7YHiICnzOCb6ZbAERebv0TPLm888VRzC68BO6+/Rqk1TMQYLE5Q0zZqK6kN
 JxU5gXVEYpSSkv6uvs6eA6FhyGDgRgZItqIu4P69HYf+GmQu7aig0mR28foNV//mpTD+xoVc5
 kscYVrFTzJZulpknCxY8EzwUMnQsA1nK3CLWCmPL046oYm7OtRgQB3qMdpILUgP91z2wPINMv
 Vu8Kb7+aOw9aFvnf1EI0uVBXzYTQ0Eu5KQQvDUvStzLbszpUiQxaF+BwADOOsq2S4R/K+ihzP
 feRrgTwkErmxhT0ojXi/g7b+ghl5uynveevqDLFOa/uFHkbyYaEAI4AVGK0UbKlB8EE+vPLsF
 2WAupCx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 25 Jun 2018, Paul-Sebastian Ungureanu wrote:

> This first series of patches does bring some changes and improvements to
> the test suite. One of the patches also introduces a new function
> `get_oidf()` which will be hepful for the incoming patches related to
> `git stash`.

For reviewers: it is *my* fault that this patch submission is a bit funny
with two 1/4 and one 1/6 patches... *I* suggested to not send a 14-strong
patch series but split it into three, and then I failed to explain the
correct invocation to do that from the command-line.

My sincere apologies,
Dscho
