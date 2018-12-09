Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E12B20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 20:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeLIUby (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:31:54 -0500
Received: from mout.gmx.net ([212.227.17.21]:37513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbeLIUbx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:53 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVayZ-1gxjlD1nqh-00YvOJ; Sun, 09
 Dec 2018 21:31:48 +0100
Date:   Sun, 9 Dec 2018 21:31:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: pw/add-p-select, was Re: What's cooking in git.git (Dec 2018, #01;
 Sun, 9)
In-Reply-To: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1812092101570.43@tvgsbejvaqbjf.bet>
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MNfIqRm8OKjTnFythDdqJ8yOpecp0Yt2Z1uUCORvjOQE8UPGGsy
 6/WdGUiloZFtV2uYliTI6I/s6wzlDsy9l+9C2sPQvko6NV9oOtIQYUgWGM1zeDoNUti3lLw
 1wa9T/8gXM28LjQFJyZc6Oa5K7LrgBFs71khHDr4qZtAeLH6STaKqlBKx+rP7ERg+U+22Kl
 oqDnWe+UiVmpgm3xTvAKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qlAIO1QIpuE=:tyJsuy0QiNI5O+XNDW1HRX
 WVfGtXhflR+5L/11i/+m4X7XdFO5ZFOlswI4YrW413ji92RqXZHnMEZV71ziMSv4sn18KDBCK
 qTzmavhW+KAsRu6ZJe3LXns1c+kmqBpnik5bTd84hpn6f3VTSelZFUrL+K2+4B9XT1tj265QQ
 rbUf1yi5S+DAfq/eoghRNSodObQNENxTTpS3nnwr5r0GLjyWWGBUW2jKiVw2jOz9dOEJmqFIo
 laloVevYLw9ZgDYXc4IfWUJrAHT/IdSrS2+3+PwuW+dHBX/tzRlYaukB/IbRc5TDZjWDN+gdU
 oFoJt+UYO5qY1PRE/Ywak4uzpLIfVivezmGK8h3aYao1qVXxKCxGltdPDt7TGfM38b5q/2KkU
 HoksaXwckJD7vWq97/AVf2+UO5XsBBaxqYFuXHwXJKWv0eT4rpxk688pvjmcCBOK/nfAiQHMi
 okU24uWrBojNnxl58fze0zbOuvkolNK+rRzHGELckNNdrKeIAH3P9yeX579pg49KBhHNgUjLh
 z0TAnmGXvVed5wuRFvLmLVisUCxBaLVO+fh+4hlQsyxRNZn2MNKK+Ierff8Y51KKeyzplqY9+
 gJoK+lIfs+Ayb7ZQ5dY4wP+SxAT/UfyKYl8XmVF01QYdv0FXCqytvUXPyghWU9HbHi9IC2SGK
 RZyGtIGeOhlDxHqiW/u/c/urN7ggNAxaqKb+Tev2XvKhO4Y4M2UiRcvnXYZK0OCkNm8A2msD5
 OmRgSkzJmpcB+oHBHKG1cpAQ52Gd8nwIkPhl0wSvMZ3+iXqlJMIqF4qMo+UjVE8Hh9tkNYIeA
 7L5T/afTyISVw9VArzg+sLf4xtJKT8FabcgT36v1n/9u6I398vHhMScvjRzfdnH/9XN7d4CqN
 9utZCyb03XLdfeVZ+oE37LmHhdVrWgLxj4Nu5CxBTwMcn8MuD8aV9fev2GmTvg1Of3xoYaKUR
 KXH9SLLTwRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 9 Dec 2018, Junio C Hamano wrote:

> * pw/add-p-select (2018-07-26) 4 commits
>  - add -p: optimize line selection for short hunks
>  - add -p: allow line selection to be inverted
>  - add -p: select modified lines correctly
>  - add -p: select individual hunk lines
> 
>  "git add -p" interactive interface learned to let users choose
>  individual added/removed lines to be used in the operation, instead
>  of accepting or rejecting a whole hunk.
> 
>  Will discard.
>  No further feedbacks on the topic for quite some time.

That is not quite true. I did comment that this feature (which I take as
being inspired by Git GUI's "Stage Selected Line"), and thought that it
would be useful.

I could imagine, however, that it would make sense for `git add -p` to
imitate that feature more closely: by allowing to stage a single line and
then presenting the current hunk (re-computed) again.

Ciao,
Dscho
