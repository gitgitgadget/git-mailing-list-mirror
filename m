Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210101F403
	for <e@80x24.org>; Wed, 20 Jun 2018 11:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeFTLZy (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 07:25:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:55507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbeFTLZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 07:25:54 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt1eU-1gB0oH24Wg-012WkL; Wed, 20
 Jun 2018 13:25:51 +0200
Date:   Wed, 20 Jun 2018 13:26:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Frank Li <lznuaa@gmail.com>
cc:     Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
Subject: Re: [msysGit] Possible git status problem at case insensitive file
 system
In-Reply-To: <AANLkTi=87fUaOH3Y0PVeeH5N7oCVVJyKY3jsf93jw-t7@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806201323150.11870@tvgsbejvaqbjf.bet>
References: <AANLkTi=87fUaOH3Y0PVeeH5N7oCVVJyKY3jsf93jw-t7@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xtPPyzt771/WZILlYosGYkW6maXdjwBz3H+P6rlGKGaqGdwkdF/
 2Rsl3zEIySCcR2zvvl/tzw84203Tzf9YXLsFRZkklgbucH2n5z14XnECU1R8ZPfObfJlFyd
 EqD3sm45lSxAJg7+D0TPwmiz9QibhCUC75QAMtP7rrZqtu+KcVIQ+bINhK45DFunItF1AHJ
 BqVsTOTt3kjtmOH9UA8aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pj5/cj4wKQ4=:S725ffuuKEdbXcSmikfA0l
 Lxjh77QVatiDPbvQzBOWV71awYAnNJhu6x7yvv3eBRGOp+0RGeqi4mmnEr/uPle1ZLU6N8yJl
 pSU+EK65yGzTPd/NqtQnEd6NL6Pgl+C/tkZRS9MXA+6KjZoeP6hMSUEK9GIQmO01ZiXrbFUTp
 8x5yWLGqtEfZZOQsF1pKU9rr3Bfz0ZmCaWhDhwRR5DZsduQUdXzFqTTVEVOhHW71UU3ycFSIE
 TOaoaqYqQyfrZaFHelrbxLdaKxB9cbaOOoXXln+olo6UwqPccwHjC2/a/1meF7h0jREZ3KIao
 hy26oidFh4+ting6bbf5jjZK+8/5ApEDXL1bhWZ6Coyu6101vQcoybzF5XKtJ6RcCiIs6+2Sr
 ChM2O/zE1AlwfxbTwDAAzTyNX8pgqQlErfkUE51FLlqF6Pnkazh9d7Xvq4D8iKvphSSIg4hF1
 EXIgxTVG3RjKWBMzNi7SlB9fhao69MC59p+8RWSph2v42iKkbDHl7I4+Y99yjipm6D57IE8bK
 FMSFN+qTJlkOE8/Lut2CjtpJ0oyCGikk76Qr3bTdYbLzpyLRsBGkmZpeDa4hj4d5kFUBgs9UK
 3urCF3/6mUpSPtokF2wjk5Nu9GTBuXJOE7rCrmD+ThyWCRuD0IhhzsaBXW+V6FfqoTRue9y/6
 L2D01Fu7+dFaRmMs289OPhplH2xtfQFC9WSuyav4V32ZZphLoNDb8G9r41bR9G+pMuZzup/sc
 jj7Oq3zcy1Ua323hV3rfd3cjY3jq2on0DPjWU0nYb27yGrPkFiio0tugwKzOQTIoDnLIdZN32
 hulwx1U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Frank,

On Mon, 9 Aug 2010, Frank Li wrote:

> All:
>         I use msysgit 1.7.0.2 at windows xp.
>         Problem: git status will list tracked directory as untracked dir.

That is the *least* problem you have with that version: you are vulnerable
to several security issues.

Sadly, there were literally zero contributions from community members
using Windows XP to uphold XP support, so the latest Git for Windows you
can use (unless you build it yourself, fixing several compile issues by
now) is v2.10.

See https://gitforwindows.org/requirements.html for details.

Ciao,
Johannes
