Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15DB21841
	for <e@80x24.org>; Tue,  1 May 2018 11:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbeEALEk (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:04:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:49133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753856AbeEALEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:04:38 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjdS8-1ecCNq2Pc0-00bbf8; Tue, 01
 May 2018 13:04:14 +0200
Date:   Tue, 1 May 2018 13:04:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t1406: prepare for the refs code to fail with
 BUG()
In-Reply-To: <7087f0b9-1362-f8ca-315d-96d27b91b26b@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1805011257400.79@tvgsbejvaqbjf.bet>
References: <cover.1525040253.git.johannes.schindelin@gmx.de> <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de> <7087f0b9-1362-f8ca-315d-96d27b91b26b@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UUqpTBjWEmqycMcNO9aJnAW7lzXt1LGxjF/Jt90u6j31lD8t97g
 rZHMc6haTKTDpQyAp5c65gem6ngU+YzRGg29o2+Pgsms3BTlGr2h6l+EGNQQRS9z1XsXvLE
 V9wO5EHpPbY+sU7tCMnSRWGHj8bfdK8zRwpYdQ2jd2YcXO9BUwR8k2+MJwoYY4wVhaO+I5y
 RuWThJweQNS2s9NravlOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EcTtGSuiytM=:2IIsKy8jLHrMk3+YJIeNcG
 13FR0fo/ODP6sh4+q9hK0TX6WiJanMPf9eCnmZHWBGW3akxpuFn4ZYnkDIN1th0uKc63TbN4F
 DV4YAahUghwjC/tP5hkm3TdwBdwKXRNBET6fx39f4dhv1z6BctG2abcsVEMuJrj9w83h+8bEw
 FmJuzif8wOpPgA64rBP6oMCBaqa3vHkjlMUFxGxnSSH+QXLr2C9hb06/ccBRO5aWS5YzQMtAZ
 1PG1KkYjhsalHzi4/oR7BMZKTiiROI08RfLL+xcbPrdexyP4H2jdNc3IVFNUeGiICk1z/9P1k
 YEZxZE8qiXW+LGnCZqshvwrzwQ298asWWpN7+4i6RBklLpgqd/HvzM8qf1pxu/g3d8MGZLWsA
 n53jywWIdBg9xnmNlAWCVWopsKW7hc/N6weaq3y8JrVhlK+JRRjBtGelP5AzOVE8R7CdvX2gn
 Da8J/pURPYTvEb48w81sa1KacOG+ENkpvm2z8Kzu/ENuepMEkrjo6gEgpwcqPtk2MnCLkGd8g
 +OQm4HvJx3rGBZGyDFTe0dST6k+XRSY5bOihAHYmElbtJBadalwQgVBf/TULftPMyxoD/02aR
 d9Qnizk8kxNW7NaCmmIt0D8IGFmNCkBfra6+6Dizt5ZCRd0FBpzDZrJNKdzVQNV/ucV/YDZa6
 /csT/HKasYgLAvhd62vrnun8Y76yxIK5pA9D0NS29GbVA/s9iLUCZC+Os8e8GPwyM865VjpEt
 TfpLkXmQiFmUeLTP+0UHm+Wi1wGfgaphud/p46plcMe7pdByVVUtdSziZHXS+PynHcFXhRdoD
 uQYJejt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 30 Apr 2018, Johannes Sixt wrote:

> Am 30.04.2018 um 00:17 schrieb Johannes Schindelin:
> > t1406 specifically verifies that certain code paths fail with a BUG: ...
> > message.
> > 
> > In the upcoming commit, we will convert that message to be generated via
> > BUG() instead of die("BUG: ..."), which implies SIGABRT instead of a
> > regular exit code.
> >
> > [...]
> >
> >   test_expect_success 'create-reflog() not allowed' '
> > -	test_must_fail $RUN create-reflog HEAD 1
> > +	test_must_fail ok=sigabrt $RUN create-reflog HEAD 1
> >   '
> 
> I can't quite follow the rationale for this change. A 'BUG' error exit must
> never be reached, otherwise it is a bug in the program by definition. It
> cannot be OK that SIGABRT is a valid result from Git.

I thought so at first, too. However, what these test cases run is not Git
itself. Instead, they run a t/helper/ command *specifically* designed to
hit the BUG code path, probably to ensure that bugs in future code will
actually not be silently ignored, but do exit with an error.

> If SIGABRT occurs as a result of BUG(), and we know that this happens for
> certain cases, it means we have an unfixed bug.

Not in this case: The code in question is in
https://github.com/git/git/blob/v2.17.0/t/helper/test-ref-store.c#L190-L201
and it is called in a way that fails to have the required flags for the
operation. This would normally indicate a bug, but in this case, that is
exactly what the regression test tries to trigger: we *want* such a bug to
cause a failure.

I'll do my best to clarify that in the commit message.

Ciao,
Dscho
