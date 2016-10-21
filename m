Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6434D20987
	for <e@80x24.org>; Fri, 21 Oct 2016 13:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932861AbcJUNLC (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 09:11:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56558 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752343AbcJUNLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 09:11:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u9LDAaOW030440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 21 Oct 2016 15:10:36 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9LDAb2A015111;
        Fri, 21 Oct 2016 15:10:37 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Drastic jump in the time required for the test suite
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
        <CACsJy8ALRjnvgM6sW5ioFHtquSR6zgQHkQ6-LUnKFnqXV9eDCQ@mail.gmail.com>
        <e0e320ce-14a1-b4a8-aa07-6bc4f3c4a424@web.de>
Date:   Fri, 21 Oct 2016 15:10:37 +0200
In-Reply-To: <e0e320ce-14a1-b4a8-aa07-6bc4f3c4a424@web.de>
 (=?iso-8859-1?Q?=22Ren=E9?= Scharfe"'s
        message of "Thu, 20 Oct 2016 18:40:18 +0200")
Message-ID: <vpqd1itdf02.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 21 Oct 2016 15:10:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9LDAaOW030440
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1477660237.83414@4S+7jaWiHMPV7cj/Um3Rrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> I get this on WSL with prove -j8:
>
> Files=750, Tests=13657, 906 wallclock secs ( 8.51 usr 17.17 sys + 282.62 cusr 3731.85 csys = 4040.15 CPU)
>
> And this for a run on Debian inside a Hyper-V VM on the same system:
>
> Files=759, Tests=13895, 99 wallclock secs ( 4.81 usr  1.06 sys + 39.70 cusr 25.82 csys = 71.39 CPU)

What about the same without WSL on windows?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
