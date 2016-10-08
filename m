Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7887E207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 08:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755137AbcJHIhK (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 04:37:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:52245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753343AbcJHIhG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 04:37:06 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LrNoG-1as0Qx1CeK-0134g7; Sat, 08 Oct 2016 10:36:44
 +0200
Date:   Sat, 8 Oct 2016 10:36:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
In-Reply-To: <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1610081034430.35196@virtualbox>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610071319520.35196@virtualbox> <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com> <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
 <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:akLzXfXZDkdbIjoLpWHxbtaAJWimeOAsuFWnlV2YHpyIV4cFVgw
 rllDAcHg3dptfheYyBOuafBRcdI9blspB1RzF2KmgQewEixWn1P7y4puHS4z0DghvH/PK7w
 z1gzQ+hwabuVhTLmdLxjYg8NfBFqOXxn7A0uPCI451bWFvo0GClMEN+N40foc4MGuhNEEM/
 0bsRTLNnz6uZtZsunAOLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ip4YIlXOHRE=:9mRnEADR49ng2CoCEFkYuM
 ciEz4oT2h/nuTGiINb4If9fCZbA61kWxpffMI8FzOFSR2hfaVWvULh642LFdA3kmyUr6euhtf
 GVF1X2pN+RXf6nZ9oaGlAdxt6bL9d4jPvVesDuILl6YmCh0WNJILbTV7beSOhI3xPSTJzPafr
 7mQwz6GMcGQ71Rj3gvfS+ksO4v8/QzPWIRo5CSAVRvdNu4ghetNWcEuFwKtn0hpcCRTHi1Eiw
 /Q/Y7wCHo0g3VAzwvOgrYWNI/HqZqzCn+zCP2NooKBoXIT1gZJDmVW9LiZYMHXywD9G+RhZsy
 xFa76b9qXPowO7Ga/QeoHak1nDZ2JnUn4ruymiYd7lwfi3UYum3mijIJmbbm51Q+2rl3hyNaW
 UoyUmzKTZLmn9XSu5voRwQqPCibhBZ71ixl8XjO68V/ygdFkzG0OFWzooUKmKeaqitUkCFn1E
 AhrGAUfvLqlNysSxNMDfS3U84gp8b5VYj4ZkyrRmYl84ROhuWu4OyBvf2XrgAGVG7oitjwRhu
 cjpVpLtSVE/VkhCZHkf6VtaYLiArHxgFABY5vOnhdqKibk73/nn7II7ZU47RWx1uggNNxzYk7
 CONSDTfOLuDQcVucp/stfB/zcPyLqADxbmXCwNyZex/7ShnsxRErqAGhR2BQuL2rYl7nI+ArW
 PxaquETfc4gelRFq1NMJbYWo40sReYMVwCC9ljjbNKI7Ac9h8DFDHluTzuzmlpQM6FziANIMf
 wL+uKj1ZM6PNDg1yeeLUuSasSghjS5yFoABAcLgQDDVTIWffOG129gxGpLifLuRho6fLxyIKl
 9WKyyKL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Hannes,

On Fri, 7 Oct 2016, Jeff King wrote:

> On Fri, Oct 07, 2016 at 07:42:35PM +0200, Johannes Sixt wrote:
> 
> > Maybe it's time to aim for
> > 
> >   git config alias.d2u.shell \
> >        'f() { git ls-files "$@" | xargs dos2unix; }; f'
> >   git config alias.d2u.cdup false
> >   git d2u *.c   # yada!
> 
> That would be nice. It would also allow "alias.foo_bar.shell"; right now
> "alias.foo_bar" is forbidden because of the config syntax, which does
> not allow underscores outside of the "subsection" name.

So what about this?

	[alias]
		d2u = !dos2unix
	[alias "d2u"]
		shell = 'f() { git ls-files "$@" | xargs dos2unix; }; f'
		exec = C:/cygwin64/bin/dos2unix.exe

You introduce all kinds of ambiguities here that did not exist before...

Ciao,
Dscho
