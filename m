Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAC11F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeJXQGJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:06:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:52909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbeJXQGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:06:09 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJBn4-1gHyuP2Imo-002nCn; Wed, 24
 Oct 2018 09:39:07 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJBn4-1gHyuP2Imo-002nCn; Wed, 24
 Oct 2018 09:39:07 +0200
Date:   Wed, 24 Oct 2018 09:39:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Slavica <slavicadj.ip2018@gmail.com>, git@vger.kernel.org,
        Slavica <slawica92@hotmail.com>
Subject: Re: [PATCH 1/3] [Outreachy] t3903-stash: test without configured
 user name
In-Reply-To: <xmqqd0s0qcuv.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810240938310.4546@tvgsbejvaqbjf.bet>
References: <20181023162941.3840-1-slawica92@hotmail.com> <xmqqd0s0qcuv.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/p4xUn4hPm0C95euDW9X7Sr1J4VMNgjwYrTx17+hsqnQE1mIk4T
 iwukEBWnX49JAYm/9KFG3HMr2Fy1SIZq1fjNzReoilyRhkQccip8ED6+cI86BZhFFyA2C3w
 5kKlTiUjl4OKG8cmaZhM6SYL/yDDElG8FvEDimhOEvF6jgW1lx5d3rMB7sZHqWEHs9cvVGh
 WSguIF8xWXwofj1EwTvVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EcvEFDak6HU=:3KW0grOIPqgiVzUGlUAFEP
 GEVN2K6B1JLKD3W2ZfwtsaqSwIi+Z6THKGX4CDz3j8Uh4hXD1qRk141PvLzVP9Jc3/G8NliDA
 JVO1LnNN/nz8kS3J+8AiLimD47I06GAjDvJRT0xZ29THycq2slcsiTZeRRb6vq861loVJK0Kw
 8B+p4y+za0IT+wBTfxTgEOLtfO9zRZs7fOCp/7fE2HjDNbjuJsTSW7ra0HHyJ+dQhxzsCRURI
 A0CNahH6gB4h7MVpuAkG1KiEmX3SWsbJznNsM+cT2P3tD822elqxyOPDg76WdudpRtpbCuZOu
 RoiorW5pNQZIYod+jKdeIGor2sW5KkRRRRGkP8cKqoUtoPeGNZNC35cI4OEx9m2wNWj1FDdDG
 q2k15B7veQVLxZiuItCaEpmtnTWSqkAsbpbpZIwJjor3klxRsnTj0IDi3Dvalq0xCpXygBEVM
 Rj0FJ9z31HLX+IeoQz4iOIBWOO7CQwIkSEBC5FnD98Aqe17/OrR9vh8lPQVpUWBNvhyhfzkwB
 btrIXv1nXeA2f+WpuvE8Yy3a6/5xxqadPLaPMAwGYI0Luz7njB/M8q5trtH5Z67mePcGUNKpq
 CfAYgdHDax/Al+Lttn76D4t5KlXD9sndAx+0fUu0btbv1mh9LYxraA8xIwcZhUqLG2UworGrx
 hSF9+RvDV3mv/Q1xYt+gLZ/EOc4XBXBH4Tm3tUTAaWYakTInMQsrhm/RdbnR3R/Xy/Tw2FnhI
 fn1BeS6dTqGv9KRJHxpfgdGiPxt7FC7TkByLiPBpeyxXJka1iuRSQLY+kIiekz2dfkyLOcnGq
 zW8S681VWvw+62gpLhABVcjLF0BoLvrMuFEj38tIMYMwATvkdI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Oct 2018, Junio C Hamano wrote:

> Slavica <slavicadj.ip2018@gmail.com> writes:
> 
> > +test_expect_failure 'stash with HOME as non-existing directory' '
> > +    test_commit 1 &&
> > +    test_config user.useconfigonly true &&
> > +    test_config stash.usebuiltin true &&
> > +    (
> > +        HOME=$(pwd)/none &&
> > +        export HOME &&
> 
> What is the reason why this test needs to move HOME away from
> TRASH_DIRECTORY (set in t/test-lib.sh)?

This is to make sure that no user.name nor user.email is configured. That
was my idea, hence I answer your question.

Ciao,
Dscho

> 
> > +        unset GIT_AUTHOR_NAME &&
> > +        unset GIT_AUTHOR_EMAIL &&
> > +        unset GIT_COMMITTER_NAME &&
> > +        unset GIT_COMMITTER_EMAIL &&
> > +        test_must_fail git config user.email &&
> > +        echo changed >1.t &&
> > +		git stash
> > +    )
> > +'
> > +
> >  test_done
> 
