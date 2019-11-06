Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A3A1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 11:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfKFLTd (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 06:19:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:50541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfKFLTd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 06:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573039166;
        bh=1BOrhGSfiAHtMzOJpfyIBFROSZUupcclkL/m5qjJtU8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gL8oDTXilyTzIiXyUwgxddlxgnfY6boviXw/dntIr1bwLwOEiNLGWnSvoJ9WSXBGx
         kkhS2Ax7P8XuWB1XryXQ5lDx133QO/oxTyFkaxGHbRGWoCqn9N7MNZC5uFZQ53fOtk
         t+2Ck6JKFhIXzj4DobfIBkKPaNFSSGDbjjIc9ZZE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1i5btk076Y-00nDdT; Wed, 06
 Nov 2019 12:19:26 +0100
Date:   Wed, 6 Nov 2019 12:19:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/builtin-add-i, was Re: What's cooking in git.git (Nov 2019, #01;
 Mon, 4)
In-Reply-To: <xmqqzhhcxkvx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911061217510.46@tvgsbejvaqbjf.bet>
References: <xmqqzhhcxkvx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2wI6aErSwTScDtpfcj5VWQ3kpT7aBxorf9gVB+V7T8JlFnEsTFr
 eP0up4aZY7atA57tLQioCpdMvi1XmP6suy+qyjEtkcSzsI5DUubZR/eFPQ5sqBWGc4OzYSN
 ZTPFTJPIjwlF7BBeY3ECBgC9q+7dblCpIJW1onkpkcA3jsFeaH9lmDghZ7lxwTtDamWDH36
 Q9d12dxAhp5JrMS9V0O7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NfMCXI0unEs=:mEfUV71QMv1Z1fmgr4jqYw
 chjZkVVFnhUl50/KkIZ8yneDq0BJfUjmL+P6GCWI9lvA3JFoimytBqEWp/XWmrP1u/rLWQJB8
 5vtd9yXioYQ6s6oyrdgO/KNwjBtvLDARy/rvj+MkLLVnGW1Gl3QzxyWmmq7MhUAQ/dk2ZFr+/
 xtWcZaijIablnhbIRs2RTCVlui6lseuX13ttxYY4YhR4+pxpXVIJExZolgG0uUd7VrgmrupTX
 +epmbJ2WtRPQ6AD33XeTEN80K80P1lCiISpL0LnUrrZA/tlk4VICzVfZm1Z2NmNjBiIDly1ua
 2/CzKH48xH63xbGdKf1viuraxLTiMk3PFU+Q7iMUb68jap7WC03/bvmVQWREjT/B2cW2Qypw5
 r8vkiper78YEBowhNEGxqDTsLtVo5QpmSzCyjFIEv8kXjqD6Bp4AqIRJMu/ajZjcWBrp2+Wrb
 LIzeMVpbiC1POdj1M7DXXCRfReTwUrqXBey7C/Qe0xG2kXj0dkwSexpB7T/AbUq+LCZyPWcaP
 uWbIxELF+3uV2PInIs/iCG7UrDcgwtcQk+VNMuZRwKMKh+M5rfh8q1jY1qt9w+I9Tr9vyEZAI
 3m0r/66jTIIIXeDfSqFYHk0iia6gJowxj8Uy2+52ykW/mJB8fhu/37eyo3YGcoXAF64p2KaVv
 4EAFls3UNha9lIBx7bIiGd6zSdoFfkCgKMaXjlu41KZHB6S/S8q1dJMTsamTRVd0X2AYo9q49
 gFF3W+vsXHAwNpj4fNn1ZzbKj9rIRB77TY+sl/9ovoMj5ivcVhmwuBsOJx0BxpEDUjqgiof6j
 Lo+e4RjisEkh4R1A6+Rc+v0LGr5+jnk9Z5Ylzhf8SDsBNDUv6sjPJJ3lV80bud9xKP0wsdQOI
 Hw3OZX5npdGBmX/atM6rzyaqpafX6VNyP26b/+PPOowO7Rl7kUVWdC/G9YYlMld5Caxafh1m6
 oQEcW53jhLrNX+ZO9oGLsmEfVe3Q8fm+W/OOfEoevZPwFFHdSpttgV+bgUBiA5+HeqB0GDW4D
 VtbEArE9fNhuSBJsLKckndwvEYPOGTBZ36MjZ9QmErtAPKf3vt8KhO4s0nbksSC0kmatSyTzx
 AOgXLaV+Q5colTJtruAsGi1KL7xnwnvuab5ZgtKYeCmRBbf+CsdpTebbnYG+jKuR46KJa+W1U
 z632NguZ2d7Frh5DzNBc05ROBwYrhFTE8lbmrP56tsXT2ods7bQJlPearlZv/q6GVbUrgfaZW
 RXfL7QQOuD+Keid/f3yNL8pIRtAKme6VRvvaSKVGPUHJIceYayL8iKSgBIXI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 4 Nov 2019, Junio C Hamano wrote:

> * js/builtin-add-i (2019-08-30) 11 commits
>  . built-in add -i: implement the `help` command
>  . built-in add -i: use color in the main loop
>  . built-in add -i: support `?` (prompt help)
>  . built-in add -i: show unique prefixes of the commands
>  . Add a function to determine unique prefixes for a list of strings
>  . built-in add -i: implement the main loop
>  . built-in add -i: color the header in the `status` command
>  . built-in add -i: refresh the index before running `status`
>  . built-in add -i: implement the `status` command
>  . diff: export diffstat interface
>  . Start to implement a built-in version of `git add --interactive`
>
>  The beginning of rewriting "git add -i" in C.
>
>  Expecting a reroll on top of a base with the tg/stash-refresh-index
>  topic that defines an updated repo_refresh_and_write_index() helper.
>  cf. <20190911175201.GA11444@cat>

I sent out v5 in
https://public-inbox.org/git/pull.170.v5.git.1572869729.gitgitgadget@gmail=
.com

Thanks,
Dscho
