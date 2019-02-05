Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E63E1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 11:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfBELb7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 06:31:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:54495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbfBELb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 06:31:59 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQQzk-1ggz4e2ST6-00Tn1M; Tue, 05
 Feb 2019 12:31:52 +0100
Date:   Tue, 5 Feb 2019 12:31:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: make the OSX build jobs' 'brew update' more
 quiet
In-Reply-To: <20190204193826.GH10587@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1902051229570.41@tvgsbejvaqbjf.bet>
References: <20190202163421.19686-1-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1902041045280.41@tvgsbejvaqbjf.bet> <20190204193826.GH10587@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1499051297-1549366316=:41"
X-Provags-ID: V03:K1:kYTF/q3VHZnbbQFAnB7T1lhPb3vD6i9rR32kOUpmgFKzfxUdiWa
 snwOsmczA+uF43EePye5ZwFboB+R/uKv3eqZ76ynqLmTF9W8tuzzYlVy54Rg+1p57BcMQ27
 7NVskHjao/uprXaQuNr6IztcbD2zSVSOVVAY84fKOsOExBey71vvhn2qddTGhmURtA3BbRG
 3jPeaAQXXdH9Qk3OGzofw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HjzP8fdMdqc=:MuBxHmIdy8vr4S4Ji0B/Yt
 9NKILQcRLDqlKPLJRk1ZPsNK1z1XMVetLFsWc9gUyj96qqhNDzcMXrc3sczF6VuNgIpS5uMnu
 zYER/lhVkBKbgs/CfhUSveqORXmG20hvDP7/ezs1tlJFoqojO2bj/ElpPu128nlz5aXCzYrBj
 OcSoqONq3BKQHHWty6uVWSn+FsA7kl9c3PFsLXBd5CippecQg91zp6qpumzH0uWgD/mDGQsRx
 egySQkX7TcDT41MtRfeR0LBEVOM61fKgc50jYJSayxy8wElkWXYcvKOkwVdgToi2fUl2ZzqaR
 8HcdttOoKwTF42shfKaPN5X81sZ9iBfPmErpzert/RseDW31++HM26u/F3sU4AkcGwAOm6s91
 p3Ei6ojPxqaod4PsFBcp7gy42z65Y+11IaCVuIFTrfWbEVb+SMTqNyZld6Vv0ck23TyG42iUy
 h0TUsb0N8ho6NZVnGSY4D8K1dyCkIgiRAJTGgCl9Ro7ZYQuSM/1T8LvR6wqrbzKXDwPJxH1sb
 gvM4cwxYn6czmmG6HqUkCt1oN3gmGfUuLUYZVtXTcnRxYN4zsaggEyuznkO1VUpR3ksiM5rue
 3w6Vz3IzVV1WOk8cGlg7abNWI9pQ/88p90FqqxZpM2UTljI5m0boR7QV45kfq5anb1bkEm2SD
 UM/NMnoeKiJac6m0QIm+YhMAeQ3qFIPTN0+LZNqWMlEV9k6N1We+rCL2/nn3MiDL/wTAzElnb
 paZt6Uo94tyX+n8WluZyjzvjfP8fr1+WobkvRqOD9Uc+dFycfVeGYX5F89Rm3qETOPKs8PWpp
 Df9PKcnVWFfQAyqG6+PpEM2sT/jdTdPpkpgtlShRVvVDZUZNS+o+pQGiAccLEqJl3LoVOlx78
 6dAp7ZQFxdJIAry4X0UIVMoNw8mmEAmA7lYxGd2YA7/x/T32rBJ4h5CGCPy/DDW0g1Kw3fgvZ
 Tn/YyWlDR+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1499051297-1549366316=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Mon, 4 Feb 2019, SZEDER Gábor wrote:

> On Mon, Feb 04, 2019 at 10:49:05AM +0100, Johannes Schindelin wrote:
> 
> > So our best bet at not getting overwhelmed with failed builds ...
> 
> Oh, in my long-time for-fun semi-automated CI experiment [1] all
> integration branches and cooking topics are still just fine :) they
> all have been including this patch (among many others) for quite some
> time now (since when the list of available Homebrew packages was
> "only" about 1700 lines... about a year ago).
> 
> Unfortunately, I never upstreamed it, because that long list of
> packages is folded up anyway when viewing the logs, so why bother...
> In hindsight, I should have.  Oh, well.
> 
> [1] https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/branches

Heh, I feel ya. 70 branches in Git for Windows' patch thicket are waiting
(for the most part) to be upstreamed.

> > is to help Homebrew get `brew update --quiet` to work again. I just
> > opened a ticket to that end:
> > 
> > 	https://github.com/Homebrew/brew/issues/5666

And this ticket has been closed with a fix! Yay! I checked, and on Travis,
`pu` is now only broken for the FUNNYNAMES issue in Elijah's t4038 that I
already reported.

Ciao,
Dscho
--8323328-1499051297-1549366316=:41--
