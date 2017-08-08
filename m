Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E0C20899
	for <e@80x24.org>; Tue,  8 Aug 2017 12:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbdHHMLg (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 08:11:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:56967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752064AbdHHMFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 08:05:16 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Li1hG-1dJRwR3sGI-00nByR; Tue, 08
 Aug 2017 14:05:14 +0200
Date:   Tue, 8 Aug 2017 14:05:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC] clang-format: outline the git project's coding style
In-Reply-To: <20170808012554.186051-1-bmwill@google.com>
Message-ID: <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
References: <20170808012554.186051-1-bmwill@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PQ+VX1m/qUTJYRPuqhJ8dGb14rhHDef0ZW7cfBI2Z5YIkWrkW35
 TPyczhbJrZovnTbVvPO6bHHmYVemUhBzTzmZnCpkUxI19XOBsM3VIp49reiyfxcWL2Mmk4x
 7vlZRQDd37c5z5DtMsgv/Cig7HewCxaZWOi8hkZT5hgj5pLHzRbv83esooc589tptDazWpK
 xzuOV4NTJ8fUb/CD7+PHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gqQDkirF7Z8=:FH3FNGQ/Fd+Qil8HL46Ry/
 GKrkehFQbRSJqYu5wfmvfPsviPG/wmLhmG+NsIakGozy9bE+NnS+nj282ashsSz1Hv/HDwEQZ
 t2WYc8o6NYec0Kg8qUANfw6J6f2uOKnizrpk5rBDxcou/nwi/M02MvfIoaijO52jPwqb5H5uy
 583xz70Mjq9M4MpVcvPsXnBbgdB3+5kq1w0dN04pFcS0kIvGOQF5FwH1EcwqInClDlKqxSYGE
 1wlEzL3ww+rcTSLRv6saDysyzXMXhfQPdcISmnCquYtQivog3EgzpvWazUV435U2Z44gEBL8M
 ydBWD5ZTS7dx8eCLom04U1nI//Fj+IUFC5QStElwqJNwn7fFEnCju/AJ5X1etfPdwdi9iCXUB
 WHa1KZ52gNEB+ACrjf2qxBfVyvEmgxI0s7Vzn5RflVXhyRBrhN10Pugfo4XAiEpxW9Ka4pamC
 GUSZihs/XnOlfqkIbQlf0Ls6csODGF7qzSSiqxOGlbQfgNnLN2CxCQ9ay8jKDO1elmtQ7UKlA
 +a1F1bEmJEuqt582FOjACC8r3lmjleIeXLev3MpLblz/lihABfuM+GOXgktITB3e7UFmDlvQw
 B8WNIZH5Z+6Begf3o6SnmaNhCR+z5ShfYNRsWCql17s4TH/P53YSOObfdtXmGvvZv+NGfrtRB
 5/lf8WhgrNrs/O5mMHd8nJd0JLXaHamygh8KJYo1FT0k179hYI4eBjF37RUTt7h7lOXYoX/ZI
 4X7diSPYcvtTLL0VKHBi9WiHq3MyTI8AlgQswWi2oQwE2ObUs/tfGJH0gR42Zb2rOx6d40xyX
 r5lNMlrz8B7m+AmtUPF2e7j0bcsa0Ay5XprvcbXEK6ZvPw7O7Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Mon, 7 Aug 2017, Brandon Williams wrote:

> Add a '.clang-format' file which outlines the git project's coding
> style.  This can be used with clang-format to auto-format .c and .h
> files to conform with git's style.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
> 
> I'm sure this sort of thing comes up every so often on the list but back at
> git-merge I mentioned how it would be nice to not have to worry about style
> when reviewing patches as that is something mechanical and best left to a
> machine (for the most part).

Amen.

If I never have to see a review mentioning an unwrapped line, I am quite
certain I will be quite content.

Ciao,
Dscho
